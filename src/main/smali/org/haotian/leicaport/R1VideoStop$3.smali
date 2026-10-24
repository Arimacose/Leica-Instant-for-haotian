.class public final synthetic Lorg/haotian/leicaport/R1VideoStop$3;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/R1VideoStop;"
    method = "lambda$recover$0"
    proto = "(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V"
.end annotation


# instance fields
.field public final synthetic f$0:Lorg/haotian/leicaport/R1VideoStop$Transaction;


# direct methods
.method public synthetic constructor <init>(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 2

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lorg/haotian/leicaport/R1VideoStop$3;->f$0:Lorg/haotian/leicaport/R1VideoStop$Transaction;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 2

    .line 0
    iget-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$3;->f$0:Lorg/haotian/leicaport/R1VideoStop$Transaction;

    invoke-static {v0}, Lorg/haotian/leicaport/R1VideoStop;->lambda$recover$0(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    return-void
.end method
