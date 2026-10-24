import java.io.*;
import java.nio.file.*;
import java.util.*;
import com.android.tools.smali.dexlib2.dexbacked.DexBackedDexFile;
import com.android.tools.smali.dexlib2.iface.ClassDef;
import com.android.tools.smali.baksmali.BaksmaliOptions;
import com.android.tools.smali.baksmali.Adaptors.ClassDefinition;
import com.android.tools.smali.baksmali.formatter.BaksmaliWriter;

/** Dump the unmodified DEX with debug data, or compare compiled class semantics. */
public final class DexTools {
 public static String render(ClassDef definition,boolean debug)throws Exception{
  BaksmaliOptions options=new BaksmaliOptions();options.debugInfo=debug;options.sequentialLabels=true;
  StringWriter text=new StringWriter();
  try(BaksmaliWriter writer=new BaksmaliWriter(text)){new ClassDefinition(options,definition).writeTo(writer);}
  return text.toString();
 }
 static Map<String,ClassDef> read(Path path)throws Exception{
  DexBackedDexFile dex=new DexBackedDexFile(Files.readAllBytes(path),0);Map<String,ClassDef> result=new TreeMap<>();
  for(int i=0;i<dex.classCount;i++){ClassDef c=(ClassDef)dex.classSection.get(i);result.put(c.getType(),c);}return result;
 }
 static String normalized(ClassDef c)throws Exception{return render(c,false).replace("const-string/jumbo","const-string");}
 public static void main(String[] args)throws Exception{
  Map<String,ClassDef> before=read(Path.of(args[1]));Path out=Path.of(args[2]);Files.createDirectories(out);
  if(args[0].equals("dump")){
   for(ClassDef c:before.values()){
    // Windows is case insensitive; encoded flat filenames preserve distinct DEX names.
    String filename=HexFormat.of().formatHex(c.getType().getBytes(java.nio.charset.StandardCharsets.UTF_8))+".smali";
    Path path=out.resolve(filename);
    String body=c.getType().equals("LDp/a;")?Files.readString(Path.of(args[3])):render(c,true);
    Files.writeString(path,body);
   }
   System.out.println("dumped="+before.size());return;
  }
  Map<String,ClassDef> after=read(Path.of(args[3]));if(!before.keySet().equals(after.keySet())){Set<String> missing=new TreeSet<>(before.keySet());missing.removeAll(after.keySet());Set<String> added=new TreeSet<>(after.keySet());added.removeAll(before.keySet());throw new AssertionError("Class inventory changed missing="+missing+" added="+added);}
  List<String> changes=new ArrayList<>();
  for(String name:before.keySet())if(!normalized(before.get(name)).equals(normalized(after.get(name)))){
   changes.add(name);String rel=name.substring(1,name.length()-1)+".smali";
   for(String side:List.of("before","after")){Path path=out.resolve(side).resolve(rel);Files.createDirectories(path.getParent());Files.writeString(path,render((side.equals("before")?before:after).get(name),false));}
  }
  Files.write(out.resolve("changed-classes.txt"),changes);System.out.println("changedClasses="+changes);
 }
}
