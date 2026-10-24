package org.haotian.palette;

import android.content.*;import android.graphics.*;import android.opengl.*;import android.view.*;import java.util.*;

/** Donor CoverRenderEngine (Lu.b) attached to the donor TextureViews.
 * Only the host frame and EGL surface/lifecycle boundary is adapted. */
final class NativeFilterCovers {
 static volatile NativeFilterCovers current;
 static final java.util.concurrent.ConcurrentLinkedQueue<NativeFilterCovers> retired=new java.util.concurrent.ConcurrentLinkedQueue<>();
 final NativeFilterUi ui;final OriginalUiRuntime d;
 final ArrayList<Target> targets=new ArrayList<>();
 volatile Target[] visible=new Target[0];volatile boolean closed;
 Object engine,color;EGLContext context;long lastFrame;boolean failed;
 final Set<Integer> diagnosed=new HashSet<>();
 boolean sourceDiagnosed;
 static final float[] IDENTITY={1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1};
 final class Target implements TextureView.SurfaceTextureListener {
  final TextureView view;volatile int id;volatile SurfaceTexture texture;volatile int width,height;EGLSurface surface;SurfaceTexture bound;final ArrayList<SurfaceTexture> pendingRelease=new ArrayList<>();boolean disposed;
  Target(TextureView v,int filter){view=v;id=filter;v.setOpaque(true);v.setSurfaceTextureListener(this);if(v.isAvailable())onSurfaceTextureAvailable(v.getSurfaceTexture(),v.getWidth(),v.getHeight());}
  public void onSurfaceTextureAvailable(SurfaceTexture t,int w,int h){synchronized(targets){texture=t;width=w;height=h;disposed=false;}}
  public void onSurfaceTextureSizeChanged(SurfaceTexture t,int w,int h){width=w;height=h;}
  public boolean onSurfaceTextureDestroyed(SurfaceTexture t){synchronized(targets){if(texture==t)texture=null;if(disposed)t.release();else pendingRelease.add(t);}return false;}
  public void onSurfaceTextureUpdated(SurfaceTexture t){}
 }
 NativeFilterCovers(NativeFilterUi ui){this.ui=ui;d=ui.d;NativeFilterCovers old=current;if(old!=null){old.close();retired.add(old);}current=this;}
 NativeFilterCovers(OriginalUiRuntime d){ui=null;this.d=d;}
 void bind()throws Exception{
  if(closed||ui.root==null)return;ArrayList<Target> active=new ArrayList<>();
  ViewGroup list=(ViewGroup)ui.list;
  for(int i=0;i<list.getChildCount();i++){View item=list.getChildAt(i);Object tag=item.getTag();if(!(tag instanceof Integer))continue;int index=(Integer)tag-1;if(index<0||index>=ui.entries.size())continue;TextureView v=(TextureView)item.findViewById(d.id("id","effect_item_realtime"));if(v!=null)active.add(target(v,(Integer)PaletteUi.call(ui.entries.get(index),"a")));}
  View original=d.find(ui.root,"filter_original");if(original.getVisibility()==View.VISIBLE){TextureView v=(TextureView)original.findViewById(d.id("id","effect_item_realtime"));if(v!=null)active.add(target(v,NativeFilters.NONE));}
  visible=active.toArray(new Target[0]);
 }
 Target target(TextureView v,int id){synchronized(targets){for(Target t:targets)if(t.view==v){t.id=id;return t;}Target t=new Target(v,id);targets.add(t);return t;}}
 void init()throws Exception{
  if(engine!=null)return;
  Context renderContext=new ContextWrapper(d){@Override public String getPackageName(){return "com.android.camera";}};
  engine=d.make("Lu.b",renderContext,(Object)null);((Runnable)d.make("Lu.a",engine,0)).run();color=d.type("Nu.a").getField("a").get(null);
  // The host frame is already a 2D FBO texture; donor camera input was OES.
  Object source=engine.getClass().getField("c").get(engine);PaletteUi.call(source,"d");
  PaletteUi.field(engine,"c",d.make("Ru.a",d.type("Ku.e").getField("a").get(null)));
 }
 void renderIntoCurrent(int texture,int sw,int sh,int width,int height,int id,int degree)throws Exception{
  // Donor Ru.a uses client-side FloatBuffers. A Leica VBO left bound makes
  // those addresses be interpreted as buffer offsets and produces black output.
  GLES30.glBindVertexArray(0);GLES20.glBindBuffer(GLES20.GL_ARRAY_BUFFER,0);
  init();PaletteUi.call(engine,"f",width,height);
  boolean diagnose=PaletteDiagnostics.enabled()&&!sourceDiagnosed;sourceDiagnosed=true;
  if(diagnose){int[] sampler=new int[1],mask=new int[4];GLES20.glActiveTexture(GLES20.GL_TEXTURE0);GLES30.glGetIntegerv(GLES30.GL_SAMPLER_BINDING,sampler,0);GLES20.glGetIntegerv(GLES20.GL_COLOR_WRITEMASK,mask,0);PaletteDiagnostics.event("COVER_SOURCE texture="+texture+" pixels="+textureMean(texture,sw,sh)+" sampler="+sampler[0]+" mask="+Arrays.toString(mask)+" stencil="+GLES20.glIsEnabled(GLES20.GL_STENCIL_TEST)+" discard="+GLES30.glIsEnabled(GLES30.GL_RASTERIZER_DISCARD));}
  int tw=width,th=height,ox=0,oy=0;if(width*sh>height*sw){th=width*sh/sw;oy=-(th-height)/2;}else{tw=height*sw/sh;ox=-(tw-width)/2;}
  ((Rect)engine.getClass().getField("h").get(engine)).set(ox,oy,ox+tw,oy+th);
  PaletteUi.field(engine.getClass().getField("c").get(engine),"v",true);
  PaletteUi.call(engine,"i",texture,IDENTITY.clone(),color);
  if(diagnose){Object buffer=engine.getClass().getField("e").get(engine);PaletteDiagnostics.event("COVER_COPY pixels="+textureMean((Integer)PaletteUi.call(buffer,"c"),width,height));}
  Object request=d.make("Mu.c");PaletteUi.field(request,"a",id);PaletteUi.field(request,"h",!NativeFilters.isNone(id));PaletteUi.field(request,"c",true);PaletteUi.field(request,"k",color);PaletteUi.field(request,"l",color);PaletteUi.field(request,"m",IDENTITY.clone());PaletteUi.field(request,"s",width);PaletteUi.field(request,"t",height);
  if(!NativeFilters.isNone(id))PaletteUi.field(request,"u",d.type("si.f").getMethod("e",int.class,int.class,int.class,boolean.class).invoke(null,id,0,degree,false));
  PaletteUi.call(engine,"g",request);
 }
 static double textureMean(int texture,int width,int height){int[] previous=new int[1],fbo=new int[1];GLES30.glGetIntegerv(GLES30.GL_READ_FRAMEBUFFER_BINDING,previous,0);GLES30.glGenFramebuffers(1,fbo,0);GLES30.glBindFramebuffer(GLES30.GL_READ_FRAMEBUFFER,fbo[0]);GLES30.glFramebufferTexture2D(GLES30.GL_READ_FRAMEBUFFER,GLES30.GL_COLOR_ATTACHMENT0,GLES30.GL_TEXTURE_2D,texture,0);java.nio.ByteBuffer pixels=java.nio.ByteBuffer.allocateDirect(256);GLES30.glReadPixels(width/2-4,height/2-4,8,8,GLES30.GL_RGBA,GLES30.GL_UNSIGNED_BYTE,pixels);int sum=0;for(int i=0;i<256;i++)if(i%4!=3)sum+=pixels.get(i)&255;GLES30.glBindFramebuffer(GLES30.GL_READ_FRAMEBUFFER,previous[0]);GLES30.glDeleteFramebuffers(1,fbo,0);return sum/192.0;}
 static void draw(int texture,int width,int height){NativeFilterCovers old;while((old=retired.poll())!=null)old.drawFrame(0,1,1);NativeFilterCovers c=current;if(c!=null)c.drawFrame(texture,width,height);}
 void drawFrame(int input,int width,int height){
  if(failed&&!closed)return;long now=android.os.SystemClock.uptimeMillis();if(!closed&&now-lastFrame<80)return;lastFrame=now;
  EGLDisplay display=EGL14.eglGetCurrentDisplay();EGLContext ctx=EGL14.eglGetCurrentContext();if(ctx.equals(EGL14.EGL_NO_CONTEXT))return;
  EGLSurface oldDraw=EGL14.eglGetCurrentSurface(EGL14.EGL_DRAW),oldRead=EGL14.eglGetCurrentSurface(EGL14.EGL_READ);long guard=0;
  try{
   PaletteEngine.load();guard=nativeSaveGl();
   if(context!=null&&!context.equals(ctx)){engine=null;synchronized(targets){for(Target t:targets){if(t.surface!=null)EGL14.eglDestroySurface(display,t.surface);t.surface=null;}}}context=ctx;
   Target[] selected=closed?new Target[0]:visible;Set<Target> live=new HashSet<>(Arrays.asList(selected));
   synchronized(targets){for(Iterator<Target> it=targets.iterator();it.hasNext();){Target t=it.next();if(!live.contains(t)||t.texture==null||t.texture!=t.bound){if(t.surface!=null){EGL14.eglDestroySurface(display,t.surface);t.surface=null;t.bound=null;}for(SurfaceTexture stale:t.pendingRelease)stale.release();t.pendingRelease.clear();if(t.texture==null||closed){t.disposed=true;it.remove();}}}}
   if(closed){if(engine!=null){PaletteUi.call(engine,"h");engine=null;}if(current==this)current=null;return;}
   int[] configId=new int[1];EGL14.eglQueryContext(display,ctx,EGL14.EGL_CONFIG_ID,configId,0);EGLConfig[] configs=new EGLConfig[1];int[] count=new int[1];if(!EGL14.eglChooseConfig(display,new int[]{EGL14.EGL_CONFIG_ID,configId[0],EGL14.EGL_NONE},0,configs,0,1,count,0))throw new IllegalStateException("Cover EGL config");
   synchronized(targets){for(Target t:selected){SurfaceTexture target=t.texture;if(target==null||target.isReleased()||t.width<=0||t.height<=0)continue;if(t.surface==null){t.surface=EGL14.eglCreateWindowSurface(display,configs[0],target,new int[]{EGL14.EGL_NONE},0);if(t.surface.equals(EGL14.EGL_NO_SURFACE)){t.surface=null;continue;}t.bound=target;}
    if(!EGL14.eglMakeCurrent(display,t.surface,t.surface,ctx))continue;
    GLES20.glDisable(GLES20.GL_SCISSOR_TEST);GLES20.glDisable(GLES20.GL_DEPTH_TEST);GLES20.glDisable(GLES20.GL_CULL_FACE);
    renderIntoCurrent(input,width,height,t.width,t.height,t.id,100);
    if(PaletteDiagnostics.enabled()&&diagnosed.add(t.id)){GLES30.glBindFramebuffer(GLES30.GL_READ_FRAMEBUFFER,0);java.nio.ByteBuffer pixels=java.nio.ByteBuffer.allocateDirect(8*8*4);GLES20.glReadPixels(t.width/2-4,t.height/2-4,8,8,GLES20.GL_RGBA,GLES20.GL_UNSIGNED_BYTE,pixels);int sum=0;for(int i=0;i<pixels.capacity();i++)if(i%4!=3)sum+=pixels.get(i)&255;PaletteDiagnostics.event("COVER filter="+t.id+" size="+t.width+"x"+t.height+" mean="+(sum/192.0)+" gl="+GLES20.glGetError());}
    if(!EGL14.eglSwapBuffers(display,t.surface)){PaletteDiagnostics.event("COVER_SURFACE_RETRY filter="+t.id+" egl="+EGL14.eglGetError());EGL14.eglMakeCurrent(display,oldDraw,oldRead,ctx);EGL14.eglDestroySurface(display,t.surface);t.surface=null;t.bound=null;}
   }}
  }catch(Exception|LinkageError e){failed=true;PaletteDiagnostics.event("COVER_ERROR "+android.util.Log.getStackTraceString(e));}
  finally{EGL14.eglMakeCurrent(display,oldDraw,oldRead,ctx);if(guard!=0)nativeRestoreGl(guard);}
 }
 void close(){closed=true;visible=new Target[0];}
 static void release(){NativeFilterCovers c=current;if(c!=null)c.close();draw(0,1,1);}
 private static native long nativeSaveGl();private static native void nativeRestoreGl(long state);
}
