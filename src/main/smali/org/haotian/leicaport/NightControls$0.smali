.class public final synthetic Lorg/haotian/leicaport/NightControls$0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/view/View;

.field public final synthetic f$1:Landroid/app/Activity;


# direct methods
.method public synthetic constructor <init>(Landroid/view/View;Landroid/app/Activity;)V
    .registers 3

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$0;->f$0:Landroid/view/View;

    iput-object p2, p0, Lorg/haotian/leicaport/NightControls$0;->f$1:Landroid/app/Activity;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 2

    .line 0
    iget-object v0, p0, Lorg/haotian/leicaport/NightControls$0;->f$0:Landroid/view/View;

    iget-object p0, p0, Lorg/haotian/leicaport/NightControls$0;->f$1:Landroid/app/Activity;

    invoke-static {v0, p0}, Lorg/haotian/leicaport/NightControls;->lambda$refresh$0(Landroid/view/View;Landroid/app/Activity;)V

    return-void
.end method
