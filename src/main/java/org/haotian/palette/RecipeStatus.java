package org.haotian.palette;
import android.content.Context;
import java.io.*;
import java.nio.charset.StandardCharsets;
/** Small private workflow log. No account identifiers, tokens, recipe codes or download URLs. */
public final class RecipeStatus {
 public static synchronized void write(Context context,String stage,String detail){
  if(context==null)return;
  String text=String.valueOf(detail).replaceAll("https?://[^\\s\"]+","[url]")
   .replaceAll("(?i)(serviceToken|authToken|cookie|password)\\s*[=:]\\s*[^\\s,;]+","$1=[redacted]");
  text=text.replaceAll("MiCamStyle-[A-Za-z0-9]+","[recipe-code]");
  if(text.length()>6000)text=text.substring(0,6000);
  File target=new File(context.getFilesDir(),"recipe-status.txt");
  try(FileOutputStream out=new FileOutputStream(target,target.length()<32768)){
   out.write((System.currentTimeMillis()+" "+stage+" "+text+"\n").getBytes(StandardCharsets.UTF_8));
  }catch(IOException ignored){}
 }
}
