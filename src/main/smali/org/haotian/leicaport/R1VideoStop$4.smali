.class public final synthetic Lorg/haotian/leicaport/R1VideoStop$4;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/concurrent/ThreadFactory;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/R1VideoStop;"
    method = "lambda$static$0"
    proto = "(Ljava/lang/Runnable;)Ljava/lang/Thread;"
.end annotation


# direct methods
.method public synthetic constructor <init>()V
    .registers 1

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final newThread(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .registers 2

    .line 0
    invoke-static {p1}, Lorg/haotian/leicaport/R1VideoStop;->lambda$static$0(Ljava/lang/Runnable;)Ljava/lang/Thread;

    move-result-object p1

    return-object p1
.end method
