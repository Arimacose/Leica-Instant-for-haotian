package org.haotian.palette;

import android.content.Context;
import android.view.*;
import android.widget.*;
import java.util.*;

/** Hosts the unmodified donor f13 layout, nj.e holders and strength control. */
final class NativeFilterUi {
 final PaletteUi.Panel panel;final OriginalUiRuntime d;final ArrayList<Object> entries=new ArrayList<>(),models=new ArrayList<>();
 View root,list,strength;Object adapter,layout;boolean binding,closed;int selected=-1;NativeFilterCovers covers;
 NativeFilterUi(PaletteUi.Panel panel)throws Exception{
  this.panel=panel;d=panel.donor;entries.addAll(NativeFilters.catalog(d));
  for(Object entry:entries){int id=(Integer)PaletteUi.call(entry,"a");String category=(String)entry.getClass().getField("o").get(entry);if(category==null)category="NORMAL";
   Object kind=d.type("jj.c").getMethod("valueOf",String.class).invoke(null,category);
   models.add(d.make("jj.b",String.valueOf(id),NativeFilters.number(entry,"c"),NativeFilters.number(entry,"d"),NativeFilters.number(entry,"l"),"",kind,null,null));
  }
 }
 void show()throws Exception{
  if(closed||root!=null)return;
  root=d.inflate("f13",panel.host);root.setBackgroundColor(android.graphics.Color.BLACK);
  list=d.find(root,"effect_list");strength=d.find(root,"combine_slide_view");
  View spring=d.find(root,"filter_spring_layout");PaletteUi.call(spring,"setScrollOrientation",1);
  float fade=d.getResources().getDimension(d.type("fj.c").getField("fading_size_default").getInt(null));float start=dim("second_panel_item_width_with_padding")*1.1f+fade;
  Object style=d.type("com.android.camera.ui.g$b").getMethod("b",float.class,int[].class,float[].class,float.class,int[].class,float[].class).invoke(null,start,new int[]{-1250068,16777215},new float[]{1-fade/start,1},fade,new int[]{-1250068,16777215},new float[]{0,1});
  if(spring.getLayoutDirection()==View.LAYOUT_DIRECTION_RTL)style=PaletteUi.call(style,"b");PaletteUi.call(spring,"setStyle",style);
  View indicator=d.find(root,"effect_item_selected_indicator");ViewGroup.MarginLayoutParams border=(ViewGroup.MarginLayoutParams)indicator.getLayoutParams();int imageSize=dim("second_panel_image_width"),borderSize=dim("second_panel_item_border_width");border.width=border.height=borderSize-(borderSize-imageSize)%2;border.topMargin=dim("second_panel_item_margin_top_without_border")-(border.height-imageSize)/2;indicator.setLayoutParams(border);
  adapter=d.make("nj.e",d,models,(View.OnClickListener)v->safe(()->{int i=(Integer)v.getTag()-1;choose(i,true);}));
  PaletteUi.field(adapter,"g",panel.host.getWidth());
  layout=d.make("com.xiaomi.camera.ui.layout.ScrollControlLayoutManager",d);PaletteUi.call(layout,"setOrientation",0);PaletteUi.call(list,"setLayoutManager",layout);PaletteUi.call(list,"setAdapter",adapter);
  Object animator=d.make("com.android.camera.fragment.x");PaletteUi.field(animator,"f",150L);PaletteUi.field(animator,"e",150L);PaletteUi.field(animator,"c",150L);PaletteUi.call(list,"setItemAnimator",animator);
  PaletteUi.field(list,"a",models);
  list.getViewTreeObserver().addOnGlobalLayoutListener((ViewTreeObserver.OnGlobalLayoutListener)list);
  PaletteUi.field(list,"paletteSelection",(java.util.function.IntConsumer)i->{if(!binding&&i!=selected)list.post(()->safe(()->{if(!binding&&i!=selected&&NativeFilters.number(list,"b")==i)choose(i,false);}));});
  ViewGroup.LayoutParams listSpace=list.getLayoutParams();listSpace.height=d.getResources().getDimensionPixelSize(d.type("fj.c").getField("slide_height_mm").getInt(null))+d.getResources().getDimensionPixelSize(d.type("fj.c").getField("second_panel_height_mm").getInt(null))-d.getResources().getDimensionPixelSize(d.type("fj.c").getField("display_phone_panel_height").getInt(null));list.setLayoutParams(listSpace);
  Object strengthAdapter=d.make("oj.a",d);PaletteUi.call(strength,"setAdapter",strengthAdapter);
  PaletteUi.call(strength,"setOnSeekBarChangeListener",d.listener("micamx.compat.ui.widget.seekbar.a$a",(p,m,args)->{
   if(!binding&&m.getName().equals("b")&&Boolean.TRUE.equals(args[2])){panel.filterDegree=PaletteValues.clamp((Integer)args[1],0,100);panel.changed();}
   if(!binding&&m.getName().equals("d"))panel.persist();return null;
  }));
  View original=d.find(root,"filter_original");original.setOnClickListener(v->safe(()->choose(0,true)));
  // The included original-button layout uses the same real holder resources.
  Object none=models.get(0);TextView label=(TextView)original.findViewById(d.id("id","effect_item_text"));if(label!=null)label.setText(NativeFilters.number(none,"b"));
  ImageView image=(ImageView)original.findViewById(d.id("id","effect_item_image"));if(image!=null)image.setImageResource(NativeFilters.number(none,"c"));
  FrameLayout.LayoutParams lp=new FrameLayout.LayoutParams(-1,-2,Gravity.BOTTOM);lp.bottomMargin=panel.root.getHeight()+((ViewGroup.MarginLayoutParams)panel.root.getLayoutParams()).bottomMargin;panel.host.addView(root,panel.host.indexOfChild(panel.root),lp);
  covers=new NativeFilterCovers(this);list.getViewTreeObserver().addOnGlobalLayoutListener(()->safe(()->covers.bind()));list.setOnScrollChangeListener((v,x,y,ox,oy)->safe(()->covers.bind()));
  root.addOnLayoutChangeListener((v,l,t,r,b,ol,ot,or,ob)->reposition());refresh();root.post(()->safe(()->{refresh();reposition();covers.bind();}));
 }
 int dim(String name)throws Exception{return d.getResources().getDimensionPixelSize(d.type("fj.c").getField(name).getInt(null));}
 void reposition(){if(closed||root==null)return;int height=root.getHeight();
  if(panel.recipes!=null&&panel.recipes.strip!=null){FrameLayout.LayoutParams lp=(FrameLayout.LayoutParams)panel.recipes.strip.getLayoutParams();lp.bottomMargin=panel.root.getHeight()+height;panel.recipes.strip.setLayoutParams(lp);}
  if(!panel.pro&&panel.title!=null&&panel.title.getLayoutParams() instanceof FrameLayout.LayoutParams){FrameLayout.LayoutParams lp=(FrameLayout.LayoutParams)panel.title.getLayoutParams();lp.bottomMargin=panel.root.getHeight()+height+(panel.recipes==null||panel.recipes.strip==null?0:panel.recipes.strip.getHeight())+Math.round(20*d.getResources().getDisplayMetrics().density);panel.title.setLayoutParams(lp);}
 }
 void choose(int index,boolean center)throws Exception{
  if(closed||index<0||index>=entries.size()||binding)return;
  int id=(Integer)PaletteUi.call(entries.get(index),"a");NativeFilters.get(panel.activity).resolve(id);
  panel.filterId=id;panel.filterDegree=100;selected=index;panel.changed();panel.persist();update(center);
 }
 void refresh()throws Exception{
  if(root==null)return;selected=-1;for(int i=0;i<entries.size();i++)if((Integer)PaletteUi.call(entries.get(i),"a")==panel.filterId){selected=i;break;}
  // Imported built-in filters outside the Madrid menu keep their actual ID and
  // effect. Do not silently replace them with the first visible item.
  update(true);
 }
 void update(boolean center)throws Exception{
  binding=true;try{PaletteUi.field(adapter,"selected",selected);PaletteUi.field(list,"b",Math.max(0,selected));PaletteUi.call(adapter,"notifyDataSetChanged");
   boolean active=!NativeFilters.isNone(panel.filterId);strength.setVisibility(active?View.VISIBLE:View.GONE);PaletteUi.call(strength,"setProgress",panel.filterDegree);
   d.find(root,"filter_original").setVisibility(active?View.VISIBLE:View.GONE);
   PaletteUi.call(d.find(root,"filter_spring_layout"),"setIgnoreSide",active?0:(root.getLayoutDirection()==View.LAYOUT_DIRECTION_RTL?4:1));
   if(center&&selected>=0)PaletteUi.call(layout,"scrollToPositionWithOffset",selected+1,((Number)PaletteUi.call(adapter,"y")).intValue());
  }finally{binding=false;}
 }
 void safe(OriginalRecipes.Work action){try{action.run();}catch(Exception|LinkageError e){panel.recipes.error(e);}}
 void close(){closed=true;if(covers!=null)covers.close();if(root!=null){panel.host.removeView(root);root=null;}}
}
