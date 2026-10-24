package org.haotian.palette;
import android.content.Context;
import android.graphics.Bitmap;
import java.io.*;
public final class PaletteDiagnostics {
 private static volatile Context context;
 public static void init(Context c){context=c.getApplicationContext();}
 public static boolean enabled(){Context c=context;return c!=null&&new File(c.getFilesDir(),"palette-diagnostics.flag").exists();}
 public static synchronized void event(String s){if(!enabled())return;try(FileOutputStream out=new FileOutputStream(new File(context.getFilesDir(),"palette-diagnostics.txt"),true)){out.write((System.currentTimeMillis()+" "+s+"\n").getBytes("UTF-8"));}catch(IOException ignored){}}
 public static int[] sample(Bitmap b){if(!enabled())return null;int[] p=new int[256];for(int y=0;y<16;y++)for(int x=0;x<16;x++)p[y*16+x]=b.getPixel((x+1)*b.getWidth()/17,(y+1)*b.getHeight()/17);return p;}
 public static void photo(Bitmap b,int[] before,String pipeline){if(before==null)return;int[] after=sample(b);if(after==null)return;long delta=0;int changed=0;for(int i=0;i<before.length;i++){if(before[i]!=after[i])changed++;for(int k=0;k<3;k++)delta+=Math.abs(((before[i]>>(8*k))&255)-((after[i]>>(8*k))&255));}event("PHOTO size="+b.getWidth()+"x"+b.getHeight()+" color="+b.getColorSpace()+" changed="+changed+"/256 meanAbs="+(delta/768.0)+" pipeline="+pipeline);}
}
