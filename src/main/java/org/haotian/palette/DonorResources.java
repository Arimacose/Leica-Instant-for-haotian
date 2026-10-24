package org.haotian.palette;
import android.content.*;
import android.content.pm.ApplicationInfo;
import android.content.res.*;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.util.Xml;
import android.view.*;
import java.io.*;
import java.lang.reflect.*;
import org.xmlpull.v1.XmlPullParser;

/** Resource-only donor package: never uses the installed official camera's Resources. */
public final class DonorResources extends ContextWrapper {
 public static final int[] CARD_ATTRS={0x7f040169,0x7f040246,0x7f04078e};
 private final Resources resources; private final Resources.Theme theme;
 public DonorResources(Context app)throws Exception{
  super(app);File file=new File(app.getFilesDir(),"palette-donor-ui-t2.apk");
  if(!file.exists()){File temp=new File(app.getFilesDir(),"palette-donor-ui-t2.tmp");try(InputStream in=app.getAssets().open("haotian/donor-ui-res.apk");OutputStream out=new FileOutputStream(temp)){byte[] b=new byte[65536];int n;while((n=in.read(b))!=-1)out.write(b,0,n);}if(!temp.renameTo(file))throw new IOException("Cannot install donor resources");file.setReadOnly();}
  ApplicationInfo info=new ApplicationInfo();info.packageName="com.Lieca.test.palette.resources";info.sourceDir=file.getAbsolutePath();info.publicSourceDir=info.sourceDir;info.uid=app.getApplicationInfo().uid;
  resources=app.getPackageManager().getResourcesForApplication(info);theme=resources.newTheme();theme.applyStyle(android.R.style.Theme_DeviceDefault,true);
 }
 public Resources getResources(){return resources;}public AssetManager getAssets(){return resources.getAssets();}public Resources.Theme getTheme(){return theme;}
 public Object getSystemService(String name){if(LAYOUT_INFLATER_SERVICE.equals(name))return LayoutInflater.from(getBaseContext()).cloneInContext(this);return super.getSystemService(name);}
 public int id(String type,String name){int id=resources.getIdentifier(name,type,"com.android.camera");if(id==0)throw new Resources.NotFoundException(type+"/"+name);return id;}
 public int dim(String name){return resources.getDimensionPixelSize(id("dimen",name));}
 public Drawable image(String name){return resources.getDrawable(id("drawable",name),theme);}
 public String text(String name){return resources.getString(id("string",name));}
 public View control(String layout,String tag,String actualClass)throws Exception{
  try(XmlResourceParser xml=resources.getLayout(id("layout",layout))){int event;while((event=xml.next())!=XmlPullParser.END_DOCUMENT){if(event==XmlPullParser.START_TAG && tag.equals(xml.getName()))return (View)Class.forName(actualClass).getConstructor(Context.class,AttributeSet.class).newInstance(this,Xml.asAttributeSet(xml));}}
  throw new IllegalStateException("Missing donor control "+tag);
 }
 public static float lerp(float a,float b,float t,float offset){return (a-b)*t+offset;}
 public static float reverse(float a,float b,float t,float offset){return offset-(a-b)*t;}
 public static int grid(float a,float b,float spacing){return Math.round((a-b)/spacing);}
 public static int color(Context c,int id){return c.getColor(id);}
 public static Drawable drawable(Resources r,int id,Resources.Theme t){return r.getDrawable(id,t);}
 public static int scale(int a,float b,int c){return (Float.hashCode(b)+a)*c;}
 public static int blend(int a,int b,int c){return (Integer.hashCode(a)+b)*c;}
}
