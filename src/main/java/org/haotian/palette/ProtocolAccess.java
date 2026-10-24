package org.haotian.palette;
/** Process-local compatibility for Xiaomi's camera protocol DTOs, not a system policy change. */
public final class ProtocolAccess {
 private static boolean attempted,ready;
 public static synchronized boolean ensure(){
  if(attempted)return ready;attempted=true;
  try{
   Object ok=Class.forName("org.lsposed.hiddenapibypass.HiddenApiBypass").getMethod("setHiddenApiExemptions",String[].class).invoke(null,(Object)new String[]{"Lcom/xiaomi/protocol/"});
   if(!Boolean.TRUE.equals(ok))throw new IllegalStateException("Protocol access initialization rejected");
   Class<?> type=Class.forName("com.xiaomi.protocol.IImageReaderParameterSets");
   Object test=type.getConstructor(int.class,int.class,int.class,int.class,int.class,int.class).newInstance(16,16,35,2,0,1);
   type.getMethod("setPhysicCameraId",int.class).invoke(test,-1);ready=type.getField("width").getInt(test)==16;
   android.util.Log.i("HaotianPro","Xiaomi protocol process-local access="+ready+" scope=com.xiaomi.protocol");
  }catch(ReflectiveOperationException|LinkageError|RuntimeException e){android.util.Log.e("HaotianPro","Xiaomi protocol compatibility unavailable",e);}
  return ready;
 }
}
