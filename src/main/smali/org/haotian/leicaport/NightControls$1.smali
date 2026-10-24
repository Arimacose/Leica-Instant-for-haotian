.class public final synthetic Lorg/haotian/leicaport/NightControls$1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public final synthetic f$0:Landroid/app/Activity;


# direct methods
.method public synthetic constructor <init>(Landroid/app/Activity;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$1;->f$0:Landroid/app/Activity;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .registers 2

    .line 0
    iget-object p0, p0, Lorg/haotian/leicaport/NightControls$1;->f$0:Landroid/app/Activity;

    invoke-static {p0, p1}, Lorg/haotian/leicaport/NightControls;->lambda$refresh$1(Landroid/app/Activity;Landroid/view/View;)V

    return-void
.end method
