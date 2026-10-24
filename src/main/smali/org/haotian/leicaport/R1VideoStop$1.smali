.class public final synthetic Lorg/haotian/leicaport/R1VideoStop$1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/R1VideoStop;"
    method = "lambda$notice$0"
    proto = "(Ljava/lang/String;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/String;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/haotian/leicaport/R1VideoStop$1;->f$0:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 2

    .line 0
    iget-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$1;->f$0:Ljava/lang/String;

    invoke-static {v0}, Lorg/haotian/leicaport/R1VideoStop;->lambda$notice$0(Ljava/lang/String;)V

    return-void
.end method
