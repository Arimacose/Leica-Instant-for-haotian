package org.haotian.palette;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.view.View;

/** Bind host controls to the actual resumed camera, independently of legacy badge setup. */
public final class HostControls implements Application.ActivityLifecycleCallbacks {
 private static boolean registered;
 private static final java.util.WeakHashMap<Activity,android.view.ViewTreeObserver.OnPreDrawListener> layoutHooks=new java.util.WeakHashMap<>();
 public static void ensureUiHook(Activity a){
  if(a==null||a.isFinishing()||a.isDestroyed()||layoutHooks.containsKey(a))return;
  java.lang.ref.WeakReference<Activity> owner=new java.lang.ref.WeakReference<>(a);
  android.view.ViewTreeObserver.OnPreDrawListener listener=()->{Activity live=owner.get();if(live!=null&&!live.isFinishing()&&!live.isDestroyed())PaletteUi.refreshPicker(live);return true;};
  a.getWindow().getDecorView().getViewTreeObserver().addOnPreDrawListener(listener);layoutHooks.put(a,listener);
 }
 public static synchronized void init(Context context){
  Context app=context.getApplicationContext();
  if(!registered&&app instanceof Application){
   ((Application)app).registerActivityLifecycleCallbacks(new HostControls());registered=true;
  }
  if(context instanceof Activity)bind((Activity)context);
 }
 private static void bind(Activity a){
  if(!a.getClass().getName().equals("com.android.camera.Camera")||a.isFinishing()||a.isDestroyed())return;
  View root=a.getWindow().getDecorView();
  ensureUiHook(a);
  try{Class.forName("org.haotian.leicaport.NightControls").getMethod("refresh",View.class,Activity.class).invoke(null,root,a);}
  catch(Exception e){android.util.Log.e("HaotianPalette","Night control lifecycle binding",e);}
 }
 public void onActivityResumed(Activity a){bind(a);}
 public void onActivityCreated(Activity a,Bundle b){}
 public void onActivityStarted(Activity a){}
 public void onActivityPaused(Activity a){}
 public void onActivityStopped(Activity a){}
 public void onActivitySaveInstanceState(Activity a,Bundle b){}
 public void onActivityDestroyed(Activity a){android.view.ViewTreeObserver.OnPreDrawListener listener=layoutHooks.remove(a);if(listener!=null&&a.getWindow().getDecorView().getViewTreeObserver().isAlive())a.getWindow().getDecorView().getViewTreeObserver().removeOnPreDrawListener(listener);}
}
