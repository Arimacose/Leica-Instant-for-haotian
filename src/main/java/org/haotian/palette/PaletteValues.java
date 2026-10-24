package org.haotian.palette;

/** Parameter mapping transcribed from donor EffectController and Tu/r$a. */
public final class PaletteValues {
 public final int tone,saturation,temperature,tint,texture,grain,vignette,mist;
 public final boolean enabled;
 public final int filterId,filterDegree;
 public PaletteValues(boolean enabled,int[] a){this(enabled,a,NativeFilters.NONE,100);}
 public PaletteValues(boolean enabled,int[] a,int filterId,int degree){
  this.filterId=filterId;this.filterDegree=clamp(degree,0,100);
  if(a==null || a.length!=8)throw new IllegalArgumentException("Eight palette parameters required");
  this.enabled=enabled;tone=clamp(a[0],-50,50);saturation=clamp(a[1],-50,50);
  temperature=clamp(a[2],-50,50);tint=clamp(a[3],-50,50);texture=clamp(a[4],-50,50);
  grain=clamp(a[5],0,100);vignette=clamp(a[6],-50,50);mist=clamp(a[7],0,5);
 }
 public int[] array(){return new int[]{tone,saturation,temperature,tint,texture,grain,vignette,mist};}
 public static int clamp(int v,int lo,int hi){return Math.max(lo,Math.min(hi,v));}
 public boolean active(){return enabled && (!NativeFilters.isNone(filterId) || tone!=0 || saturation!=0 || temperature!=0 || tint!=0 || texture!=0 || grain!=0 || vignette!=0 || mist!=0);}
 public String pipeline(){
  String basic="";if(enabled&&!NativeFilters.isNone(filterId))try{basic=PaletteEngine.filter(this).pipeline(filterDegree);}catch(Exception e){throw new IllegalStateException("原生基础滤镜未就绪",e);}
  return basic+stylePipeline();
 }
 public String photoPipeline()throws Exception{return (enabled&&!NativeFilters.isNone(filterId)?PaletteEngine.filter(this).photoPipeline(filterDegree):"")+stylePipeline();}
 public String stylePipeline(){
  if(!active())return "";
  float t=tone/100f,s=saturation/100f*(saturation<0?2f:1.4f),temp=temperature*2f/100f,hue=tint*2f/100f;
  float sharp=texture/100f,g=grain/100f,v=vignette/100f;
  int flags=(texture!=0?64:0)|(tone!=0?8:0)|(saturation!=0?4:0)|(temperature!=0?1:0)|(tint!=0?2:0)|(grain!=0?16:0)|(vignette!=0?32:0);
  String result=flags==0?"":"@StyleAdjustEffect;Algos="+flags+";SharpenIntensity="+sharp+";ContrastIntensity="+t+";SaturationIntensity="+s+";Temperature="+temp+";Tint="+hue+";Grain="+g+";VignetteIntensity="+v;
  if(mist!=0){float[] strength={0,.3f,.5f,.8f,.6f,.8f};result+=(mist>3?"@WhiteMistEffect;LumThresh=0.1":"@BlackMistEffect;LumThresh=0.5")+";Raduis=4.0;MixRatio="+strength[mist];}
  return result;
 }
}
