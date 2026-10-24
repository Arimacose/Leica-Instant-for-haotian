package org.haotian.palette;

import android.content.Context;
import android.graphics.Bitmap;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.*;

/** Donor filter catalog, resource resolver and immutable per-shot filter state. */
public final class NativeFilters {
 public static final int NONE=66048;
 private static NativeFilters shared;
 private final OriginalUiRuntime donor;
 private final LinkedHashMap<Integer,Spec> cache=new LinkedHashMap<Integer,Spec>(8,.75f,true){protected boolean removeEldestEntry(Map.Entry<Integer,Spec> e){return size()>8;}};
 private NativeFilters(Context host)throws Exception{this(OriginalUiRuntime.attach(host.getApplicationContext()));}
 NativeFilters(OriginalUiRuntime d){donor=d;}
 static synchronized NativeFilters get(Context host)throws Exception{if(shared==null)shared=new NativeFilters(host);return shared;}
 static boolean isNone(int id){return id==0||id==NONE;}
 static int number(Object o,String field)throws Exception{return o.getClass().getField(field).getInt(o);}
 static boolean flag(Object o,String field)throws Exception{return o.getClass().getField(field).getBoolean(o);}
 public static ArrayList<?> catalog(OriginalUiRuntime d)throws Exception{
  // The original Madrid software catalog only. Restore the provider even on failure;
  // this does not change Build, Camera2 capabilities, the host camera or cloud identity.
  d.type("Pe.b").getField("j").get(null);
  Object feature=d.type("Pe.b$b").getField("a").get(null);
  synchronized(feature){Field f=feature.getClass().getField("e");f.setAccessible(true);Object previous=f.get(feature);
   try{f.set(feature,d.make("횕횙횛훘횛횟훘횒횓횀횟횕횓훘횻횗횒횄횟횒"));return (ArrayList<?>)d.type("xi.h0").getMethod("d").invoke(null);}
   finally{f.set(feature,previous);}
  }
 }
 public synchronized Spec resolve(int id)throws Exception{
  if(isNone(id))return null;Spec cached=cache.get(id);if(cached!=null)return cached;
  Object[] types=(Object[])donor.type("o3.d").getMethod("values").invoke(null);
  int ordinal=id&65535;
  if(ordinal>=types.length||id<65536||id>>>16>23)throw new IOException("配方引用的滤镜不在供体内，需先取得对应云端滤镜资源："+id);
  Object attr=donor.type("si.f").getMethod("e",int.class,int.class,int.class,boolean.class).invoke(null,id,0,100,false);
  String resource=(String)attr.getClass().getField("b").get(attr);
  if(resource==null||resource.isEmpty()||flag(attr,"j"))throw new IOException("尚未取得此滤镜的实际资源："+id);
  // Verify the actual resource before calling the donor loader, which otherwise
  // silently substitutes a blank LUT. Do not accept that as a successful import.
  donor.id("raw",resource);
  // Use the actual decoder underneath OpenGl3dUtils, without its identity-LUT
  // fallback. MagicStringResources supplies the donor's decrypted resource stream.
  Bitmap lut=(Bitmap)donor.type("Nu.g").getMethod("b",Context.class,String.class).invoke(null,new android.content.ContextWrapper(donor){@Override public String getPackageName(){return "com.android.camera";}},resource);
  if(lut==null)throw new IOException("原生滤镜资源解码失败："+resource);
  Spec result=new Spec(id,String.valueOf(types[ordinal]),resource,lut,attr,donor,types[ordinal]);cache.put(id,result);return result;
 }
 public static final class Spec {
  public final int id;public final String name,resource;public final Bitmap lut;
  final OriginalUiRuntime donor;final Object type;
  final boolean dark,noise,sharpen;final float[] coefficients;final int mist;
  Spec(int id,String name,String resource,Bitmap lut,Object attr,OriginalUiRuntime donor,Object type)throws Exception{
   this.donor=donor;this.type=type;
   this.id=id;this.name=name;this.resource=resource;this.lut=lut;
   dark=flag(attr,"c");noise=flag(attr,"f");sharpen=flag(attr,"h");mist=number(attr,"o");
   float[] v=(float[])attr.getClass().getField("i").get(attr);coefficients=v==null||v.length==0?new float[]{1.4f,1f,.2f,1f,.4f,.4f}:v.clone();
   if(coefficients.length<6)throw new IOException("原生滤镜参数不完整："+name);
  }
  public String photoPipeline(int degree)throws Exception{
   Object tag=donor.make("com.xiaomi.camera.mivi.filter.MIVIRenderTag",id,degree);
   java.lang.reflect.Constructor<?> ctor=donor.type("com.xiaomi.camera.mivi.filter.MIVIRenderTag$TagForCandy").getDeclaredConstructor(tag.getClass());ctor.setAccessible(true);Object script=ctor.newInstance(tag);
   Object info=donor.type("xi.h0").getMethod("f",donor.type("o3.d"),boolean.class,int.class,int.class).invoke(null,type,false,0,degree);
   java.lang.reflect.Method method=script.getClass().getDeclaredMethod("getFilterCandyParams",info.getClass());method.setAccessible(true);return (String)method.invoke(script,info);
  }
  public String pipeline(int degree){
   // Exact Tu.h.g Candy configuration: optional filter mist -> LUT -> CV ->
   // sharpening. Lu.b.g subsequently applies Tu.r's photographic style.
   StringBuilder b=new StringBuilder();
   if(mist==1)b.append("BlackMistEffect;LumThresh=0.5;Raduis=4.0;MixRatio=1.0");
   else if(mist==2)b.append("WhiteMistEffect;LumThresh=0.1;Raduis=4.0;MixRatio=1.0");
   b.append("@CubeLutEffect;cube_strength=").append(PaletteValues.clamp(degree,0,100)/100f).append(';');
   float[] v=coefficients;
   if(dark||noise||v[3]==0f||v[4]==0f){b.append("@CvEffect;");if(dark||v[3]==0f)b.append("SmoothStartValue=").append(v[0]).append(";Falloff=").append(v[1]).append(";SmoothEndValue=").append(v[2]).append(";DarkStrength=").append(v[3]).append(';');if(noise||v[4]==0f)b.append("NoiseStrength=").append(v[4]).append(';');}
   if(sharpen)b.append("@SharpenEffect;SharpenIntensity=").append(v[5]);return b.toString();
  }
 }
}
