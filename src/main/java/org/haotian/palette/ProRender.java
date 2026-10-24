package org.haotian.palette;
import java.lang.ref.WeakReference;
import java.lang.reflect.*;
import java.util.*;
import java.security.MessageDigest;
import android.os.SystemClock;

/** One JPEG boundary for native Pro and Legendary savers. RAW never enters the renderer. */
public final class ProRender {
 private static final LinkedHashMap<String,Entry> completed=new LinkedHashMap<>();
 private static final class Entry {final WeakReference<byte[]> bytes;final long time=SystemClock.elapsedRealtime();Entry(byte[] b){bytes=new WeakReference<>(b);}}
 private static volatile Method backend;
 static boolean jpeg(byte[] b){return b!=null&&b.length>=2&&(b[0]&255)==255&&(b[1]&255)==216;}
 private static String key(byte[] b,Object saver)throws Exception{
  MessageDigest digest=MessageDigest.getInstance("SHA-256");byte[] hash=digest.digest(b);StringBuilder s=new StringBuilder();
  android.hardware.camera2.CaptureResult r=ProMode.result(saver);
  if(r instanceof android.hardware.camera2.TotalCaptureResult){s.append(((android.hardware.camera2.TotalCaptureResult)r).getFrameNumber()).append(':');Long timestamp=r.get(android.hardware.camera2.CaptureResult.SENSOR_TIMESTAMP);s.append(timestamp).append(':');}
  for(byte n:hash){s.append(Character.forDigit((n>>>4)&15,16));s.append(Character.forDigit(n&15,16));}return s.toString();
 }
 private static void prune(){long now=SystemClock.elapsedRealtime();Iterator<Map.Entry<String,Entry>> it=completed.entrySet().iterator();while(it.hasNext()){Entry e=it.next().getValue();if(now-e.time>120000||e.bytes.get()==null)it.remove();}while(completed.size()>64)completed.remove(completed.keySet().iterator().next());}
 public static synchronized byte[] process(byte[] input,Object saver){
  if(!jpeg(input))return input;
  String id=null;ProMode.Shot previous=ProMode.RENDER.get();
  try{
   prune();id=key(input,saver);Entry done=completed.get(id);byte[] prior=done==null?null:done.bytes.get();if(prior!=null){android.util.Log.i("HaotianPro","JPEG duplicate render skipped");return prior;}
   ProMode.Shot shot=ProMode.shot(saver);ProMode.RENDER.set(shot);
   if(backend==null)backend=Class.forName("com.codex.leicaapp.LegendaryPostProcessor").getMethod("processLegendary",byte[].class,Object.class);
   byte[] output=(byte[])backend.invoke(null,input,saver);if(!jpeg(output))throw new IllegalStateException("Leica pipeline did not return a JPEG");
   Entry e=new Entry(output);completed.put(id,e);completed.put(key(output,saver),e);prune();
   android.util.Log.i("HaotianPro","JPEG complete mode="+(shot.pro?167:256)+" style="+(shot.m10r?"M10R":shot.m3?"M3":"M9")+" palette="+shot.palette.active());return output;
  }catch(Exception|LinkageError|OutOfMemoryError e){android.util.Log.e("HaotianPro","JPEG rendering failed; preserving source",e);PaletteEngine.notice("本张风格处理失败，已保留相机原片");return input;}
  finally{PaletteEngine.clearCapture();if(previous==null)ProMode.RENDER.remove();else ProMode.RENDER.set(previous);}
 }
}
