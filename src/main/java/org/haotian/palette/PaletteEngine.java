package org.haotian.palette;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.os.Handler;
import android.os.Looper;
import android.widget.Toast;

public final class PaletteEngine {
 private static Context context;
 private static volatile PaletteValues values=new PaletteValues(false,new int[8]);
 private static final ThreadLocal<PaletteValues> capture=new ThreadLocal<>();
 private static final ThreadLocal<Boolean> applied=new ThreadLocal<>();
 private static boolean loaded;
 private static long lastNotice;
 public static void init(Context c){
  if(context!=null)return;context=c.getApplicationContext();PaletteDiagnostics.init(context);SharedPreferences p=context.getSharedPreferences("haotian_palette_v1",0);
  int[] a=new int[8];for(int i=0;i<8;i++)a[i]=p.getInt("p"+i,0);values=new PaletteValues(p.getBoolean("enabled",false),a,p.getInt("filter_id",NativeFilters.NONE),p.getInt("filter_degree",100));
 }
 static NativeFilters.Spec filter(PaletteValues v)throws Exception{return NativeFilters.get(context).resolve(v.filterId);}
 public static PaletteValues values(){return values;}
 public static boolean active(){NativeFilterCovers covers=NativeFilterCovers.current;return values.active()||(covers!=null&&!covers.closed);}
 static String library(){if(context==null)throw new IllegalStateException("Palette not initialized");return context.getApplicationInfo().nativeLibraryDir+"/libHtColorSDK2.so";}
 static synchronized void load(){if(!loaded){System.loadLibrary("haotian_palette_bridge");loaded=true;}}
 static void preview(PaletteValues v){values=v;}
 public static void save(PaletteValues v){values=v;if(context==null)return;SharedPreferences.Editor e=context.getSharedPreferences("haotian_palette_v1",0).edit().putBoolean("enabled",v.enabled).putInt("filter_id",v.filterId).putInt("filter_degree",v.filterDegree);int[] a=v.array();for(int i=0;i<8;i++)e.putInt("p"+i,a[i]);e.apply();}
 public static void begin(){capture.set(ProMode.renderValues());applied.set(false);}
 public static void clearCapture(){capture.remove();applied.remove();}
 public static void end(){PaletteValues v=capture.get();if(v!=null && v.active() && !Boolean.TRUE.equals(applied.get()))notice("本张未能应用调色盘，已保留徕卡原片");capture.remove();applied.remove();}
 public static Bitmap apply(Bitmap input){
  if(Boolean.TRUE.equals(applied.get()))return input;
  PaletteValues v=capture.get();if(v==null)v=values;
  if(!v.active()){applied.set(true);return input;}
  Bitmap output=null;
  try{
   if(input==null || input.isRecycled())throw new IllegalStateException("Missing photograph bitmap");
   // Process a copy so Java/linker/configuration failures leave the Leica bitmap intact.
   output=input.copy(Bitmap.Config.ARGB_8888,true);if(output==null)throw new OutOfMemoryError("Palette bitmap copy");
   NativeFilters.Spec prepared=filter(v);
   int[] before=PaletteDiagnostics.sample(output);render(output,v);PaletteDiagnostics.photo(output,before,"filter="+v.filterId+" degree="+v.filterDegree+" "+v.photoPipeline());
   if(android.os.Build.VERSION.SDK_INT>=34 && input.hasGainmap())output.setGainmap(input.getGainmap());
   applied.set(true);input.recycle();return output;
  }catch(Exception | LinkageError | OutOfMemoryError e){
   if(output!=null && output!=input && !output.isRecycled())output.recycle();
   android.util.Log.e("HaotianPalette","Palette failed; retaining Leica photograph",e);notice("调色盘处理失败，已保留徕卡原片");return input;
  }
 }
 public static synchronized void render(Bitmap bitmap,PaletteValues v)throws Exception{
  if(!v.active())return;if(context==null)throw new IllegalStateException("Palette not initialized");
  if(!loaded){System.loadLibrary("haotian_palette_bridge");loaded=true;}
  NativeFilters.Spec spec=filter(v);
  nativeRender(context.getApplicationInfo().nativeLibraryDir+"/libHtColorSDK2.so",bitmap,v.photoPipeline(),spec==null?null:spec.lut);
 }
 private static native void nativeRender(String library,Bitmap bitmap,String pipeline,Bitmap lut);
 static void notice(String message){long now=android.os.SystemClock.elapsedRealtime();if(context==null || now-lastNotice<2500)return;lastNotice=now;new Handler(Looper.getMainLooper()).post(()->Toast.makeText(context,message,Toast.LENGTH_LONG).show());}
}
