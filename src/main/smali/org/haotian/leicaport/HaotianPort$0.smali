.class public final synthetic Lorg/haotian/leicaport/HaotianPort$0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"


# direct methods
.method public static synthetic m(Ljava/lang/Object;)V
    .registers 2

    .line 0
    instance-of v0, p0, Ljava/lang/AutoCloseable;

    if-eqz v0, :cond_0

    check-cast p0, Ljava/lang/AutoCloseable;

    invoke-interface {p0}, Ljava/lang/AutoCloseable;->close()V

    return-void

    :cond_0
    instance-of v0, p0, Ljava/util/concurrent/ExecutorService;

    if-eqz v0, :cond_1

    check-cast p0, Ljava/util/concurrent/ExecutorService;

    invoke-static {p0}, Lorg/haotian/leicaport/HaotianPort$1;->m(Ljava/util/concurrent/ExecutorService;)V

    return-void

    :cond_1
    instance-of v0, p0, Landroid/content/res/TypedArray;

    if-eqz v0, :cond_2

    check-cast p0, Landroid/content/res/TypedArray;

    invoke-virtual {p0}, Landroid/content/res/TypedArray;->recycle()V

    return-void

    :cond_2
    invoke-static {p0}, Lorg/haotian/leicaport/HaotianPort$2;->m(Ljava/lang/Object;)V

    return-void
.end method
