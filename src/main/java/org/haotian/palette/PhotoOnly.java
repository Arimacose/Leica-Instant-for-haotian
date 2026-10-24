package org.haotian.palette;

import android.content.Context;
import android.content.Intent;
import java.util.List;

/** Close every mode-selection route without removing shared live-photo codecs. */
public final class PhotoOnly {
 public static void init(Context context){
  if(context==null)return;
  Context app=context.getApplicationContext();
  ProMode.init(app);PaletteEngine.init(app);HostControls.init(app);
 }
 public static boolean shortcuts(android.content.pm.ShortcutManager manager,List<android.content.pm.ShortcutInfo> list){
  java.util.ArrayList<android.content.pm.ShortcutInfo> photos=new java.util.ArrayList<>();
  for(android.content.pm.ShortcutInfo s:list)if(!"VIDEO".equals(s.getId()))photos.add(s);
  manager.removeDynamicShortcuts(java.util.Collections.singletonList("VIDEO"));
  if(!manager.getPinnedShortcuts().isEmpty())manager.disableShortcuts(java.util.Collections.singletonList("VIDEO"),"此版本已移除录像功能");
  return manager.setDynamicShortcuts(photos);
 }
 public static int mode(int requested){return ProMode.select(requested);}
 public static void settings(Object group){
  if(group==null)return;
  try{
   Class<?> g=Class.forName("androidx.preference.PreferenceGroup"),p=Class.forName("androidx.preference.Preference");
   for(Object item:new java.util.ArrayList<>((java.util.List<?>)g.getField("h0").get(group))){
    String key=(String)p.getField("m").get(item);
    if(key!=null && (key.contains("video") || key.equals("pref_camera_movie_solid_key") || key.equals("pref_camera_volume_function_shutter_category_long_press_key")))p.getMethod("f0",boolean.class).invoke(item,false);
    if(g.isInstance(item))settings(item);
   }
  }catch(Exception e){android.util.Log.e("HaotianPhotoOnly","Settings pruning",e);}
 }
 public static Object launch(Object pair,Intent intent){
  try{
   Object previous=pair.getClass().getField("b").get(pair);int target=previous instanceof Number?ProMode.normalise(((Number)previous).intValue()):256;
   if(intent!=null){String requested=intent.getStringExtra("android.intent.extra.CAMERA_MODE");if("MANUAL_MODE".equals(requested)||"PRO".equals(requested)||"MANUAL".equals(requested))target=167;else if("CAPTURE".equals(requested))target=256;intent.putExtra("android.intent.extra.CAMERA_MODE",target==167?"MANUAL_MODE":"CAPTURE");String a=intent.getAction();if("android.media.action.VIDEO_CAMERA".equals(a)||"android.media.action.VIDEO_CAPTURE".equals(a))intent.setAction("android.intent.action.MAIN");}
   Object global=Class.forName("g2.a").getMethod("g").invoke(null);global.getClass().getMethod("c0",int.class).invoke(global,target);ProMode.select(target);
   Object camera=pair.getClass().getField("a").get(pair);
   return pair.getClass().getConstructor(Object.class,Object.class).newInstance(camera,Integer.valueOf(target));
  }catch(Exception e){android.util.Log.e("HaotianPhotoOnly","Launch normalization",e);return pair;}
 }
 @SuppressWarnings({"rawtypes","unchecked"})
 public static void modes(List all,List primary,List more){
  try{
   Object photo=null,pro=null;
   for(Object item:all){String id=String.valueOf(item.getClass().getField("q").get(item));if("256".equals(id))photo=item;else if("167".equals(id))pro=item;}
   if(photo==null)throw new IllegalStateException("Legendary mode missing");
   photo.getClass().getField("k").setInt(photo,-1);
   photo.getClass().getField("n").set(photo,"徕卡一瞬 · 调色盘");
   if(pro==null)pro=ProMode.newProItem();
   if(!"167".equals(String.valueOf(pro.getClass().getField("q").get(pro))))throw new IllegalStateException("Native professional item has wrong module ID");
   all.clear();all.add(photo);all.add(pro);more.clear();primary.clear();primary.add(photo);primary.add(pro);
   Class.forName("Q5.J").getMethod("h").invoke(null);
  }catch(Exception e){android.util.Log.e("HaotianPhotoOnly","Mode list",e);throw new IllegalStateException("Photo-only mode list could not be built",e);}
 }
}
