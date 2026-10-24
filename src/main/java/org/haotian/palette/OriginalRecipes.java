package org.haotian.palette;

import android.app.*;
import android.content.*;
import android.graphics.*;
import android.net.Uri;
import android.os.*;
import android.provider.MediaStore;
import android.text.*;
import android.view.*;
import android.widget.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.*;
import android.window.*;

/** Storage/activity bridge for original popup, dialogs, cards, grid and drag UI. */
public final class OriginalRecipes {
 static final ExecutorService IO=Executors.newSingleThreadExecutor();
 final PaletteUi.Panel panel;final OriginalUiRuntime d;final RecipeStore store;final Activity a;
 View manager,strip;Object gridAdapter,stripAdapter;ArrayList<RecipeStore.Item> items,stripItems;ArrayList<Object> nativeItems,stripModels;Object itemPopup;
 final OnBackInvokedCallback back=this::closeManager;
 OriginalRecipes(PaletteUi.Panel p)throws Exception{panel=p;d=p.donor;a=p.activity;store=new RecipeStore(a);}
 static void action(PaletteUi.Panel p,int id){try{OriginalRecipes r=new OriginalRecipes(p);if(id==0)r.name(null);else if(id==1)r.importMenu();else if(id==2)r.manage();}catch(Exception e){p.failure(e);}}
 void action(int id){safe(()->{if(id==0)name(null);else if(id==1)importMenu();else manage();});}
 void close(){closeManager();if(strip!=null){panel.host.removeView(strip);strip=null;}}
 void refreshStrip()throws Exception{
  if(panel.closed||panel.pro)return;
  if(strip!=null){panel.host.removeView(strip);strip=null;}
  if(panel.title.getLayoutParams() instanceof FrameLayout.LayoutParams){FrameLayout.LayoutParams name=(FrameLayout.LayoutParams)panel.title.getLayoutParams();name.bottomMargin=panel.root.getHeight()+Math.round(20*d.getResources().getDisplayMetrics().density);panel.title.setLayoutParams(name);}
  ArrayList<RecipeStore.Item> saved=store.list();stripItems=saved;
  ArrayList<Object> models=new ArrayList<>();Object defaults=d.make("com.android.camera.features.mode.capture.l");PaletteUi.field(defaults,"l","默认");PaletteUi.field(defaults,"s","MiCamStyleRear");models.add(defaults);for(RecipeStore.Item item:saved)models.add(model(item));
  for(int n=0;n<models.size();n++){Object component=d.type("v2.j0").getMethod("p",int.class,int.class,String.class).invoke(null,d.id("drawable","bg_filter_management_item_cover"),-1,"0");PaletteUi.field(component,"o",n==0?"默认":saved.get(n-1).name);PaletteUi.field(models.get(n),"M",component);}stripModels=models;
  strip=d.inflate("f5p",panel.host);strip.setBackgroundColor(Color.BLACK);Object list=d.find(strip,"style_workspace_list");Object adapter=d.type("org.haotian.palette.isolated.OriginalAllocations").getMethod("recipeStrip",Context.class,ArrayList.class,View.OnClickListener.class).invoke(null,d,models,(View.OnClickListener)v->safe(()->{int n=(Integer)v.getTag();if(n<0||n>saved.size())return;Haptics.click(v);if(n==0)panel.restoreDefaults();else apply(saved.get(n-1));updateStripSelection();}));stripAdapter=adapter;
  PaletteUi.call(list,"setLayoutManager",d.make("androidx.recyclerview.widget.LinearLayoutManager",d,0,false));PaletteUi.call(list,"setAdapter",adapter);
  updateStripSelection();
  FrameLayout.LayoutParams lp=new FrameLayout.LayoutParams(-1,-2,Gravity.BOTTOM);lp.bottomMargin=panel.root.getHeight();panel.host.addView(strip,panel.host.indexOfChild(panel.root)+1,lp);
  strip.post(()->{if(panel.closed||strip==null)return;FrameLayout.LayoutParams name=(FrameLayout.LayoutParams)panel.title.getLayoutParams();name.bottomMargin=panel.root.getHeight()+strip.getHeight()+Math.round(20*d.getResources().getDisplayMetrics().density);panel.title.setLayoutParams(name);});
 }
 void updateStripSelection(){safe(()->{if(strip==null||stripModels==null||stripAdapter==null)return;int selected=-1;if(NativeFilters.isNone(panel.filterId)&&Arrays.equals(panel.values,new int[8]))selected=0;else for(int i=0;i<stripItems.size();i++){RecipeStore.Item item=stripItems.get(i);int id=Integer.parseInt(item.parameters.getOrDefault("pref_camera_shader_coloreffect_key",String.valueOf(NativeFilters.NONE)));if(panel.filterId==id&&panel.filterDegree==degree(item)&&Arrays.equals(panel.values,item.values())){selected=i+1;break;}}boolean changed=false;for(int i=0;i<stripModels.size();i++){Object m=stripModels.get(i);boolean value=i==selected;if(m.getClass().getField("n").getBoolean(m)!=value){PaletteUi.field(m,"n",value);changed=true;}}if(changed)PaletteUi.call(stripAdapter,"notifyDataSetChanged");});}
 interface Work {void run()throws Exception;}
 void safe(Work w){try{w.run();}catch(Exception|LinkageError e){error(e);}}
 void error(Throwable e){android.util.Log.e("HaotianPalette","Native recipe workflow",e);PaletteDiagnostics.event("RECIPE_ERROR "+android.util.Log.getStackTraceString(e));Throwable cause=e;for(int depth=0;depth<16&&cause.getCause()!=null;depth++)cause=cause.getCause();RecipeStatus.write(a,"error",cause.getClass().getName()+": "+cause.getMessage()+"\n"+android.util.Log.getStackTraceString(e));PaletteEngine.notice(cause.getMessage()==null?"配方操作失败（"+cause.getClass().getSimpleName()+"）":cause.getMessage());}
 String text(String key){return d.getString(d.id("string",key));}
 Object builder()throws Exception{return d.make("miuix.appcompat.app.l$a",d,d.id("style","i__"));}
 Dialog show(Object b)throws Exception{return (Dialog)PaletteUi.call(b,"F");}
 void choices(String title,String[]keys,java.util.function.IntConsumer action)throws Exception{Object b=builder();PaletteUi.call(b,"D",text(title));String[]names=new String[keys.length];for(int i=0;i<keys.length;i++)names[i]=text(keys[i]);PaletteUi.call(b,"m",names,(DialogInterface.OnClickListener)(dlg,id)->action.accept(id));show(b);}
 void name(RecipeStore.Item item)throws Exception{
  if(item==null&&store.list().size()>=15){PaletteEngine.notice(d.getString(d.id("string","i95"),15));return;}
  View content=d.inflate("f1p",null);((TextView)d.find(content,"filter_name")).setText(text(item==null?"gig":"gj3"));
  EditText edit=(EditText)d.find(content,"dialog_input_area");TextView count=(TextView)d.find(content,"count_tip");int limit=d.getResources().getInteger(d.id("integer","ew3"));edit.setFilters(new InputFilter[]{new InputFilter.LengthFilter(limit)});edit.setText(item==null?"":item.name);count.setText(edit.length()+"/"+limit);
  Object b=builder();PaletteUi.call(b,"E",content);PaletteUi.call(b,"y",d.id("string","gxk"),(DialogInterface.OnClickListener)(x,id)->{});PaletteUi.call(b,"q",d.id("string","gcz"),(DialogInterface.OnClickListener)(x,id)->{});
  Dialog dialog=show(b);View positive=(View)PaletteUi.call(dialog,"l",-1);
  positive.setEnabled(edit.length()>0);edit.addTextChangedListener(new TextWatcher(){public void beforeTextChanged(CharSequence s,int st,int c,int aft){}public void onTextChanged(CharSequence s,int st,int before,int c){count.setText(s.length()+"/"+limit);positive.setEnabled(s.toString().trim().length()>0);}public void afterTextChanged(Editable s){}});
  positive.setOnClickListener(v->safe(()->{String value=edit.getText().toString().trim();if(item==null)store.save(value,panel.values,panel.filterId,panel.filterDegree);else store.rename(item,value);dialog.dismiss();refreshManager();refreshStrip();}));edit.requestFocus();dialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);edit.postDelayed(()->((android.view.inputmethod.InputMethodManager)a.getSystemService(Context.INPUT_METHOD_SERVICE)).showSoftInput(edit,0),150);
 }
 Object model(RecipeStore.Item item)throws Exception{Object nativeItem=d.make("com.android.camera.features.mode.capture.l");PaletteUi.field(nativeItem,"l",item.name);PaletteUi.field(nativeItem,"a",item.directory.getName());PaletteUi.field(nativeItem,"g",item.directory.getAbsolutePath());PaletteUi.field(nativeItem,"h",new File(item.directory,"t").getAbsolutePath());PaletteUi.field(nativeItem,"s","MiCamStyleRear");PaletteUi.field(nativeItem,"e",new HashMap<>(item.parameters));PaletteUi.field(nativeItem,"f",new HashMap<>());return nativeItem;}
 void manage()throws Exception{
  manager=d.inflate("f31",panel.host);manager.setVisibility(View.VISIBLE);panel.host.addView(manager,new android.widget.FrameLayout.LayoutParams(-1,-1));
  d.find(manager,"filter_back_button").setOnClickListener(v->closeManager());a.getOnBackInvokedDispatcher().registerOnBackInvokedCallback(OnBackInvokedDispatcher.PRIORITY_OVERLAY+1,back);
  refreshManager();manager.setAlpha(0);manager.animate().alpha(1).setDuration(200).start();
 }
 void refreshManager()throws Exception{
  if(manager==null)return;items=store.list();nativeItems=new ArrayList<>();for(RecipeStore.Item i:items)nativeItems.add(model(i));
  Class<?> factory=d.type("org.haotian.palette.isolated.OriginalAllocations");gridAdapter=factory.getMethod("recipeGrid",Context.class,ArrayList.class,View.OnClickListener.class).invoke(null,d,nativeItems,(View.OnClickListener)v->safe(()->{int n=((Number)PaletteUi.call(v.getTag(),"getBindingAdapterPosition")).intValue();if(n==0)importMenu();else if(n>0){String path=(String)nativeItems.get(n-1).getClass().getField("g").get(nativeItems.get(n-1));itemMenu(v,new RecipeStore.Item(new File(path)));}}));
  Object list=d.find(manager,"filter_data_list");PaletteUi.call(list,"setLayoutManager",d.make("androidx.recyclerview.widget.GridLayoutManager",d,4));PaletteUi.call(list,"setAdapter",gridAdapter);
  if(((Number)PaletteUi.call(list,"getItemDecorationCount")).intValue()==0)PaletteUi.call(list,"addItemDecoration",factory.getMethod("recipeDecoration").invoke(null));
  Object cb=factory.getMethod("recipeDrag",Object.class).invoke(null,gridAdapter);PaletteUi.call(d.make("androidx.recyclerview.widget.r",cb),"i",list);
 }
 void closeManager(){safe(()->{if(manager==null)return;if(nativeItems!=null){ArrayList<RecipeStore.Item>ordered=new ArrayList<>();for(Object o:nativeItems)ordered.add(new RecipeStore.Item(new File((String)o.getClass().getField("g").get(o))));store.order(ordered);}if(itemPopup!=null)PaletteUi.call(itemPopup,"a",false);panel.host.removeView(manager);manager=null;a.getOnBackInvokedDispatcher().unregisterOnBackInvokedCallback(back);refreshStrip();});}
 void itemMenu(View anchor,RecipeStore.Item item)throws Exception{
  itemPopup=d.make("com.android.camera.fragment.M",d);ArrayList<Object>opts=new ArrayList<>();String[]s={"gif","gid","gia"},icons={"ic_filter_share","ic_filter_management_rename","ic_filter_management_delete"};for(int i=0;i<3;i++)opts.add(d.make("com.android.camera.fragment.M$a",i,d.id("string",s[i]),d.id("drawable",icons[i])));
  Object callback=d.listener("com.android.camera.fragment.M$b",(p,m,args)->{safe(()->{int n=(Integer)args[0];if(n==0)shareMenu(item);else if(n==1)name(item);else confirmDelete(item);});return null;});PaletteUi.call(itemPopup,"c",anchor,opts,callback,false,0,0,true);
 }
 void confirmDelete(RecipeStore.Item item)throws Exception{Object b=builder();PaletteUi.call(b,"D",d.getString(d.id("string","gis"),item.name));PaletteUi.call(b,"n",d.id("string","gir"));PaletteUi.call(b,"y",d.id("string","gia"),(DialogInterface.OnClickListener)(dlg,id)->safe(()->{store.delete(item);refreshManager();refreshStrip();}));PaletteUi.call(b,"q",d.id("string","gcz"),(DialogInterface.OnClickListener)(dlg,id)->{});show(b);}
 void importMenu()throws Exception{choices("i8z",new String[]{"i8x","i8y","i90"},id->safe(()->{if(id==0)pick("image/*",true);else if(id==1)codeInput();else pick("application/zip",false);}));}
 void codeInput()throws Exception{
  int layout=d.type("qh.e").getField("dialog_input_edittext").getInt(null),id=d.type("qh.d").getField("dialog_input_edittext").getInt(null);
  View content=((LayoutInflater)d.getSystemService(Context.LAYOUT_INFLATER_SERVICE)).inflate(layout,null);Object callback=d.listener("vv.l",(p,m,args)->confirmCode((String)args[0]));
  d.type("Lr.C").getMethod("c",Context.class,View.class,boolean.class,String.class,int.class,String.class,int.class,String.class,String.class,d.type("vv.l"),boolean.class).invoke(null,d,content,true,text("i9h"),id,text("i9g"),1,text("gd3"),text("gcz"),callback,false);
 }
 Boolean confirmCode(String code){try{query(code);return Boolean.TRUE;}catch(Exception|LinkageError e){error(e);return Boolean.FALSE;}}
 void pick(String mime,boolean qr){Picker.start(a,new Intent(Intent.ACTION_OPEN_DOCUMENT).setType(mime).addCategory(Intent.CATEGORY_OPENABLE),uri->{if(uri==null)return;IO.execute(()->{try{if(qr){String code=OriginalQr.parse(d,OriginalQr.decode(d,a.getContentResolver(),uri));a.runOnUiThread(()->safe(()->query(code)));}else try(InputStream in=a.getContentResolver().openInputStream(uri)){String name=null;try(android.database.Cursor cursor=a.getContentResolver().query(uri,new String[]{android.provider.OpenableColumns.DISPLAY_NAME},null,null,null)){if(cursor!=null&&cursor.moveToFirst())name=cursor.getString(0);}stage(in,name);}}catch(Exception|LinkageError e){a.runOnUiThread(()->error(e));}});});}
 void stage(InputStream in)throws Exception{stage(in,null);}
 void stage(InputStream in,String name)throws Exception{File folder=new File(a.getCacheDir(),"recipe-import-"+UUID.randomUUID());try{RecipeStore.Item item=store.parseZip(in,folder,name);RecipeStatus.write(a,"recipe-parsed","parameterCount="+item.parameters.size()+" filter="+item.parameters.get("pref_camera_shader_coloreffect_key"));a.runOnUiThread(()->safe(()->{if(panel.closed){RecipeStore.removeTree(folder,a.getCacheDir());return;}previewImport(item,folder);}));}catch(Exception e){RecipeStore.removeTree(folder,a.getCacheDir());throw e;}}
 ArrayList<String[]> rows(RecipeStore.Item item)throws Exception{ArrayList<String[]>rows=new ArrayList<>();int id=Integer.parseInt(item.parameters.getOrDefault("pref_camera_shader_coloreffect_key",String.valueOf(NativeFilters.NONE)));String name=null;for(Object entry:NativeFilters.catalog(d))if((Integer)PaletteUi.call(entry,"a")==id){name=d.getString(NativeFilters.number(entry,"c"));break;}if(name==null&&!NativeFilters.isNone(id))name=NativeFilters.get(a).resolve(id).name;if(name!=null)rows.add(new String[]{"基础滤镜",name});int[]v=item.values();for(int i=0;i<8;i++)rows.add(new String[]{d.getString(panel.label[i]),String.valueOf(v[i])});return rows;}
 void previewImport(RecipeStore.Item item,File staging)throws Exception{
  Bitmap image=(Bitmap)d.type("U9.T").getMethod("d",Context.class,String.class,ArrayList.class).invoke(null,d,item.name,rows(item));ImageView view=new ImageView(d);view.setImageBitmap(image);view.setScaleType(ImageView.ScaleType.FIT_CENTER);view.setPadding(d.dim("brb"),0,d.dim("brb"),d.dim("brc"));view.setLayoutParams(new ViewGroup.LayoutParams(d.dim("brb")*2+d.dim("brh"),image.getHeight()/3+d.dim("brc")));
  Object b=builder();PaletteUi.call(b,"C",d.id("string","i8t"));PaletteUi.call(b,"E",view);PaletteUi.call(b,"e");PaletteUi.call(b,"y",d.id("string","i8v"),(DialogInterface.OnClickListener)(dlg,id)->safe(()->{validate(item);RecipeStore.Item installed=store.commit(item);apply(installed);refreshManager();refreshStrip();}));PaletteUi.call(b,"q",d.id("string","gcz"),(DialogInterface.OnClickListener)(dlg,id)->{});Dialog dlg=show(b);dlg.setOnDismissListener(v->safe(()->RecipeStore.removeTree(staging,a.getCacheDir())));
 }
 int degree(RecipeStore.Item item)throws Exception{int value=Integer.parseInt(item.parameters.getOrDefault("pref_camera_shader_coloreffect_degree_key","100"));return value<0?100:PaletteValues.clamp(value,0,100);}
 void validate(RecipeStore.Item item)throws Exception{int id=Integer.parseInt(item.parameters.getOrDefault("pref_camera_shader_coloreffect_key",String.valueOf(NativeFilters.NONE)));NativeFilters.get(a).resolve(id);degree(item);}
 void apply(RecipeStore.Item item)throws Exception{
  String filter=item.parameters.get("pref_camera_shader_coloreffect_key");
  validate(item);panel.filterId=filter==null?NativeFilters.NONE:Integer.parseInt(filter);panel.filterDegree=degree(item);
  int[] v=new PaletteValues(true,item.values()).array();System.arraycopy(v,0,panel.values,0,8);panel.changed();panel.persist();panel.select(panel.selected);if(panel.filters!=null)panel.filters.refresh();if(panel.card!=null){panel.binding=true;try{PaletteUi.call(panel.card,"p",v[1],v[0],true);PaletteUi.call(panel.card,"o",v[1],v[0]);}finally{panel.binding=false;}}
 }
 void query(String code)throws Exception{
  String extracted=(String)d.type("b2.a").getMethod("b",String.class).invoke(null,code);if(extracted==null||extracted.isEmpty())extracted=code.trim();
  if(!(Boolean)d.type("b2.a").getMethod("a",String.class).invoke(null,extracted))throw new IOException(text("i9i"));cloud(false,extracted,result->{IO.execute(()->{try{java.net.URL url=new java.net.URL(result);if(!url.getProtocol().equals("https"))throw new IOException("配方下载地址不是 HTTPS");java.net.URLConnection c=url.openConnection();c.setConnectTimeout(15000);c.setReadTimeout(20000);String filename=android.net.Uri.parse(result).getLastPathSegment();if(filename!=null&&!filename.isEmpty())filename=(String)d.type("U9.c").getMethod("a",String.class).invoke(null,filename);RecipeStatus.write(a,"cloud-download","filenamePresent="+(filename!=null&&!filename.isEmpty())+" contentLength="+c.getContentLengthLong());try(InputStream input=c.getInputStream()){stage(input,filename);}}catch(Exception e){a.runOnUiThread(()->error(e));}});});
 }
 void cloud(boolean upload,Object input,java.util.function.Consumer<String> success)throws Exception{
  cloud(upload,input,success,false);
 }
 void cloud(boolean upload,Object input,java.util.function.Consumer<String> success,boolean authorizedRetry)throws Exception{
  int accountCount=-1;try{accountCount=android.accounts.AccountManager.get(a).getAccountsByType("com.xiaomi").length;}catch(SecurityException ignored){}
  RecipeStatus.write(a,"cloud-start","upload="+upload+" visibleXiaomiAccounts="+accountCount);
  Object client=d.make("sn.j",d);Object request=client.getClass().getField(upload?"a":"b").get(client);
  Object cb=d.listener("vv.l",(p,m,args)->{
   try{
    Object result=args[0];
    if(result.getClass().getName().equals("wn.d$b")){
     Object data=result.getClass().getField("a").get(result);String value=(String)data.getClass().getField("a").get(data);
     RecipeStatus.write(a,"cloud-success","response received");
     a.runOnUiThread(()->{if(!a.isFinishing()&&!a.isDestroyed()&&!panel.closed)safe(()->success.accept(value));});
    }else{
     String message=String.valueOf(result.getClass().getField("b").get(result));
     RecipeStatus.write(a,"cloud-failure",message);
     String notice=message.contains("401")?"小米配方云服务要求登录授权（401），当前 Test 身份尚未通过认证":"配方云服务请求失败："+message;
     a.runOnUiThread(()->{
      if(a.isFinishing()||a.isDestroyed()||panel.closed)return;
      if(message.contains("401")&&!authorizedRetry)safe(()->{
       Object dialog=builder();PaletteUi.call(dialog,"D","小米配方服务需要授权");
       PaletteUi.call(dialog,"o","口令和二维码配方需要登录小米云服务。选择账号并完成系统授权后，将重试本次操作；ZIP 本地导入无需云端登录。");
       PaletteUi.call(dialog,"z","选择账号并授权",(DialogInterface.OnClickListener)(which,id)->RecipeAccountAuth.start(a,()->safe(()->cloud(upload,input,success,true)),this::error));
       PaletteUi.call(dialog,"q",d.id("string","gcz"),(DialogInterface.OnClickListener)(which,id)->{});show(dialog);
      });else error(new IOException(notice));
     });
    }
   }catch(Exception|LinkageError e){a.runOnUiThread(()->error(e));}
   return d.type("gv.A").getField("a").get(null);
  });PaletteUi.call(request,"b",cb,input);
 }
 void shareMenu(RecipeStore.Item item)throws Exception{choices("i9j",new String[]{"i9f","i9l"},id->safe(()->{File archive=store.export(item,a.getCacheDir());if(id==0){Object request=d.make("wn.c",archive.getName(),Files.readAllBytes(archive.toPath()),null,null);cloud(true,request,code->safe(()->shareCard(item,code)));}else zipCard(archive);}));}
 void shareCard(RecipeStore.Item item,String code)throws Exception{
  Bitmap bmp=(Bitmap)d.type("org.haotian.palette.isolated.OriginalShare").getMethod("card",Context.class,d.type("U9.S"),String.class,ArrayList.class).invoke(null,d,model(item),code,rows(item));ImageView image=new ImageView(d);image.setImageBitmap(bmp);image.setScaleType(ImageView.ScaleType.FIT_CENTER);image.setAdjustViewBounds(true);
  Object b=builder();PaletteUi.call(b,"C",d.id("string","i8u"));PaletteUi.call(b,"E",image);PaletteUi.call(b,"y",d.id("string","i97"),(DialogInterface.OnClickListener)(dlg,id)->safe(()->saveMedia(bmp,null,false)));PaletteUi.call(b,"s",d.id("string","i9e"),(DialogInterface.OnClickListener)(dlg,id)->safe(()->saveMedia(bmp,null,true)));PaletteUi.call(b,"q",d.id("string","i8s"),(DialogInterface.OnClickListener)(dlg,id)->{((android.content.ClipboardManager)a.getSystemService(Context.CLIPBOARD_SERVICE)).setPrimaryClip(ClipData.newPlainText("CamStyle",code));PaletteEngine.notice(text("i8r"));});show(b);
 }
 void zipCard(File zip)throws Exception{ImageView image=new ImageView(d);image.setImageBitmap(OriginalZipCard.create(d,zip.getName()));image.setScaleType(ImageView.ScaleType.CENTER);image.setPadding(0,0,0,d.dim("bs5"));Object b=builder();PaletteUi.call(b,"C",d.id("string","i8u"));PaletteUi.call(b,"E",image);PaletteUi.call(b,"e");PaletteUi.call(b,"y",d.id("string","i9m"),(DialogInterface.OnClickListener)(dlg,id)->safe(()->saveMedia(null,zip,true)));PaletteUi.call(b,"s",d.id("string","i99"),(DialogInterface.OnClickListener)(dlg,id)->safe(()->saveMedia(null,zip,false)));show(b);}
 void saveMedia(Bitmap bitmap,File file,boolean share)throws Exception{ContentValues values=new ContentValues();String type=bitmap==null?"application/zip":"image/png";values.put(MediaStore.MediaColumns.DISPLAY_NAME,bitmap==null?file.getName():"CamStyle_"+System.currentTimeMillis()+".png");values.put(MediaStore.MediaColumns.MIME_TYPE,type);values.put(MediaStore.MediaColumns.RELATIVE_PATH,bitmap==null?"Download":"Pictures/CamStyle");values.put(MediaStore.MediaColumns.IS_PENDING,1);Uri uri=a.getContentResolver().insert(bitmap==null?MediaStore.Downloads.EXTERNAL_CONTENT_URI:MediaStore.Images.Media.EXTERNAL_CONTENT_URI,values);if(uri==null)throw new IOException("Cannot save recipe");try{try(OutputStream out=a.getContentResolver().openOutputStream(uri)){if(bitmap==null)Files.copy(file.toPath(),out);else if(!bitmap.compress(Bitmap.CompressFormat.PNG,100,out))throw new IOException("Card encoding failed");}values.clear();values.put(MediaStore.MediaColumns.IS_PENDING,0);a.getContentResolver().update(uri,values,null,null);}catch(Exception e){a.getContentResolver().delete(uri,null,null);throw e;}if(share)a.startActivity(Intent.createChooser(new Intent(Intent.ACTION_SEND).setType(type).putExtra(Intent.EXTRA_STREAM,uri).addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION),text("i8u")));else PaletteEngine.notice(text(bitmap==null?"i9_":"i98"));}
 public static class Picker extends android.app.Fragment {
  java.util.function.Consumer<Uri> callback;Intent intent;boolean launched;
  static void start(Activity a,Intent intent,java.util.function.Consumer<Uri> cb){Picker p=new Picker();p.intent=intent;p.callback=cb;a.getFragmentManager().beginTransaction().add(p,"native-recipe-picker").commit();}
  public void onResume(){super.onResume();if(!launched&&intent!=null){launched=true;startActivityForResult(intent,44);}}
  public void onActivityResult(int request,int result,Intent data){if(request==44){if(callback!=null)callback.accept(result==Activity.RESULT_OK&&data!=null?data.getData():null);getFragmentManager().beginTransaction().remove(this).commitAllowingStateLoss();}}
 }
}



