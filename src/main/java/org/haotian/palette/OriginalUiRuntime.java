package org.haotian.palette;

import android.app.Application;
import android.content.*;
import android.content.pm.ApplicationInfo;
import android.content.res.*;
import android.util.AttributeSet;
import android.view.*;
import dalvik.system.DexClassLoader;
import java.io.*;
import java.lang.reflect.*;
import java.util.zip.*;

/** Loads donor bytecode and resources in one isolated namespace, preserving its styleable IDs. */
public final class OriginalUiRuntime extends ContextWrapper {
 private Resources resources;
 private final Resources.Theme theme;
 private final ClassLoader classes;
 private LayoutInflater inflater;
 private Application donorApplication;
 private static final java.util.HashMap<String,ClassLoader> LOADERS=new java.util.HashMap<>();
 public static OriginalUiRuntime attach(Context host)throws Exception {
  return new OriginalUiRuntime(host,extract(host,"haotian/donor-native.apk","palette-donor-680017700.apk"),extract(host,"haotian/native-compat.dex","palette-native-compat-t493.dex"));
 }
 private static File extract(Context host,String asset,String name)throws IOException {
  File out=new File(host.getFilesDir(),name);
  if(!out.exists()){
   File temp=new File(host.getFilesDir(),name+".tmp");
   try(FileOutputStream stream=new FileOutputStream(temp);InputStream in=host.getAssets().open(asset)){
    // ART requires dynamically loaded code to be read-only before loading.
    if(!temp.setReadOnly())throw new IOException("Cannot protect donor code");
    byte[] buf=new byte[65536];int n;while((n=in.read(buf))!=-1)stream.write(buf,0,n);
    stream.getFD().sync();
   }
   if(!temp.renameTo(out))throw new IOException("Cannot install donor bundle");
  }return out;
 }
 public OriginalUiRuntime(Context host,File archive)throws Exception {
  this(host,archive,null);
 }
 public OriginalUiRuntime(Context host,File archive,File compatibility)throws Exception {
  super(host);
  ApplicationInfo info=new ApplicationInfo();info.packageName="com.android.camera";
  info.sourceDir=archive.getAbsolutePath();info.publicSourceDir=info.sourceDir;info.uid=host.getApplicationInfo().uid;
  resources=host.getPackageManager().getResourcesForApplication(info);
  File nativeDir=new File(host.getFilesDir(),"palette-donor-libs-680017700");
  if(!nativeDir.isDirectory())nativeDir.mkdirs();
  try(ZipFile zip=new ZipFile(archive)){java.util.Enumeration<? extends ZipEntry> entries=zip.entries();while(entries.hasMoreElements()){ZipEntry e=entries.nextElement();if(!e.getName().startsWith("lib/arm64-v8a/")||!e.getName().endsWith(".so"))continue;File out=new File(nativeDir,new File(e.getName()).getName());if(!out.isFile()||out.length()!=e.getSize()){try(InputStream in=zip.getInputStream(e);OutputStream stream=new FileOutputStream(out)){byte[]buf=new byte[65536];int n;while((n=in.read(buf))!=-1)stream.write(buf,0,n);}out.setReadOnly();}}}
  String dexPath=(compatibility==null?"":compatibility.getAbsolutePath()+File.pathSeparator)+archive.getAbsolutePath();
  synchronized(LOADERS){ClassLoader cached=LOADERS.get(dexPath);if(cached==null){cached=new DexClassLoader(dexPath,host.getCodeCacheDir().getAbsolutePath(),nativeDir.getAbsolutePath(),ClassLoader.getSystemClassLoader().getParent());LOADERS.put(dexPath,cached);}classes=cached;}
  Context appHost=host.getApplicationContext();if(appHost==null)appHost=host;
  ResourceApplicationContext applicationContext=new ResourceApplicationContext(appHost,resources,classes);
  Application application=(Application)make("com.android.camera.CameraAppImpl");invoke(application,"bindPaletteContext",applicationContext);donorApplication=application;
  type("ud.A").getField("b").set(null,application);
  resources=(Resources)make("Jf.d",resources);
  applicationContext.resources=resources;
  theme=resources.newTheme();theme.applyStyle(android.R.style.Theme_DeviceDefault,true);
  // A clone of the host inflater inherits its AppCompat factory and constructor
  // cache. Those resolve classes/resources from the old Leica package.
  inflater=new NativeInflater(this);
  inflater.setFactory2(new LayoutInflater.Factory2(){
   public View onCreateView(View parent,String name,Context c,AttributeSet attrs){return onCreateView(name,c,attrs);}
   public View onCreateView(String name,Context c,AttributeSet attrs){
    if(name.indexOf('.')<0)return null;
    try {return (View)type(name).getConstructor(Context.class,AttributeSet.class).newInstance(OriginalUiRuntime.this,attrs);}
    catch(ReflectiveOperationException e){throw new android.view.InflateException("Original donor control: "+name,e);}
   }
  });
  type("com.xiaomi.camera.basic.Global").getMethod("init",Application.class,boolean.class,String.class,int.class,String.class).invoke(null,application,false,"6.8.001770.0",680017700,host.getPackageName());
  type("org.haotian.palette.isolated.OriginalRegistries").getMethod("initialize").invoke(null);
  type("f2.e").getField("c").set(null,make("f2.e",this));
  type("K2.b").getField("f").set(null,type("K2.i$a").getField("a").get(null));
  type("K2.g").getMethod("q",Context.class).invoke(null,this);
 }
 public void preparePictureStyle(int mode)throws Exception {
  android.hardware.camera2.CameraManager manager=(android.hardware.camera2.CameraManager)getSystemService(CAMERA_SERVICE);
  String rear=null;android.hardware.camera2.CameraCharacteristics characteristics=null;
  for(String id:manager.getCameraIdList()){
   android.hardware.camera2.CameraCharacteristics candidate=manager.getCameraCharacteristics(id);
   if(Integer.valueOf(android.hardware.camera2.CameraCharacteristics.LENS_FACING_BACK).equals(candidate.get(android.hardware.camera2.CameraCharacteristics.LENS_FACING))){rear=id;characteristics=candidate;break;}
  }
  if(rear==null)throw new IOException("无法读取后置相机能力，摄影风格未初始化");
  Object caps=make("l9.g",characteristics,Integer.parseInt(rear));
  Object state=make("com.android.camera.data.data.C",mode,0,caps,0,0,false);
  Object repository=type("g2.a").getMethod("j").invoke(null);
  Object style=invoke(repository,"x",type("v2.j0"));
  invoke(style,"R",make("v2.J0$a",state));
  if(!style.getClass().getField("a").getBoolean(style))throw new IOException("原生第二代摄影风格组件未就绪");
 }
 private static final class NativeInflater extends LayoutInflater {
  NativeInflater(Context context){super(context);}
  @Override public LayoutInflater cloneInContext(Context context){return new NativeInflater(context);}
  @Override protected View onCreateView(String name,AttributeSet attributes)throws ClassNotFoundException {
   for(String prefix:new String[]{"android.widget.","android.webkit.","android.app."}){
    try{return createView(name,prefix,attributes);}catch(ClassNotFoundException ignored){}
   }
   return super.onCreateView(name,attributes);
  }
 }
 private static final class DonorApplication extends Application {void bind(Context c){attachBaseContext(c);}}
 private static final class ResourceApplicationContext extends ContextWrapper {
  Resources resources;final ClassLoader classes;
  ResourceApplicationContext(Context c,Resources r,ClassLoader cl){super(c);resources=r;classes=cl;}
  @Override public Resources getResources(){return resources;}
  @Override public AssetManager getAssets(){return resources.getAssets();}
  @Override public ClassLoader getClassLoader(){return classes;}
 }
 @Override public Context getApplicationContext(){return donorApplication==null?getBaseContext().getApplicationContext():donorApplication;}
 @Override public ClassLoader getClassLoader(){return classes;}
 @Override public Resources getResources(){return resources;}
 @Override public AssetManager getAssets(){return resources.getAssets();}
 @Override public Resources.Theme getTheme(){return theme;}
 @Override public Object getSystemService(String key){return LAYOUT_INFLATER_SERVICE.equals(key)?inflater:super.getSystemService(key);}
 public Class<?> type(String name)throws ClassNotFoundException{return classes.loadClass(name);}
 public int id(String kind,String name){int n=resources.getIdentifier(name,kind,"com.android.camera");if(n==0)throw new Resources.NotFoundException(kind+"/"+name);return n;}
 public View inflate(String name,ViewGroup parent){return inflater.inflate(id("layout",name),parent,false);}
 public View find(View root,String name){return root.findViewById(id("id",name));}
 public int dim(String name){return resources.getDimensionPixelSize(id("dimen",name));}
 public Object make(String name,Object...args)throws Exception {
  for(Constructor<?> c:type(name).getConstructors())if(c.getParameterCount()==args.length){try{return c.newInstance(args);}catch(IllegalArgumentException mismatch){continue;}catch(InvocationTargetException e){throw new Exception(name,e.getCause());}}throw new NoSuchMethodException(name);
 }
 public Object listener(String name,InvocationHandler handler)throws Exception {
  Class<?> i=type(name);return Proxy.newProxyInstance(classes,new Class<?>[]{i},(p,m,args)->{
   if(m.getDeclaringClass()==Object.class){if(m.getName().equals("equals"))return p==args[0];if(m.getName().equals("hashCode"))return System.identityHashCode(p);return name;}
   return handler.invoke(p,m,args);
  });
 }
 public static Object invoke(Object object,String name,Object... args)throws Exception {
  for(Method m:object.getClass().getMethods()){
   if(!m.getName().equals(name)||m.getParameterCount()!=args.length)continue;
   try{return m.invoke(object,args);}catch(IllegalArgumentException wrongOverload){continue;}catch(InvocationTargetException e){throw new Exception(m.toString(),e.getCause());}
  }throw new NoSuchMethodException(object.getClass().getName()+"."+name);
 }
}

