.class public final synthetic Lorg/haotian/leicaport/HaotianPort$7;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/HaotianPort;"
    method = "lambda$rebind$1"
    proto = "(Ljava/lang/reflect/Method;Landroid/hardware/camera2/CameraDevice;Landroid/hardware/camera2/params/SessionConfiguration;Ljava/lang/String;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Ljava/lang/reflect/Method;

.field public final synthetic f$1:Landroid/hardware/camera2/CameraDevice;

.field public final synthetic f$2:Landroid/hardware/camera2/params/SessionConfiguration;

.field public final synthetic f$3:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/reflect/Method;Landroid/hardware/camera2/CameraDevice;Landroid/hardware/camera2/params/SessionConfiguration;Ljava/lang/String;)V
    .registers 5

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$0:Ljava/lang/reflect/Method;

    iput-object p2, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$1:Landroid/hardware/camera2/CameraDevice;

    iput-object p3, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$2:Landroid/hardware/camera2/params/SessionConfiguration;

    iput-object p4, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$3:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 5

    .line 0
    iget-object v0, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$0:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$1:Landroid/hardware/camera2/CameraDevice;

    iget-object v2, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$2:Landroid/hardware/camera2/params/SessionConfiguration;

    iget-object v3, p0, Lorg/haotian/leicaport/HaotianPort$7;->f$3:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3}, Lorg/haotian/leicaport/HaotianPort;->lambda$rebind$1(Ljava/lang/reflect/Method;Landroid/hardware/camera2/CameraDevice;Landroid/hardware/camera2/params/SessionConfiguration;Ljava/lang/String;)V

    return-void
.end method
