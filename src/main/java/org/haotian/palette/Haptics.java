package org.haotian.palette;
import android.view.*;
import android.provider.Settings;
public final class Haptics {
 private static long last;
 public static void click(View view){
  if(view==null || !view.isHapticFeedbackEnabled() || Settings.System.getInt(view.getContext().getContentResolver(),Settings.System.HAPTIC_FEEDBACK_ENABLED,1)==0)return;
  long now=android.os.SystemClock.uptimeMillis();if(now-last<60)return;last=now;
  try{Class<?> compat=Class.forName("miuix.view.HapticCompat");int effect=Class.forName("miuix.view.j").getField("k").getInt(null);if(Boolean.TRUE.equals(compat.getMethod("performHapticFeedback",View.class,int.class).invoke(null,view,effect)))return;}catch(ReflectiveOperationException|LinkageError e){android.util.Log.d("HaotianPalette","Platform haptic fallback",e);}
  view.performHapticFeedback(HapticFeedbackConstants.CLOCK_TICK);
 }
}
