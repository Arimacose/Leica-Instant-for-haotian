package org.haotian.palette;
import android.content.ContentResolver;import android.graphics.*;import android.net.Uri;import java.io.*;import java.util.concurrent.*;import java.util.concurrent.atomic.*;
/** Original bitmap QR recognition pipeline, not a replacement scanner. */
final class OriginalQr {
 static String parse(OriginalUiRuntime d,String value)throws Exception {
  String code=(String)d.type("org.haotian.palette.isolated.OriginalQrParser").getMethod("parse",String.class).invoke(null,value);
  if(code==null||code.isEmpty())throw new IOException("二维码中没有有效的小米摄影风格口令");
  return code;
 }
 static String decode(OriginalUiRuntime d,ContentResolver resolver,Uri uri)throws Exception {
  Bitmap image;try(InputStream stream=resolver.openInputStream(uri)){image=BitmapFactory.decodeStream(stream);}if(image==null)throw new IOException("图片无法读取");
  CountDownLatch done=new CountDownLatch(1);AtomicReference<String> result=new AtomicReference<>();AtomicReference<Throwable> error=new AtomicReference<>();
  Object success=d.listener("io.reactivex.functions.d",(p,m,args)->{result.set(String.valueOf(args[0]));done.countDown();return null;});
  Object failed=d.listener("io.reactivex.functions.d",(p,m,args)->{error.set((Throwable)args[0]);done.countDown();return null;});
  Object complete=d.listener("io.reactivex.functions.a",(p,m,args)->{done.countDown();return null;});Object disposable=null;
  try{Object source=d.make("E1.s2",image,9);Object maybe=d.make("io.reactivex.internal.operators.maybe.c",source);disposable=OriginalUiRuntime.invoke(maybe,"subscribe",success,failed,complete);if(!done.await(20,TimeUnit.SECONDS))throw new IOException("二维码识别超时");if(error.get()!=null)throw new IOException("二维码识别失败",error.get());String value=result.get();if(value==null||value.isEmpty())throw new IOException("未识别到有效二维码");return value;}finally{if(disposable!=null)OriginalUiRuntime.invoke(disposable,"c");if(done.getCount()==0)image.recycle();}
 }
}
