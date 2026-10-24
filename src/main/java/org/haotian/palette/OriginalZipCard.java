package org.haotian.palette;
import android.graphics.*;import android.graphics.drawable.*;import android.text.*;
/** U9/M's ZIP share card drawing, using its exact dimensions, typography and drawable. */
final class OriginalZipCard {
 static Bitmap create(OriginalUiRuntime d,String name){
  int w=d.dim("brz"),h=d.dim("bs0"),iw=d.dim("bs4"),ih=d.dim("bs2"),gap=d.dim("bs3"),th=d.dim("bs1");Bitmap b=Bitmap.createBitmap(w,h,Bitmap.Config.ARGB_8888);Canvas c=new Canvas(b);GradientDrawable bg=new GradientDrawable();bg.setColor(Color.BLACK);bg.setCornerRadius(d.dim("br8"));bg.setBounds(0,0,w,h);bg.draw(c);int y=(h-ih-gap-th)/2;
  Drawable icon=d.getDrawable(d.id("drawable","zip_vector"));icon.setBounds((w-iw)/2,y,(w+iw)/2,y+ih);icon.draw(c);Paint paint=new Paint(1);paint.setColor(Color.WHITE);paint.setTextSize(d.dim("bs6"));paint.setTextAlign(Paint.Align.CENTER);float pad=d.dim("brl"),available=w-pad*2;
  if(paint.measureText(name)>available)paint.setTextSize(d.dim("brj"));if(paint.measureText(name)<=available)c.drawText(name,w/2f,Math.abs(paint.ascent())+y+ih+gap,paint);else{TextPaint tp=new TextPaint(paint);tp.setTextAlign(Paint.Align.LEFT);StaticLayout layout=StaticLayout.Builder.obtain(name,0,name.length(),tp,(int)available).setAlignment(Layout.Alignment.ALIGN_CENTER).setMaxLines(2).setEllipsize(TextUtils.TruncateAt.END).build();c.save();c.translate(pad,y+ih+gap);layout.draw(c);c.restore();}return b;
 }
}
