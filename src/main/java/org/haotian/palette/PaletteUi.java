package org.haotian.palette;

import android.app.Activity;
import android.content.*;
import android.graphics.*;
import android.os.*;
import android.view.*;
import android.widget.*;
import android.window.OnBackInvokedCallback;
import android.window.OnBackInvokedDispatcher;
import java.lang.ref.WeakReference;
import java.lang.reflect.*;
import java.util.*;

/** Host/lifecycle adapter only. Views, resources, popup and slider drawing come from the donor. */
public final class PaletteUi {
 private static WeakReference<Activity> current=new WeakReference<>(null);
 private static WeakReference<Panel> opened=new WeakReference<>(null);
 private static final Handler MAIN=new Handler(Looper.getMainLooper());
 private static float downX,downY;
 private static long downTime;
 private static boolean paletteTapCandidate;
 private static final java.util.WeakHashMap<View,Boolean> hiddenVideoPickers=new java.util.WeakHashMap<>();
 private static final java.util.WeakHashMap<Activity,WeakReference<View>> pickerCache=new java.util.WeakHashMap<>();
 private static int displayedMode=-1;
 public static void refreshPicker(Activity activity){
  int actual=ProMode.current();if(displayedMode!=-1&&displayedMode!=actual)closeForModeSwitch();displayedMode=actual;
  Panel panel=opened.get();if(panel!=null&&!panel.closed)for(View hidden:panel.hidden)if(hidden.getVisibility()==View.VISIBLE)hidden.setVisibility(View.INVISIBLE);
  WeakReference<View> reference=pickerCache.get(activity);View picker=reference==null?null:reference.get();
  if(picker==null||!picker.isAttachedToWindow()){
   int id=activity.getResources().getIdentifier("v9_camera_picker","id","com.android.camera");
   if(id==0)id=activity.getResources().getIdentifier("v9_camera_picker","id",activity.getPackageName());
   picker=id==0?null:activity.findViewById(id);if(picker!=null)pickerCache.put(activity,new WeakReference<>(picker));
  }
  if(picker==null)return;
  if(ProMode.isActive()){if(picker.getVisibility()==View.VISIBLE){hiddenVideoPickers.put(picker,Boolean.TRUE);picker.setVisibility(View.INVISIBLE);}}
  else if(hiddenVideoPickers.remove(picker)!=null&&picker.getVisibility()==View.INVISIBLE)picker.setVisibility(View.VISIBLE);
 }
 private static void proVideoPicker(View v){
  if(v.getId()!=View.NO_ID)try{if("v9_camera_picker".equals(v.getResources().getResourceEntryName(v.getId()))){if(v.getVisibility()==View.VISIBLE){hiddenVideoPickers.put(v,Boolean.TRUE);v.setVisibility(View.INVISIBLE);}return;}}catch(android.content.res.Resources.NotFoundException ignored){}
  if(v instanceof ViewGroup)for(int i=0;i<((ViewGroup)v).getChildCount();i++)proVideoPicker(((ViewGroup)v).getChildAt(i));
 }
 static View find(View v,String name){if(v.getClass().getName().equals(name))return v;if(v instanceof ViewGroup){ViewGroup g=(ViewGroup)v;for(int i=0;i<g.getChildCount();i++){View hit=find(g.getChildAt(i),name);if(hit!=null)return hit;}}return null;}
 public static void refresh(View root,Activity activity){
  if(root==null||activity==null||activity.isFinishing()||activity.isDestroyed())return;
  if(Looper.myLooper()!=Looper.getMainLooper()){MAIN.post(()->refresh(root,activity));return;}
  if(!activity.getClass().getName().equals("com.android.camera.Camera"))return;
  current=new WeakReference<>(activity);PhotoOnly.init(activity);
  if(ProMode.isActive())proVideoPicker(root);else{for(View v:new java.util.ArrayList<>(hiddenVideoPickers.keySet()))if(v!=null&&v.getVisibility()==View.INVISIBLE)v.setVisibility(View.VISIBLE);hiddenVideoPickers.clear();}
  View strip=find(root,"com.android.camera.ui.ModeSelectView");
  if(strip!=null){strip.setOnClickListener(null);strip.setOnLongClickListener(null);strip.setLongClickable(false);}
 }
 public static boolean modeTouch(View view,MotionEvent event){
  if(ProMode.isActive())return false;
  // ModeSelectView can be inflated after the Activity callback. Resolve its
  // actual host and bind on DOWN instead of depending on a toolbar poll.
  Context context=view.getContext();Activity a=null;
  for(int depth=0;context!=null&&depth<16;depth++){
   if(context instanceof Activity){a=(Activity)context;break;}
   if(!(context instanceof ContextWrapper))break;
   Context base=((ContextWrapper)context).getBaseContext();if(base==context)break;context=base;
  }
  if(a==null)a=current.get();if(a==null||a.isFinishing()||a.isDestroyed())return false;
  switch(event.getActionMasked()){
   case 0:refresh(view.getRootView(),a);downX=event.getX();downY=event.getY();downTime=SystemClock.elapsedRealtime();paletteTapCandidate=selectedLabelHit(view,event);break;
   case 1:if(paletteTapCandidate&&selectedLabelHit(view,event)&&Math.abs(event.getX()-downX)<24*a.getResources().getDisplayMetrics().density&&Math.abs(event.getY()-downY)<24*a.getResources().getDisplayMetrics().density&&SystemClock.elapsedRealtime()-downTime<ViewConfiguration.getLongPressTimeout()){final Activity owner=a;view.post(()->{Haptics.click(view);show(owner,false);});}paletteTapCandidate=false;break;
   case 3:paletteTapCandidate=false;break;
  }
  return false;
 }
 private static boolean selectedLabelHit(View v,MotionEvent event){if(v instanceof TextView){String label=((TextView)v).getText().toString();Rect r=new Rect();return (ProMode.isActive()?label.contains("专业"):label.contains("徕卡一瞬"))&&v.isShown()&&v.getGlobalVisibleRect(r)&&r.contains((int)event.getRawX(),(int)event.getRawY());}if(v instanceof ViewGroup)for(int i=0;i<((ViewGroup)v).getChildCount();i++)if(selectedLabelHit(((ViewGroup)v).getChildAt(i),event))return true;return false;}
 public static void closeForModeSwitch(){if(Looper.myLooper()!=Looper.getMainLooper()){MAIN.post(PaletteUi::closeForModeSwitch);return;}Panel panel=opened.get();if(panel!=null)panel.close();}
 public static void show(Activity a){show(a,false);}
 public static boolean professionalStyleClick(View view){
  if(!ProMode.isActive()||view==null)return false;
  try{if(!"popup_left_tip_image".equals(view.getResources().getResourceEntryName(view.getId())))return false;}catch(android.content.res.Resources.NotFoundException e){return false;}
  Context context=view.getContext();Activity activity=null;
  for(int n=0;context!=null&&n<16;n++){if(context instanceof Activity){activity=(Activity)context;break;}if(!(context instanceof ContextWrapper))break;Context next=((ContextWrapper)context).getBaseContext();if(next==context)break;context=next;}
  if(activity==null)return false;Haptics.click(view);show(activity,true);return true;
 }
 static void show(Activity a,boolean pro){
  // The standalone long-press panel remains hidden in Legendary mode. Native
  // professional photography now explicitly owns the complete donor style UI.
  if(pro&&!ProMode.isActive())return;
  Panel old=opened.get();if(old!=null){old.close();if(old.pro==pro)return;}
  try{Panel p=new Panel(a,pro);opened=new WeakReference<>(p);p.open();}
  catch(Throwable e){PaletteDiagnostics.event("NATIVE_UI_ERROR "+android.util.Log.getStackTraceString(e));android.util.Log.e("HaotianPalette","Original UI binding",e);PaletteEngine.notice("原生调色界面加载失败，请保留日志");}
 }
 static Object call(Object target,String name,Object...args)throws Exception{return OriginalUiRuntime.invoke(target,name,args);}
 static void field(Object o,String n,Object v)throws Exception{o.getClass().getField(n).set(o,v);}

 static final class Panel {
  final Activity activity;final OriginalUiRuntime donor;final ViewGroup host;final View root;final boolean pro;
  final int[] values;int filterId,filterDegree;NativeFilterUi filters;final ArrayList<View> hidden=new ArrayList<>();final ArrayList<View> selectors=new ArrayList<>();
  final int[] order;final int[] label={0x7f141484,0x7f141485,0x7f14147f,0x7f141480,0x7f140f39,0x7f141481,0x7f141486,0x7f141482};
  final String[] icons={"ic_manual_picturestyle_tone","ic_manual_picturestyle_vibrance","ic_manual_picturestyle_color_temperature","ic_manual_picturestyle_color_tone","ic_manual_picturestyle_texture","ic_manual_picturestyle_vibrance","ic_manual_picturestyle_tone","ic_manual_picturestyle_texture"};
  final OnBackInvokedCallback back=this::close;
  View card,parameters,slider,reset,indicator;HorizontalScrollView proOverflow;TextView title,cardTab,paramTab;Object adapter,popup;OriginalRecipes recipes;boolean binding,closed;int selected;
  Window.Callback previousCallback,paletteCallback;boolean ownsTouch;
  Panel(Activity a,boolean professional)throws Exception {
   this(a,professional,OriginalUiRuntime.attach(a),(ViewGroup)a.findViewById(android.R.id.content));
  }
  Panel(Activity a,boolean professional,OriginalUiRuntime original,ViewGroup parent)throws Exception {
   activity=a;pro=professional;donor=original;host=parent;values=PaletteEngine.values().array();filterId=PaletteEngine.values().filterId;filterDegree=PaletteEngine.values().filterDegree;
   donor.preparePictureStyle(pro?167:163);
   order=pro?new int[]{0,2,3,1,4,6,5,7}:new int[]{1,0,7,2,3,5,4,6};
   root=donor.inflate(pro?"f5v":"f5a",host);root.setVisibility(View.VISIBLE);
   if(pro)bindProfessional();else bindOrdinary();
   if(a!=null){recipes=new OriginalRecipes(this);if(!pro)filters=new NativeFilterUi(this);}
   // ViewGroup iterates its child array while dispatching window detachment.
   // Removing our title/recipe siblings inside that traversal corrupts the
   // iteration. Release them on the next main-loop turn after it finishes.
   root.addOnAttachStateChangeListener(new View.OnAttachStateChangeListener(){public void onViewAttachedToWindow(View v){}public void onViewDetachedFromWindow(View v){MAIN.post(()->cleanup());}});
  }
  void bindOrdinary()throws Exception {
   View container=donor.find(root,"new_filter_style_content_container");container.setBackgroundColor(Color.BLACK);
   donor.find(root,"filter_edit_panel_container").setBackgroundColor(Color.BLACK);
   card=donor.find(root,"new_filter_style_color_card_view");call(card,"p",0,0,true);call(card,"o",values[1],values[0]);
   call(card,"setOnActiveDotChangedListener",donor.listener("micamx.compat.ui.view.ColorCardView$c",(p,m,args)->{if(!binding){values[1]=(Integer)args[0];values[0]=(Integer)args[1];changed();}return null;}));
   card.setOnTouchListener((v,e)->{if(e.getActionMasked()==1||e.getActionMasked()==3)persist();return false;});
   FrameLayout child=(FrameLayout)donor.find(root,"new_filter_style_picture_style_container");
   parameters=donor.inflate("f5k",child);child.addView(parameters);
   title=(TextView)donor.find(parameters,"style_item_name");
   title.setBackgroundResource(donor.id("drawable","picture_style_item_bg"));
   // The original floating title sits above the selector area. In this host the
   // intervening content FrameLayouts clip that negative position. Keep the
   // actual donor TextView and its typography, but attach it above the panel.
   ((ViewGroup)title.getParent()).removeView(title);title.setVisibility(View.GONE);
   reset=donor.find(parameters,"manual_picture_style_reset");donor.find(parameters,"reset_box").setVisibility(View.INVISIBLE);
   // Keep the donor's actual reset control, but place it in the shared header
   // so both the color-card and parameter tabs have an immediate default action.
   ((ViewGroup)reset.getParent()).removeView(reset);
   ViewGroup header=(ViewGroup)donor.find(root,"filter_edit_panel_container");View add=donor.find(root,"filter_edit_add");
   reset.setBackgroundResource(donor.id("drawable","bg_filter_edit_circle_button"));
   ViewGroup.MarginLayoutParams resetSpace=(ViewGroup.MarginLayoutParams)newLayout(donor.dim("c7n"),donor.dim("c7n"));resetSpace.setMarginEnd(Math.round(8*donor.getResources().getDisplayMetrics().density));header.addView(reset,resetSpace);
   Object headerConstraints=donor.make("androidx.constraintlayout.widget.c");call(headerConstraints,"f",header);
   call(headerConstraints,"h",reset.getId(),7,add.getId(),6);call(headerConstraints,"h",reset.getId(),3,add.getId(),3);call(headerConstraints,"h",reset.getId(),4,add.getId(),4);call(headerConstraints,"b",header);
   bindReset();
   slider=donor.inflate("ez_",(ViewGroup)parameters);((ViewGroup)parameters).addView(slider,0,newLayout(0,donor.dim("e2i")));
   Object callback=donor.listener("Q4.C0",(p,m,args)->{if(m.getName().equals("S8")&&!binding){values[selected]=Integer.parseInt((String)args[1]);changed();persist();updateSelectors();}return null;});
   adapter=donor.make("L9.d",donor,"0",callback);call(slider,"setAdapter",adapter);
   call(slider,"setVibrationStrategy",(Object)null);
   for(int k:order){View item=donor.inflate("f5h",(ViewGroup)parameters);item.setId(View.generateViewId());((ViewGroup)parameters).addView(item);selectors.add(item);bindSelector(item,k);}
   Object constraints=donor.make("androidx.constraintlayout.widget.c");call(constraints,"f",parameters);
   int top=donor.id("id","guideline_selector_top"),bottom=donor.id("id","guideline_selector_bottom"),slide=donor.id("id","guideline_slide_bottom");
   call(constraints,"v",top,0);call(constraints,"v",bottom,donor.dim("cn3"));call(constraints,"v",slide,donor.dim("cn3")+donor.dim("e2i"));
   int[] ids=new int[selectors.size()];for(int n=0;n<ids.length;n++){View item=selectors.get(n);ids[n]=item.getId();call(constraints,"h",ids[n],3,top,4);call(constraints,"h",ids[n],4,bottom,3);}
   call(constraints,"l",donor.id("id","guideline_start"),7,donor.id("id","guideline_end"),6,ids,0,6,7);
   call(constraints,"h",slider.getId(),6,0,6);call(constraints,"h",slider.getId(),7,0,7);call(constraints,"h",slider.getId(),4,slide,3);call(constraints,"b",parameters);
   parameters.addOnLayoutChangeListener((v,l,t,r,b,ol,ot,or,ob)->{
    int available=r-l-Math.round(40*donor.getResources().getDisplayMetrics().density);int width=Math.min(donor.dim("crv"),Math.max(1,available/order.length));
    for(View item:selectors){ViewGroup.LayoutParams lp=item.getLayoutParams();if(lp.width!=width){lp.width=width;item.setLayoutParams(lp);}}
   });
   cardTab=(TextView)donor.find(root,"gix");paramTab=(TextView)donor.find(root,"giy");indicator=donor.find(root,"filter_edit_tab_indicator");
   cardTab.setOnClickListener(v->tab(true,true));paramTab.setOnClickListener(v->tab(false,true));
   donor.find(root,"filter_edit_close").setOnClickListener(v->close());
   View more=donor.find(root,"filter_edit_add");more.setOnClickListener(v->{try{menu(more);}catch(Exception e){failure(e);}});
   select(1);root.post(()->tab(true,false));
  }
  ViewGroup.LayoutParams newLayout(int w,int h)throws Exception{return (ViewGroup.LayoutParams)donor.make("androidx.constraintlayout.widget.ConstraintLayout$a",w,h);}
  void bindProfessional()throws Exception {
   parameters=root;title=(TextView)donor.find(root,"pic_style_title");reset=donor.find(root,"pic_style_reset");slider=donor.find(root,"pic_style_slider_view");
   // The donor professional host supplies an external panel-toggle button.
   // This photo-only host has no such button: reuse the donor editor's actual
   // back control alongside the original title, keeping a visible exit.
   LinearLayout titleOwner=(LinearLayout)title.getParent();int titleIndex=titleOwner.indexOfChild(title);
   LinearLayout.LayoutParams titleSpace=(LinearLayout.LayoutParams)title.getLayoutParams();titleOwner.removeView(title);
   FrameLayout heading=new FrameLayout(donor);heading.setMinimumHeight(donor.dim("c7n"));
   FrameLayout.LayoutParams textSpace=new FrameLayout.LayoutParams(-2,-2,Gravity.CENTER);textSpace.leftMargin=donor.dim("c7i")+donor.dim("c7n");textSpace.rightMargin=textSpace.leftMargin;
   heading.addView(title,textSpace);
   View template=donor.inflate("f5a",host);View close=donor.find(template,"filter_edit_close");((ViewGroup)close.getParent()).removeView(close);
   FrameLayout.LayoutParams closeSpace=new FrameLayout.LayoutParams(donor.dim("c7n"),donor.dim("c7n"),Gravity.START|Gravity.CENTER_VERTICAL);closeSpace.setMarginStart(donor.dim("c7i"));heading.addView(close,closeSpace);
   close.setOnClickListener(v->{Haptics.click(v);close();});
   LinearLayout.LayoutParams headingSpace=new LinearLayout.LayoutParams(-1,-2);headingSpace.bottomMargin=titleSpace.bottomMargin;titleOwner.addView(heading,titleIndex,headingSpace);
   ViewGroup bar=(ViewGroup)donor.find(root,"pic_style_selector_bar");
   for(int k:order){View item=donor.inflate("ffh",bar);item.setId(View.generateViewId());bar.addView(item);selectors.add(item);bindSelector(item,k);}
   // All eight native 50dp selectors exceed the available width on this 15 Pro.
   // Preserve their font/size/spacing and expose the clipped ends by scrolling.
   ViewGroup owner=(ViewGroup)bar.getParent();int barIndex=owner.indexOfChild(bar);ViewGroup.LayoutParams old=bar.getLayoutParams();owner.removeView(bar);
   proOverflow=new HorizontalScrollView(donor);proOverflow.setHorizontalScrollBarEnabled(false);proOverflow.setFillViewport(true);
   proOverflow.addView(bar,new FrameLayout.LayoutParams(donor.dim("doe")*order.length,ViewGroup.LayoutParams.WRAP_CONTENT));owner.addView(proOverflow,barIndex,old);
   Object constraints=donor.make("androidx.constraintlayout.widget.c");call(constraints,"f",bar);int[] ids=new int[selectors.size()];
   for(int n=0;n<ids.length;n++){ids[n]=selectors.get(n).getId();call(constraints,"h",ids[n],3,0,3);call(constraints,"h",ids[n],4,0,4);}
   call(constraints,"l",0,1,0,2,ids,0,1,2);call(constraints,"b",bar);
   adapter=donor.make("wk.b",donor.listener("vv.l",(p,m,args)->{int n=(Integer)args[0];return n>0?"+"+n:String.valueOf(n);}));call(slider,"setAdapter",adapter);
   call(slider,"setOnSeekBarChangeListener",donor.listener("micamx.compat.ui.widget.seekbar.a$a",(p,m,args)->{
    if(m.getName().equals("b")&&!binding&&Boolean.TRUE.equals(args[2])){int n=(Integer)args[1];values[selected]=selected==5?n+50:n;changed();updateSelectors();}
    if(m.getName().equals("d"))persist();return null;
   }));
   bindReset();
   select(0);
  }
  void bindReset()throws Exception {
   reset.setVisibility(View.VISIBLE);reset.setContentDescription("恢复默认参数");reset.setTooltipText("恢复默认参数");
   call(reset,"setAnimation",donor.id("raw","pic_style_reset_anim"));
   reset.setOnClickListener(v->{Haptics.click(v);restoreDefaults();try{call(reset,"setProgress",0f);call(reset,"j");}catch(Exception e){failure(e);}PaletteEngine.notice("已恢复默认调色参数");});
  }
  void bindSelector(View item,int key){
   View labelView=donor.find(item,"pic_style_key");
   if(labelView instanceof TextView)((TextView)labelView).setText(label[key]);
   else ((ImageView)labelView).setImageResource(donor.id("drawable",icons[key]));
   item.setContentDescription(donor.getString(label[key]));item.setOnClickListener(v->{Haptics.click(v);select(key);});
  }
  void select(int key){selected=key;binding=true;try{
   int[] colors=null;
   if(key==2||key==3){String stem=key==2?"temp":"tune";String[] names={"left_primary","left_secondary",null,"right_primary","right_secondary"};colors=new int[5];for(int n=0;n<5;n++)colors[n]=names[n]==null?Color.WHITE:donor.getColor(donor.id("color","pic_style_"+stem+"_"+names[n]));}
   if(pro){
    field(adapter,"i",colors);
    // The donor combined renderer implements soft-light types 0..5. Its pro
    // enum advertises 0..100, but values above 5 produce zero MixRatio. Keep the
    // actual native types; never invent a continuous strength conversion.
    call(slider,"setMinValue",key==7?0:-50);call(slider,"setMaxValue",key==7?5:50);
    // f5v declares a five-unit tick interval for continuous parameters.
    // Soft-light is the donor renderer's discrete 0..5 type selection.
    call(call(slider,"getBaseSeekBar"),"setTickStep",key==7?1f:5f);
    call(slider,"setProgress",key==5?values[key]-50:values[key]);
    slider.invalidate();
    if(proOverflow!=null)proOverflow.post(()->{View item=selectors.get(indexOf(key));proOverflow.smoothScrollTo(Math.max(0,item.getLeft()-(proOverflow.getWidth()-item.getWidth())/2),0);});
   }
   else {ArrayList<String> range=new ArrayList<>();for(int n=key==5||key==7?0:-50;n<=(key==5?100:key==7?5:50);n++)range.add(String.valueOf(n));Object config=donor.type("org.haotian.palette.isolated.OriginalAllocations").getMethod("tickConfig",int[].class,int.class).invoke(null,colors,key==7?1:5);call(adapter,"b",config,range,"0");call(slider,"setSeekState",((Number)call(adapter,"j",String.valueOf(values[key]))).floatValue());}
   updateSelectors();
  }catch(Exception e){failure(e);}finally{binding=false;}}
  int indexOf(int key){for(int i=0;i<order.length;i++)if(order[i]==key)return i;throw new IllegalArgumentException();}
  void updateSelectors(){
   int tint=donor.getColor(donor.id("color","tint_color_yellow_depth2"));
   for(int n=0;n<selectors.size();n++){int key=order[n];View item=selectors.get(n),keyView=donor.find(item,"pic_style_key");TextView value=(TextView)donor.find(item,"pic_style_value");int v=values[key];value.setText(v>0?"+"+v:String.valueOf(v));value.setTextColor(key==selected?tint:Color.WHITE);keyView.setSelected(key==selected);
    if(keyView instanceof TextView)((TextView)keyView).setTextColor(key==selected?tint:Color.WHITE);else if(key==selected)((ImageView)keyView).setColorFilter(tint,PorterDuff.Mode.MULTIPLY);else ((ImageView)keyView).clearColorFilter();
    if(!pro){FrameLayout.LayoutParams lp=(FrameLayout.LayoutParams)value.getLayoutParams();lp.gravity=v==0||root.getLayoutDirection()==1?Gravity.BOTTOM|Gravity.CENTER_HORIZONTAL:Gravity.BOTTOM|Gravity.START;lp.leftMargin=v==0||root.getLayoutDirection()==1?0:donor.dim(Math.abs(v)<10?(v>0?"cn0":"cn1"):(v>0?"cmy":"cmz"));value.setLayoutParams(lp);}
   }
   if(title!=null&&!pro)title.setText(label[selected]);
  }
  void changed(){PaletteEngine.preview(new PaletteValues(true,values,filterId,filterDegree));}
  void persist(){PaletteEngine.save(new PaletteValues(true,values,filterId,filterDegree));if(recipes!=null)recipes.updateStripSelection();}
  void restoreDefaults(){Arrays.fill(values,0);filterId=NativeFilters.NONE;filterDegree=100;changed();persist();select(selected);try{if(filters!=null)filters.refresh();if(card!=null){binding=true;try{call(card,"p",0,0,true);call(card,"o",0,0);}finally{binding=false;}}}catch(Exception e){failure(e);}}
  void tab(boolean palette,boolean animate){
   View parent=(View)indicator.getParent();float inset=donor.dim("c7q");boolean rtl=parent.getLayoutDirection()==1;
   float x=(palette!=rtl?inset:parent.getWidth()-indicator.getWidth()-inset)-indicator.getLeft();
   cardTab.setSelected(palette);paramTab.setSelected(!palette);
   if(animate)indicator.animate().translationX(x).setDuration(200).start();else{indicator.animate().cancel();indicator.setTranslationX(x);}
   card.setVisibility(palette?View.VISIBLE:View.GONE);donor.find(root,"new_filter_style_picture_style_container").setVisibility(palette?View.GONE:View.VISIBLE);title.setVisibility(palette?View.GONE:View.VISIBLE);
   if(palette){binding=true;try{call(card,"o",values[1],values[0]);}catch(Exception e){failure(e);}finally{binding=false;}}else select(selected);
  }
  void menu(View anchor)throws Exception {
   if(popup==null)popup=donor.make("com.android.camera.fragment.M",donor);
   ArrayList<Object> items=new ArrayList<>();String[] strings={"gie","gib","gic"},icons={"ic_filter_action_save_as_new","ic_filter_action_import_new","ic_filter_action_manage"};
   for(int n=0;n<3;n++)items.add(donor.make("com.android.camera.fragment.M$a",n,donor.id("string",strings[n]),donor.id("drawable",icons[n])));
   Object callback=donor.listener("com.android.camera.fragment.M$b",(p,m,args)->{recipes.action((Integer)args[0]);return null;});
   call(popup,"c",anchor,items,callback,false,0,0,true);
  }
  void open(){
   FrameLayout.LayoutParams lp=new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,pro?donor.dim("cn3")+donor.dim("e2i")+donor.dim("dog"):donor.dim("c9h"),Gravity.BOTTOM);
   if(pro){root.measure(View.MeasureSpec.makeMeasureSpec(host.getWidth(),View.MeasureSpec.EXACTLY),View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED));lp.height=root.getMeasuredHeight();View shutter=find(host,"com.android.camera.ui.CameraSnapView");int[] a=new int[2],b=new int[2];shutter.getLocationInWindow(a);host.getLocationInWindow(b);lp.bottomMargin=host.getHeight()-(a[1]-b[1])+donor.dim("dok");}
   View modeStrip=find(host,"com.android.camera.ui.ModeSelectView");if(modeStrip!=null&&modeStrip.getVisibility()==View.VISIBLE){hidden.add(modeStrip);modeStrip.setVisibility(View.INVISIBLE);}
   if(pro){int resetId=activity.getResources().getIdentifier("reset_button","id","com.android.camera");View manualReset=resetId==0?null:host.findViewById(resetId);if(manualReset!=null&&manualReset.getParent() instanceof View){View manualRoot=(View)manualReset.getParent();if(manualRoot.getVisibility()==View.VISIBLE){hidden.add(manualRoot);manualRoot.setVisibility(View.INVISIBLE);}}}
   host.addView(root,lp);attachTitle();bindWindowTouch();activity.getOnBackInvokedDispatcher().registerOnBackInvokedCallback(OnBackInvokedDispatcher.PRIORITY_OVERLAY,back);root.post(()->{hideOverlap(host);if(recipes!=null)recipes.safe(()->{recipes.refreshStrip();if(filters!=null)filters.show();});});
  }
  boolean hit(View v,MotionEvent event){Rect r=new Rect();return v!=null&&v.isShown()&&v.getGlobalVisibleRect(r)&&r.contains((int)event.getRawX(),(int)event.getRawY());}
  void bindWindowTouch(){Window window=activity.getWindow();previousCallback=window.getCallback();paletteCallback=(Window.Callback)Proxy.newProxyInstance(Window.Callback.class.getClassLoader(),new Class<?>[]{Window.Callback.class},(proxy,method,args)->{
   if(method.getName().equals("dispatchTouchEvent")&&!closed){MotionEvent event=(MotionEvent)args[0];int action=event.getActionMasked();if(action==MotionEvent.ACTION_DOWN)ownsTouch=true;if(ownsTouch){try{window.superDispatchTouchEvent(event);return true;}finally{if(action==MotionEvent.ACTION_UP||action==MotionEvent.ACTION_CANCEL)ownsTouch=false;}}}
   try{return method.invoke(previousCallback,args);}catch(InvocationTargetException e){throw e.getCause();}
  });window.setCallback(paletteCallback);}
  void attachTitle(){if(pro||title.getParent()!=null)return;FrameLayout.LayoutParams lp=new FrameLayout.LayoutParams(-2,donor.dim("dov"),Gravity.BOTTOM|Gravity.CENTER_HORIZONTAL);lp.bottomMargin=donor.dim("c9h")+Math.round(20*donor.getResources().getDisplayMetrics().density);host.addView(title,lp);}
  void hideOverlap(View v){if(v==root||closed)return;String n=v.getClass().getName();if(n.contains("ZoomRatioToggleView")||n.endsWith("HorizontalZoomView")||n.endsWith("ZoomView")){Rect a=new Rect(),b=new Rect();View visible=pro?root:donor.find(root,"new_filter_style_content_container");if(v.isShown()&&v.getGlobalVisibleRect(a)&&visible.getGlobalVisibleRect(b)&&Rect.intersects(a,b)){hidden.add(v);v.setVisibility(View.INVISIBLE);}return;}if(v instanceof ViewGroup){ViewGroup g=(ViewGroup)v;for(int i=0;i<g.getChildCount();i++)hideOverlap(g.getChildAt(i));}}
  void close(){if(closed)return;persist();cleanup();host.removeView(root);}
  void cleanup(){if(closed)return;closed=true;if(activity!=null&&paletteCallback!=null&&activity.getWindow().getCallback()==paletteCallback)activity.getWindow().setCallback(previousCallback);if(filters!=null)filters.close();if(recipes!=null)recipes.close();if(!pro&&title!=null)host.removeView(title);try{if(popup!=null)call(popup,"a",false);}catch(Exception e){failure(e);}if(activity!=null)activity.getOnBackInvokedDispatcher().unregisterOnBackInvokedCallback(back);for(View v:hidden)if(v.getVisibility()==View.INVISIBLE)v.setVisibility(View.VISIBLE);hidden.clear();if(opened.get()==this)opened=new WeakReference<>(null);}
  void failure(Exception e){PaletteDiagnostics.event("NATIVE_BIND_ERROR "+android.util.Log.getStackTraceString(e));android.util.Log.e("HaotianPalette","Original control binding",e);PaletteEngine.notice("原生调色控件绑定失败，请保留日志");}
 }
}
