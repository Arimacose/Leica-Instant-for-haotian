import java.nio.file.*;
import java.util.*;
import com.android.tools.smali.dexlib2.Opcodes;
import com.android.tools.smali.dexlib2.writer.builder.DexBuilder;
import com.android.tools.smali.dexlib2.writer.io.FileDataStore;
import brut.androlib.smali.SmaliBuilder;

/** Assembles only the project's device-routing and recording-lifecycle helpers. */
public final class BuildRouting {
 public static void main(String[] args)throws Exception {
  DexBuilder builder=new DexBuilder(new Opcodes(29));
  SmaliBuilder assembler=new SmaliBuilder(29);
  List<Path> sources;
  try(var paths=Files.walk(Path.of(args[0]))){sources=paths.filter(p->p.toString().endsWith(".smali")).sorted().toList();}
  if(sources.isEmpty())throw new AssertionError("No routing sources found");
  for(Path source:sources){
   String declaration=Files.readString(source).lines().filter(s->s.startsWith(".class ")).findFirst().orElseThrow();
   if(!declaration.contains(" Lorg/haotian/leicaport/"))throw new AssertionError("Unexpected namespace: "+source.getFileName());
   if(!assembler.buildFile(source.toFile(),builder))throw new AssertionError(source.getFileName());
  }
  builder.writeTo(new FileDataStore(new java.io.File(args[1])));
  var rebuilt=DexTools.read(Path.of(args[1]));
  System.out.println("Assembled routing classes: "+rebuilt.size());
  if(args.length>2){
   Map<String,com.android.tools.smali.dexlib2.iface.ClassDef> released=new TreeMap<>();
   for(int i=2;i<args.length;i++)for(var entry:DexTools.read(Path.of(args[i])).entrySet()){
    if(entry.getKey().startsWith("Lorg/haotian/leicaport/") && released.put(entry.getKey(),entry.getValue())!=null)throw new AssertionError("Duplicate released class");
   }
   if(!rebuilt.keySet().equals(released.keySet()))throw new AssertionError("Routing class inventory differs from reference APK");
   for(String name:rebuilt.keySet())if(!DexTools.normalized(rebuilt.get(name)).equals(DexTools.normalized(released.get(name))))throw new AssertionError("Routing mismatch: "+name);
   System.out.println("PASS: all routing classes match R1-d, ignoring debug information and const-string/jumbo encoding");
  }
 }
}
