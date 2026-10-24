package org.haotian.palette;

import android.content.Context;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.zip.*;

/** The donor workspace format. Unknown entries survive import, rename and export. */
final class RecipeStore {
 static final String[] KEYS={"pref_qc_camera_style_tone_key","pref_qc_camera_style_vibrance_key","pref_qc_camera_style_color_temp_key","pref_qc_camera_style_color_tone_key","pref_qc_camera_style_texture_key","pref_qc_camera_style_noise_key","pref_qc_camera_style_vignette_key","pref_qc_camera_style_soft_light_key"};
 final File root;
 RecipeStore(Context c)throws IOException{root=new File(c.getFilesDir(),"native-filter-workspace");if(!root.isDirectory()&&!root.mkdirs())throw new IOException("Workspace unavailable");}
 static final class Item {
  final File directory;final String name;final LinkedHashMap<String,String> parameters=new LinkedHashMap<>();int order;
  Item(File f)throws IOException {
   directory=f;String[] p=f.getName().split("_",4);if(p.length!=4||!p[0].startsWith("MiCam"))throw new IOException("Invalid native recipe directory");name=p[3];
   File[] files=f.listFiles();if(files==null)throw new IOException("Unreadable recipe");Arrays.sort(files,Comparator.comparing(File::getName));
   for(String prefix:new String[]{"p_","po_"})for(File e:files){String n=e.getName();if(n.startsWith(prefix)){int split=n.lastIndexOf('_');if(split>prefix.length())parameters.put(n.substring(prefix.length(),split),n.substring(split+1));}}
   for(File e:files)if(e.getName().startsWith("o_"))try{order=Integer.parseInt(e.getName().substring(2));}catch(NumberFormatException ignored){}
  }
  int[] values(){int[] a=new int[8];for(int i=0;i<a.length;i++)try{a[i]=Integer.parseInt(parameters.getOrDefault(KEYS[i],"0"));}catch(NumberFormatException ignored){}return a;}
 }
 ArrayList<Item> list()throws IOException{ArrayList<Item>a=new ArrayList<>();File[]fs=root.listFiles();if(fs!=null)for(File f:fs)if(f.isDirectory()&&f.getName().startsWith("MiCam"))a.add(new Item(f));a.sort(Comparator.comparingInt((Item i)->i.order).thenComparing(i->i.directory.getName()));return a;}
 static void validName(String name)throws IOException{if(name.trim().isEmpty()||name.length()>28||name.matches(".*[\\\\/:*?\"<>|\\p{Cntrl}].*"))throw new IOException("名称为空、过长或含有不支持的字符");}
 Item save(String name,int[]values)throws IOException{return save(name,values,NativeFilters.NONE,100);}
 Item save(String name,int[]values,int filterId,int degree)throws IOException {
  validName(name);ArrayList<Item>items=list();if(items.size()>=15)throw new IOException("滤镜配方数量已达上限15个");for(Item i:items)if(i.name.equals(name))throw new IOException("该名称已存在");
  File stage=new File(root,".save-"+UUID.randomUUID());if(!stage.mkdir())throw new IOException("Cannot create recipe");
  try{for(int k=0;k<8;k++)touch(new File(stage,"p_"+KEYS[k]+"_"+values[k]));touch(new File(stage,"p_pref_camera_shader_coloreffect_key_"+filterId));touch(new File(stage,"p_pref_camera_shader_coloreffect_degree_key_"+degree));touch(new File(stage,"v_4"));touch(new File(stage,"o_"+items.size()));File target=new File(root,"MiCamStyleRear_haotian_"+System.currentTimeMillis()+"_"+name);Files.move(stage.toPath(),target.toPath());return new Item(target);}finally{removeTree(stage,root);}
 }
 Item rename(Item item,String name)throws IOException{validName(name);for(Item i:list())if(i.name.equals(name)&&!i.directory.equals(item.directory))throw new IOException("该名称已存在");String[]p=item.directory.getName().split("_",4);File dst=new File(root,p[0]+"_"+p[1]+"_"+p[2]+"_"+name);if(!dst.equals(item.directory))Files.move(item.directory.toPath(),dst.toPath());return new Item(dst);}
 void delete(Item item)throws IOException{removeTree(item.directory,root);}
 void order(List<Item>items)throws IOException{for(int n=0;n<items.size();n++){Item i=items.get(n);File[] fs=i.directory.listFiles();if(fs!=null)for(File f:fs)if(f.getName().startsWith("o_"))Files.delete(f.toPath());touch(new File(i.directory,"o_"+n));i.order=n;}}
 Item parseZip(InputStream input,File stage)throws IOException{return parseZip(input,stage,null);}
 Item parseZip(InputStream input,File stage,String archiveName)throws IOException{
  if(!stage.mkdir())throw new IOException("Cannot prepare import");long total=0;int entries=0;String base=stage.getCanonicalPath()+File.separator;
  try(ZipInputStream zip=new ZipInputStream(input)){ZipEntry entry;byte[]buf=new byte[32768];while((entry=zip.getNextEntry())!=null){if(++entries>2048)throw new IOException("Too many recipe entries");File out=new File(stage,entry.getName());if(!out.getCanonicalPath().startsWith(base))throw new IOException("Unsafe ZIP path");if(entry.isDirectory()){out.mkdirs();continue;}out.getParentFile().mkdirs();try(OutputStream stream=new FileOutputStream(out)){int n;while((n=zip.read(buf))!=-1){total+=n;if(total>64L*1024*1024)throw new IOException("Recipe exceeds 64 MiB");stream.write(buf,0,n);}}}}
  File[]dirs=stage.listFiles(File::isDirectory);if(dirs!=null&&dirs.length==1&&dirs[0].getName().startsWith("MiCam"))return new Item(dirs[0]);
  // Donor exports also exist as flat ZIPs whose filename holds the native
  // workspace identity. Retain every entry while restoring that directory.
  if(archiveName!=null&&archiveName.endsWith(".zip")){
   String stem=archiveName.substring(0,archiveName.length()-4);String[]parts=stem.split("_",4);
   if(parts.length==4&&parts[0].startsWith("MiCam")&&stem.indexOf('/')<0&&stem.indexOf('\\')<0){validName(parts[3]);File[]entriesOnDisk=stage.listFiles();File folder=new File(stage,stem);if(!folder.mkdir())throw new IOException("Cannot restore recipe directory");if(entriesOnDisk!=null)for(File f:entriesOnDisk)Files.move(f.toPath(),new File(folder,f.getName()).toPath());return new Item(folder);}
  }
  throw new IOException("ZIP中没有可识别的原生配方目录");
 }
 Item commit(Item imported)throws IOException{
  ArrayList<Item>items=list();if(items.size()>=15)throw new IOException("滤镜配方数量已达上限15个");for(Item i:items)if(i.name.equals(imported.name))throw new IOException("该名称已存在");File target=new File(root,imported.directory.getName());Files.move(imported.directory.toPath(),target.toPath());return new Item(target);
 }
 File export(Item item,File cache)throws IOException{File out=new File(cache,item.directory.getName()+".zip");try(ZipOutputStream zip=new ZipOutputStream(new FileOutputStream(out))){zip(zip,item.directory,item.directory.getName()+"/");}return out;}
 static void zip(ZipOutputStream zip,File f,String name)throws IOException{if(f.isDirectory()){zip.putNextEntry(new ZipEntry(name));zip.closeEntry();File[]fs=f.listFiles();if(fs!=null)for(File x:fs)zip(zip,x,name+x.getName()+(x.isDirectory()?"/":""));}else{zip.putNextEntry(new ZipEntry(name));Files.copy(f.toPath(),zip);zip.closeEntry();}}
 static void touch(File f)throws IOException{if(!f.createNewFile()&&!f.exists())throw new IOException("Cannot write "+f.getName());}
 static void removeTree(File f,File boundary)throws IOException{String b=boundary.getCanonicalPath()+File.separator;if(!f.getCanonicalPath().startsWith(b))throw new IOException("Deletion outside workspace");if(!f.exists())return;if(f.isDirectory()){File[]fs=f.listFiles();if(fs!=null)for(File c:fs)removeTree(c,boundary);}Files.delete(f.toPath());}
}

