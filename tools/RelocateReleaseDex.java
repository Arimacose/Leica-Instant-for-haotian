import java.nio.file.*;import java.util.*;
import com.android.tools.smali.dexlib2.Opcodes;
import com.android.tools.smali.dexlib2.writer.builder.DexBuilder;
import com.android.tools.smali.dexlib2.writer.io.FileDataStore;
import brut.androlib.smali.SmaliBuilder;
/** Package-identity substitution only; verify every class body after assembly. */
public class RelocateReleaseDex {
 static String escaped(String value){StringBuilder b=new StringBuilder();for(char c:value.toCharArray())b.append(c>127?String.format("\\u%04x",(int)c):String.valueOf(c));return b.toString();}
 static String rename(String value){for(String[] pair:new String[][]{{"com.Lieca.test","com.starry.leica"},{"徕卡一瞬Test","Leica一瞬"},{"Pro-T1.17-native","R1-d"}})value=value.replace(pair[0],pair[1]).replace(escaped(pair[0]),escaped(pair[1]));return value;}
 public static void main(String[] a)throws Exception{
  var before=DexTools.read(Path.of(a[0]));DexBuilder out=new DexBuilder(new Opcodes(29));SmaliBuilder assembler=new SmaliBuilder(29);Path temp=Path.of(a[1]+".smali");List<String> changed=new ArrayList<>();
  for(var c:before.values()){String source=DexTools.render(c,true),result=rename(source);if(!source.equals(result))changed.add(c.getType());Files.writeString(temp,result);if(!assembler.buildFile(temp.toFile(),out))throw new AssertionError(c.getType());}
  out.writeTo(new FileDataStore(new java.io.File(a[1])));Files.delete(temp);var after=DexTools.read(Path.of(a[1]));if(!before.keySet().equals(after.keySet()))throw new AssertionError("Class inventory changed");
  for(var name:before.keySet())if(!rename(DexTools.normalized(before.get(name))).equals(DexTools.normalized(after.get(name))))throw new AssertionError("Non-identity change: "+name);
  System.out.println("PASS identity-only relocation and semantic equivalence: "+changed);
 }
}
