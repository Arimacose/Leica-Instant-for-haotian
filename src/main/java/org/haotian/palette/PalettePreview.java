package org.haotian.palette;
import android.opengl.*;
import android.util.Size;
import java.lang.reflect.*;

/** Runs on the existing preview GL thread, after the Leica effects and before display. */
public final class PalettePreview {
 private static final ThreadLocal<State> STATES=new ThreadLocal<>();
 private static class State {long handle;EGLContext context;String pipeline;int filterId=-1;boolean failed;}
 private static Field a,b,dimension;private static Method texture,framebuffer,swap;
 private static final float[] IDENTITY={1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1};
 public static void draw(Object buffers){
  PaletteValues values=PaletteEngine.values();if(buffers==null)return;
  State state=STATES.get();EGLContext context=EGL14.eglGetCurrentContext();if(context==null || context.equals(EGL14.EGL_NO_CONTEXT))return;
  if(state==null || !context.equals(state.context)){state=new State();state.context=context;STATES.set(state);}
  if(state.failed)return;
  try{
   if(a==null){Class<?> pair=buffers.getClass();a=pair.getField("a");b=pair.getField("b");swap=pair.getMethod("d");Class<?> target=a.getType();texture=target.getMethod("c");framebuffer=target.getMethod("a");dimension=target.getField("d");}
   Object source=a.get(buffers),destination=b.get(buffers);if(source==null || destination==null)return;Size size=(Size)dimension.get(source);if(size==null || size.getWidth()<1 || size.getHeight()<1)return;
   NativeFilterCovers.draw((Integer)texture.invoke(source),size.getWidth(),size.getHeight());if(!values.active())return;
   PaletteEngine.load();if(state.handle==0)state.handle=nativeCreate(PaletteEngine.library());if(state.handle==0)throw new IllegalStateException("Donor preview init failed");
   NativeFilters.Spec spec=PaletteEngine.filter(values);
   String config=values.pipeline();String update=config.equals(state.pipeline)?null:config;
   nativeDraw(state.handle,(Integer)texture.invoke(source),(Integer)framebuffer.invoke(destination),size.getWidth(),size.getHeight(),IDENTITY,config,spec==null?null:spec.lut,values.filterId);
   if((update!=null||state.filterId!=values.filterId)&&PaletteDiagnostics.enabled())PaletteDiagnostics.event("PREVIEW filter="+values.filterId+" degree="+values.filterDegree+" size="+size+" source="+source+" destination="+destination+" pixelStats="+java.util.Arrays.toString(nativeCompare((Integer)framebuffer.invoke(source),(Integer)framebuffer.invoke(destination),size.getWidth(),size.getHeight()))+" pipeline="+config);
   state.pipeline=config;state.filterId=values.filterId;swap.invoke(buffers);
  }catch(Exception | LinkageError e){state.failed=true;PaletteDiagnostics.event("PREVIEW_ERROR "+e);android.util.Log.e("HaotianPalette","Live palette failed; keeping original preview",e);PaletteEngine.notice("调色盘实时预览未就绪，请重新打开相机后重试");}
 }
 public static void release(){NativeFilterCovers.release();State state=STATES.get();STATES.remove();if(state==null || state.handle==0)return;try{if(state.context.equals(EGL14.eglGetCurrentContext()))nativeRelease(state.handle);}catch(Exception|LinkageError e){android.util.Log.e("HaotianPalette","Preview cleanup",e);}}
 private static native long nativeCreate(String path);
 private static native void nativeDraw(long handle,int texture,int framebuffer,int width,int height,float[] matrix,String config,android.graphics.Bitmap lut,int filterId);
 private static native void nativeRelease(long handle);
 private static native float[] nativeCompare(int source,int destination,int width,int height);
}
