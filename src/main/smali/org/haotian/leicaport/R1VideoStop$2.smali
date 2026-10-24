.class public final synthetic Lorg/haotian/leicaport/R1VideoStop$2;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/R1VideoStop;"
    method = "lambda$recover$1"
    proto = "(ZLorg/haotian/leicaport/R1VideoStop$Transaction;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Z

.field public final synthetic f$1:Lorg/haotian/leicaport/R1VideoStop$Transaction;


# direct methods
.method public synthetic constructor <init>(ZLorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 3

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Lorg/haotian/leicaport/R1VideoStop$2;->f$0:Z

    iput-object p2, p0, Lorg/haotian/leicaport/R1VideoStop$2;->f$1:Lorg/haotian/leicaport/R1VideoStop$Transaction;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 3

    .line 0
    iget-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$2;->f$0:Z

    iget-object v1, p0, Lorg/haotian/leicaport/R1VideoStop$2;->f$1:Lorg/haotian/leicaport/R1VideoStop$Transaction;

    invoke-static {v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->lambda$recover$1(ZLorg/haotian/leicaport/R1VideoStop$Transaction;)V

    return-void
.end method
