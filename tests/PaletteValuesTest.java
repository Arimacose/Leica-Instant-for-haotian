import org.haotian.palette.PaletteValues;
public class PaletteValuesTest {
 private static void check(boolean b,String s){if(!b)throw new AssertionError(s);}
 public static void main(String[] args){
  check(new PaletteValues(true,new int[8]).pipeline().isEmpty(),"Neutral must bypass native engine");
  check(new PaletteValues(false,new int[]{50,50,50,50,50,50,50,5}).pipeline().isEmpty(),"Disabled must bypass");
  PaletteValues low=new PaletteValues(true,new int[]{-50,-50,-50,-50,-50,50,-50,1});
  check(low.pipeline().equals("@StyleAdjustEffect;Algos=127;SharpenIntensity=-0.5;ContrastIntensity=-0.5;SaturationIntensity=-1.0;Temperature=-1.0;Tint=-1.0;Grain=0.5;VignetteIntensity=-0.5@BlackMistEffect;LumThresh=0.5;Raduis=4.0;MixRatio=0.3"),"Donor negative endpoint and effect ordering");
  check(new PaletteValues(true,new int[]{0,50,0,0,0,0,0,0}).pipeline().contains("Algos=4;"),"Saturation algorithm bit");
  check(new PaletteValues(true,new int[]{0,50,0,0,0,0,0,0}).pipeline().contains("SaturationIntensity=0.7;"),"Donor asymmetric saturation");
  String[] mist={"","@BlackMistEffect;LumThresh=0.5;Raduis=4.0;MixRatio=0.3","@BlackMistEffect;LumThresh=0.5;Raduis=4.0;MixRatio=0.5","@BlackMistEffect;LumThresh=0.5;Raduis=4.0;MixRatio=0.8","@WhiteMistEffect;LumThresh=0.1;Raduis=4.0;MixRatio=0.6","@WhiteMistEffect;LumThresh=0.1;Raduis=4.0;MixRatio=0.8"};
  for(int i=0;i<6;i++)check(new PaletteValues(true,new int[]{0,0,0,0,0,0,0,i}).pipeline().equals(mist[i]),"Mist selection "+i);
  PaletteValues clamped=new PaletteValues(true,new int[]{Integer.MIN_VALUE,Integer.MAX_VALUE,-1000,1000,-500,-3,400,99});
  check(java.util.Arrays.equals(clamped.array(),new int[]{-50,50,-50,50,-50,0,50,5}),"Persisted corrupt/out-of-range input clamp");
  for(int x=-50;x<=50;x++)for(int y=-50;y<=50;y++){
   PaletteValues p=new PaletteValues(true,new int[]{y,x,0,0,0,0,0,0});
   check(p.active()==(x!=0||y!=0),"Axis zero identity");
   String s=p.pipeline();check(!s.contains("NaN")&&!s.contains("Infinity"),"Finite pipeline");
   if(x!=0||y!=0)check(s.contains("Algos="+((x!=0?4:0)|(y!=0?8:0))+";"),"Independent axis flags");
  }
  System.out.println("PASS: 10,201 two-axis combinations; zero/disabled identity; parameter clamps; donor asymmetry and all five mist presets");
 }
}
