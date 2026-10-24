package org.haotian.palette;
import android.accounts.*;
import android.app.*;
import android.content.*;
import android.os.*;
import java.io.IOException;
import java.util.function.Consumer;

/** User-visible platform account consent; never reads other applications' storage. */
public final class RecipeAccountAuth extends Fragment {
 private Runnable ready;private Consumer<Throwable> failed;private boolean launched,finished;private Account selected;private int providerPages;
 public static void start(Activity activity,Runnable ready,Consumer<Throwable> failed){
  RecipeAccountAuth flow=new RecipeAccountAuth();flow.ready=ready;flow.failed=failed;
  activity.getFragmentManager().beginTransaction().add(flow,"recipe-account-consent").commit();
 }
 @Override public void onResume(){super.onResume();if(launched)return;launched=true;
  try{startActivityForResult(AccountManager.newChooseAccountIntent(null,null,new String[]{"com.xiaomi"},"为徕卡一瞬Test授权小米配方云服务",null,null,null),73);}
  catch(Exception e){finish(e);}
 }
 @Override public void onActivityResult(int request,int result,Intent data){
  if(request==74){
   RecipeStatus.write(getActivity(),"account-provider-page-result","result="+result);
   // HyperOS can return RESULT_CANCELED after persisting the credential grant.
   // Recheck through the same public API once; a new consent Intent is rejected.
   requestToken();return;
  }
  if(request!=73)return;
  if(result!=Activity.RESULT_OK||data==null){finish(new android.accounts.OperationCanceledException("账号授权已取消"));return;}
  String name=data.getStringExtra(AccountManager.KEY_ACCOUNT_NAME),type=data.getStringExtra(AccountManager.KEY_ACCOUNT_TYPE);
  if(name==null||!"com.xiaomi".equals(type)){finish(new IOException("未选择可用的小米账号"));return;}
  selected=new Account(name,type);requestToken();
 }
 private void requestToken(){
  Activity activity=getActivity();if(activity==null){finish(new IOException("相机页面已经关闭"));return;}
  RecipeStatus.write(activity,"account-chosen","requesting provider consent");
  try{AccountManager.get(activity).getAuthToken(selected,"hyperos_sec_common",null,false,future->{
   try{Bundle resultBundle=future.getResult();String token=resultBundle.getString(AccountManager.KEY_AUTHTOKEN);
    Intent consent=resultBundle.getParcelable(AccountManager.KEY_INTENT);
    if(consent!=null){
     if(providerPages++>=1)throw new IOException("账号服务重复要求授权，未取得配方服务凭据");
     RecipeStatus.write(activity,"account-provider-page","component="+(consent.getComponent()==null?"implicit":consent.getComponent().flattenToShortString()));
     startActivityForResult(consent,74);return;
    }
    // The provider retains its own token. Do not persist, print or export it.
    if(token==null||token.isEmpty())throw new IOException("小米账号服务没有向此测试包提供配方服务授权");
    RecipeStatus.write(activity,"account-consent","provider returned authorization");finish(null);
   }catch(android.accounts.OperationCanceledException e){
    RecipeStatus.write(activity,"account-provider-cancel","credential request ended before token; providerPages="+providerPages);
    finish(new IOException("小米账号已可见，但账号服务终止了配方凭据申请，尚未向 Test 提供授权。口令／二维码云端导入未完成；ZIP 可本地导入。"));
   }catch(Exception e){finish(e);}
  },new Handler(Looper.getMainLooper()));}catch(Exception e){finish(e);}
 }
 private void finish(Throwable problem){
  if(finished)return;finished=true;Activity activity=getActivity();
  if(activity!=null&&!activity.isDestroyed())activity.getFragmentManager().beginTransaction().remove(this).commitAllowingStateLoss();
  if(problem==null){if(ready!=null)ready.run();}else if(failed!=null)failed.accept(problem);
 }
}
