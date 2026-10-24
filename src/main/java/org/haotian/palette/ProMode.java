package org.haotian.palette;
import android.content.*;import android.hardware.camera2.*;import android.os.*;import java.lang.reflect.*;import java.util.*;

/** Native ProModule integration; never substitutes UI sliders or a separate camera backend. */
public final class ProMode {
 public static final int PHOTO=256,PRO=167;
 private static volatile int mode=PHOTO;
 private static volatile Context context;
 static final class Shot {
  final boolean pro,m3,m10r;final PaletteValues palette;
  Shot(boolean p){pro=p;m3=styleFlag("useM3");m10r=styleFlag("useM10R");palette=PaletteEngine.values();}
 }
 private static final Map<CaptureRequest,Shot> REQUEST_MODES=Collections.synchronizedMap(new WeakHashMap<CaptureRequest,Shot>());
 static final ThreadLocal<Shot> RENDER=new ThreadLocal<>();
 static boolean styleFlag(String name){try{Field f=Class.forName("com.codex.leicaapp.LegendaryPostProcessor").getDeclaredField(name);f.setAccessible(true);return f.getBoolean(null);}catch(ReflectiveOperationException|LinkageError e){return false;}}
 public static boolean useM3(){Shot s=RENDER.get();return s==null?styleFlag("useM3"):s.m3;}
 public static boolean useM10R(){Shot s=RENDER.get();return s==null?styleFlag("useM10R"):s.m10r;}
 public static boolean renderingProfessional(){Shot s=RENDER.get();return s!=null&&s.pro;}
 static PaletteValues renderValues(){Shot s=RENDER.get();return s==null?PaletteEngine.values():s.palette;}
 public static void init(Context c){if(c!=null){context=c.getApplicationContext();ProtocolAccess.ensure();}}
 private static volatile Method nativeGlobal,nativeReadMode;
 private static volatile Field nativeIntentType;
 private static int selectedNativeMode(){
  try{
   Method access=nativeGlobal;
   if(access==null){synchronized(ProMode.class){if(nativeGlobal==null){Class<?> type=Class.forName("u2.X");nativeReadMode=type.getMethod("E",int.class);nativeIntentType=type.getField("u");nativeGlobal=Class.forName("g2.a").getMethod("g");}access=nativeGlobal;}}
   Object state=access.invoke(null);
   return ((Number)nativeReadMode.invoke(state,nativeIntentType.getInt(state))).intValue();
  }catch(ReflectiveOperationException|LinkageError|RuntimeException e){return mode;}
 }
 public static boolean isActive(){return selectedNativeMode()==PRO;}
 public static String modeTitle(Object fragment,int id){
  if(id<=0)return "徕卡一瞬 · 调色盘";
  try{return (String)fragment.getClass().getMethod("getString",int.class).invoke(fragment,id);}
  catch(ReflectiveOperationException|RuntimeException e){android.util.Log.w("HaotianPro","Mode title unavailable",e);return isActive()?"专业":"徕卡一瞬 · 调色盘";}
 }
 private static final Map<Integer,Boolean> verifiedManualIds=new HashMap<>();
 public static synchronized int roleId(int role){
  if(!isActive()||!"haotian".equals(Build.DEVICE)||context==null)return -2;
  int id=role==0?0:role==1?3:4;
  Boolean verified=verifiedManualIds.get(id);
  if(verified==null){
   boolean good=false;
   try{CameraCharacteristics c=((CameraManager)context.getSystemService(Context.CAMERA_SERVICE)).getCameraCharacteristics(String.valueOf(id));Integer facing=c.get(CameraCharacteristics.LENS_FACING);int[] caps=c.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES);if(facing!=null&&facing==CameraCharacteristics.LENS_FACING_BACK&&caps!=null)for(int cap:caps)if(cap==CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_MANUAL_SENSOR)good=true;}
   catch(CameraAccessException|RuntimeException e){android.util.Log.w("HaotianPro","Manual lens unavailable: "+id,e);}
   verified=good;verifiedManualIds.put(id,verified);
  }
  return verified?id:-2;
 }
 public static ArrayList<Integer> manualLensIds(){
  if(roleId(0)<0||roleId(1)<0||roleId(2)<0)return null;
  ArrayList<Integer> ids=new ArrayList<>();ids.add(roleId(1));ids.add(roleId(0));ids.add(roleId(2));return ids;
 }
 public static float[] uniqueManualZooms(float[] choices){
  if(!isActive()||choices==null||choices.length<2)return choices;
  int size=0;float[] unique=new float[choices.length];
  for(float choice:choices){boolean duplicate=false;for(int n=0;n<size;n++)if(Math.abs(unique[n]-choice)<0.001f){duplicate=true;break;}if(!duplicate)unique[size++]=choice;}
  return size==choices.length?choices:Arrays.copyOf(unique,size);
 }
 public static boolean allowAi(Object controller){
  try{
   Field activity=controller.getClass().getDeclaredField("activity");activity.setAccessible(true);Object host=activity.get(controller);
   if(host instanceof android.app.Activity)HostControls.ensureUiHook((android.app.Activity)host);
   if(!isActive())return Boolean.TRUE.equals(Class.forName("org.haotian.leicaport.HaotianPort").getMethod("photoUiAllowed",Object.class).invoke(null,controller));
   Field enabled=controller.getClass().getDeclaredField("enabled");enabled.setAccessible(true);
   if(enabled.getBoolean(controller)){Method stop=controller.getClass().getDeclaredMethod("setEnabled",boolean.class);stop.setAccessible(true);stop.invoke(controller,false);}
  }catch(ReflectiveOperationException|RuntimeException e){android.util.Log.w("HaotianPro","AI mode isolation failed",e);}
  return false;
 }
 public static void trace(String event){
  if(!isActive()||!new java.io.File("/storage/emulated/0/Android/data/com.Lieca.test/files/haotian_diagnostics.flag").isFile())return;
  try{Class.forName("org.haotian.leicaport.HaotianPort").getMethod("line",String.class).invoke(null,"PRO_UI_TRACE "+event+"\n"+android.util.Log.getStackTraceString(new Exception(event)));}catch(ReflectiveOperationException|RuntimeException e){android.util.Log.w("HaotianPro","UI trace unavailable",e);}
 }
 public static boolean parallelAvailable(){
  try{Object provider=Class.forName("wp.g$c").getField("a").get(null);return provider.getClass().getMethod("a").invoke(provider)!=null;}
  catch(ReflectiveOperationException|LinkageError|RuntimeException e){return false;}
 }
 public static int current(){return selectedNativeMode();}
 public static int normalise(int requested){return requested==PRO?PRO:PHOTO;}
 public static int select(int requested){int next=normalise(requested);if(mode!=next){mode=next;if(next==PRO&&new java.io.File("/storage/emulated/0/Android/data/com.Lieca.test/files/haotian_diagnostics.flag").isFile())new Handler(Looper.getMainLooper()).postDelayed(ProMode::auditWaitingThreads,4000);}return next;}
 private static void auditWaitingThreads(){
  if(!isActive()||!new java.io.File("/storage/emulated/0/Android/data/com.Lieca.test/files/haotian_diagnostics.flag").isFile())return;
  try{StringBuilder b=new StringBuilder("PRO_WAIT_STACKS\n");for(Map.Entry<Thread,StackTraceElement[]> e:Thread.getAllStackTraces().entrySet()){b.append(e.getKey().getName()).append(' ').append(e.getKey().getState()).append('\n');for(StackTraceElement f:e.getValue())b.append("  ").append(f).append('\n');}Class.forName("org.haotian.leicaport.HaotianPort").getMethod("line",String.class).invoke(null,b.toString());}catch(ReflectiveOperationException|RuntimeException e){android.util.Log.w("HaotianPro","Diagnostic stack read failed",e);}
 }
 public static CaptureRequest remember(CaptureRequest request,boolean pro){if(request!=null)REQUEST_MODES.put(request,new Shot(pro));return request;}
 public static boolean isProRequest(CaptureRequest request){Shot value=REQUEST_MODES.get(request);return value!=null?value.pro:isActive();}
 public static boolean isProRequests(java.util.List<?> requests){return requests!=null&&!requests.isEmpty()&&requests.get(0) instanceof CaptureRequest&&isProRequest((CaptureRequest)requests.get(0));}
 static CaptureResult result(Object saver){if(saver!=null)try{Object metadata=saver.getClass().getField("f").get(saver);Object result=metadata.getClass().getField("b").get(metadata);if(result==null)result=metadata.getClass().getField("c").get(metadata);if(result instanceof CaptureResult)return (CaptureResult)result;}catch(ReflectiveOperationException|RuntimeException ignored){}return null;}
 static Shot shot(Object saver){CaptureResult r=result(saver);if(r instanceof TotalCaptureResult){Shot s=REQUEST_MODES.get(((TotalCaptureResult)r).getRequest());if(s!=null)return s;}boolean p=isActive();if(saver!=null)try{Object data=saver.getClass().getField("b").get(saver);int id=data.getClass().getField("g").getInt(data);if(id==PRO||id==PHOTO)p=id==PRO;}catch(ReflectiveOperationException|RuntimeException ignored){}return new Shot(p);}
 public static boolean isProCapture(Object saver){return shot(saver).pro;}
 static Object newProItem()throws Exception {
  Context c=context;if(c==null)c=(Context)Class.forName("android.app.ActivityThread").getMethod("currentApplication").invoke(null);
  Object entry=Class.forName("com.android.camera.features.mode.pro.photo.ProModuleEntry").getConstructor(Context.class).newInstance(c);
  Object item=entry.getClass().getMethod("getModeItem").invoke(entry);return item.getClass().getField("a").get(item);
 }
 public static boolean supported(){
  if(!"haotian".equals(Build.DEVICE))return false;
  Context c=context;if(c==null)return true;
  try{CameraManager manager=(CameraManager)c.getSystemService(Context.CAMERA_SERVICE);int[] capabilities=manager.getCameraCharacteristics("0").get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES);if(capabilities!=null)for(int value:capabilities)if(value==CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_MANUAL_SENSOR)return true;}catch(CameraAccessException|RuntimeException e){android.util.Log.w("HaotianPro","Manual sensor metadata unavailable",e);}
  return false;
 }
}
