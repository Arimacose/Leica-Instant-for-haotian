.class public final Lorg/haotian/leicaport/R1VideoStop;
.super Ljava/lang/Object;
.source "R1VideoStop.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/haotian/leicaport/R1VideoStop$Transaction;
    }
.end annotation


# static fields
.field private static final CONTROLLERS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Lorg/haotian/leicaport/R1VideoStop$Transaction;",
            ">;"
        }
    .end annotation
.end field

.field private static final IDS:Ljava/util/concurrent/atomic/AtomicLong;

.field private static final MAIN:Landroid/os/Handler;

.field private static final MODULES:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Object;",
            "Lorg/haotian/leicaport/R1VideoStop$Transaction;",
            ">;"
        }
    .end annotation
.end field

.field private static final NONE:[Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field

.field private static final TAG:Ljava/lang/String; = "LeicaR1Stop"

.field private static final TIMER:Ljava/util/concurrent/ScheduledExecutorService;


# direct methods
.method static bridge synthetic -$$Nest$sfgetIDS()Ljava/util/concurrent/atomic/AtomicLong;
    .registers 1

    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->IDS:Ljava/util/concurrent/atomic/AtomicLong;

    return-object v0
.end method

.method static constructor <clinit>()V
    .registers 2

    .line 26
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lorg/haotian/leicaport/R1VideoStop;->MAIN:Landroid/os/Handler;

    .line 27
    new-instance v0, Lorg/haotian/leicaport/R1VideoStop$4;

    invoke-direct {v0}, Lorg/haotian/leicaport/R1VideoStop$4;-><init>()V

    invoke-static {v0}, Ljava/util/concurrent/Executors;->newSingleThreadScheduledExecutor(Ljava/util/concurrent/ThreadFactory;)Ljava/util/concurrent/ScheduledExecutorService;

    move-result-object v0

    sput-object v0, Lorg/haotian/leicaport/R1VideoStop;->TIMER:Ljava/util/concurrent/ScheduledExecutorService;

    .line 30
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicLong;-><init>()V

    sput-object v0, Lorg/haotian/leicaport/R1VideoStop;->IDS:Ljava/util/concurrent/atomic/AtomicLong;

    .line 31
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    .line 32
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lorg/haotian/leicaport/R1VideoStop;->CONTROLLERS:Ljava/util/Map;

    .line 33
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Class;

    sput-object v0, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static beginStop(Ljava/lang/Object;)Z
    .registers 8

    .line 101
    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "getModuleIndex"

    sget-object v3, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {p0, v2, v3, v5}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->intValue()I

    move-result v2

    const/16 v3, 0xa2

    if-eq v2, v3, :cond_0

    return v0

    .line 102
    :cond_0
    sget-object v2, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 103
    if-eqz v2, :cond_2

    iget-boolean v3, v2, Lorg/haotian/leicaport/R1VideoStop$Transaction;->finished:Z

    if-eqz v3, :cond_1

    iget-boolean v3, v2, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    if-nez v3, :cond_2

    .line 104
    :cond_1
    const-string p0, "DUPLICATE_STOP_IGNORED"

    invoke-static {v2, p0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    return v4

    .line 106
    :cond_2
    const-string v2, "mUserRecordSetting"

    invoke-static {p0, v2}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 107
    const-string v3, "i"

    invoke-static {v2, v3}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_3

    move-object v3, v1

    goto :goto_0

    :cond_3
    const-string v5, "e"

    sget-object v6, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v3, v5, v6, v4}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/Uri;

    .line 108
    :goto_0
    const-string v4, "mRecorderController"

    invoke-static {p0, v4}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    .line 109
    new-instance v5, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    invoke-direct {v5, p0, v2, v3}, Lorg/haotian/leicaport/R1VideoStop$Transaction;-><init>(Ljava/lang/Object;Ljava/lang/Object;Landroid/net/Uri;)V

    .line 110
    sget-object v2, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v2, p0, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    sget-object p0, Lorg/haotian/leicaport/R1VideoStop;->CONTROLLERS:Ljava/util/Map;

    invoke-interface {p0, v4, v5}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 111
    const-string p0, "STOP_REQUESTED"

    invoke-static {v5, p0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 112
    sget-object p0, Lorg/haotian/leicaport/R1VideoStop;->TIMER:Ljava/util/concurrent/ScheduledExecutorService;

    new-instance v2, Lorg/haotian/leicaport/R1VideoStop$0;

    invoke-direct {v2, v5}, Lorg/haotian/leicaport/R1VideoStop$0;-><init>(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v4, 0xc

    invoke-interface {p0, v2, v4, v5, v3}, Ljava/util/concurrent/ScheduledExecutorService;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 118
    return v0

    .line 119
    :catch_0
    move-exception p0

    const-string v2, "STOP_HOOK_UNAVAILABLE"

    invoke-static {v1, v2, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    return v0
.end method

.method private static varargs call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    .registers 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Class<",
            "*>;[",
            "Ljava/lang/Object;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 59
    nop

    .line 60
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    :goto_0
    if-eqz v0, :cond_0

    .line 61
    :try_start_0
    invoke-virtual {v0, p1, p2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 62
    :catch_0
    move-exception v1

    .line 60
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 p2, 0x0

    .line 63
    :goto_1
    if-eqz p2, :cond_3

    .line 64
    const/4 p1, 0x1

    :try_start_1
    invoke-virtual {p2, p1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    invoke-virtual {p2, p0, p3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_1 .. :try_end_1} :catch_1

    return-object p0

    .line 70
    :catch_1
    move-exception p0

    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw p1

    .line 65
    :catch_2
    move-exception p0

    .line 66
    invoke-virtual {p0}, Ljava/lang/reflect/InvocationTargetException;->getCause()Ljava/lang/Throwable;

    move-result-object p0

    .line 67
    instance-of p1, p0, Ljava/lang/Error;

    if-nez p1, :cond_2

    .line 68
    instance-of p1, p0, Ljava/lang/RuntimeException;

    if-eqz p1, :cond_1

    check-cast p0, Ljava/lang/RuntimeException;

    throw p0

    .line 69
    :cond_1
    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw p1

    .line 67
    :cond_2
    check-cast p0, Ljava/lang/Error;

    throw p0

    .line 63
    :cond_3
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "Missing method "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method public static canStart(Ljava/lang/Object;)Z
    .registers 5

    .line 122
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 123
    const/4 v1, 0x1

    if-nez v0, :cond_0

    return v1

    .line 124
    :cond_0
    iget-boolean v2, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->finished:Z

    if-eqz v2, :cond_1

    iget-boolean v2, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    if-eqz v2, :cond_1

    .line 125
    sget-object v2, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v2, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 126
    :try_start_0
    sget-object v2, Lorg/haotian/leicaport/R1VideoStop;->CONTROLLERS:Ljava/util/Map;

    const-string v3, "mRecorderController"

    invoke-static {p0, v3}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    invoke-interface {v2, p0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 127
    goto :goto_0

    :catch_0
    move-exception p0

    const-string v2, "COMPLETED_TRANSACTION_CLEANUP_FAILED"

    invoke-static {v0, v2, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 128
    :goto_0
    return v1

    .line 130
    :cond_1
    iget-boolean p0, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseStarted:Z

    if-eqz p0, :cond_2

    iget-boolean p0, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    if-nez p0, :cond_2

    .line 131
    const-string p0, "\u5f55\u50cf\u8d44\u6e90\u5c1a\u672a\u5b8c\u5168\u91ca\u653e\uff0c\u8bf7\u9000\u51fa\u540e\u91cd\u65b0\u6253\u5f00\u76f8\u673a"

    goto :goto_1

    :cond_2
    const-string p0, "\u4e0a\u4e00\u6bb5\u5f55\u50cf\u4ecd\u5728\u6536\u5c3e\uff0c\u8bf7\u7a0d\u5019"

    .line 130
    :goto_1
    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V

    .line 132
    const/4 p0, 0x0

    return p0
.end method

.method private static context()Landroid/content/Context;
    .registers 5

    .line 73
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "com.xiaomi.camera.basic.Global"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getContext"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, v0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/ReflectiveOperationException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    .line 74
    :catch_0
    move-exception v1

    const-string v2, "LeicaR1Stop"

    const-string v3, "CONTEXT_UNAVAILABLE"

    invoke-static {v2, v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-object v0
.end method

.method private static current(Lorg/haotian/leicaport/R1VideoStop$Transaction;)Z
    .registers 3

    .line 95
    iget-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->module:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    .line 96
    if-eqz v0, :cond_0

    sget-object v1, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, p0, :cond_0

    const-string v1, "mUserRecordSetting"

    invoke-static {v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    iget-object p0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->settings:Ljava/lang/Object;

    if-ne v0, p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method public static deferPreview(Ljava/lang/Object;)Z
    .registers 4

    .line 144
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 145
    if-eqz p0, :cond_1

    iget-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->finished:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    if-eqz v0, :cond_0

    goto :goto_0

    .line 146
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->previewPending:Z

    const-string v1, "PREVIEW_DEFERRED"

    const/4 v2, 0x0

    invoke-static {p0, v1, v2}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    return v0

    .line 145
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return p0
.end method

.method private static field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Field;
    .registers 4

    .line 47
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    :goto_0
    if-eqz p0, :cond_0

    .line 48
    :try_start_0
    invoke-virtual {p0, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 49
    :catch_0
    move-exception v0

    .line 47
    invoke-virtual {p0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object p0

    goto :goto_0

    .line 50
    :cond_0
    new-instance p0, Ljava/lang/IllegalStateException;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Missing field "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static finish(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 5

    .line 246
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->finished:Z

    const-string v0, "STOP_FINISHED"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 247
    iget-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    if-nez v0, :cond_0

    const-string p0, "\u5f55\u50cf\u8d44\u6e90\u91ca\u653e\u5f02\u5e38\uff0c\u8bf7\u9000\u51fa\u540e\u91cd\u65b0\u6253\u5f00\u76f8\u673a"

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V

    return-void

    .line 248
    :cond_0
    iget-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->previewPending:Z

    if-eqz v0, :cond_2

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->current(Lorg/haotian/leicaport/R1VideoStop$Transaction;)Z

    move-result v0

    if-nez v0, :cond_1

    goto :goto_1

    .line 249
    :cond_1
    :try_start_0
    iget-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->module:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    const-string v1, "r1StopLegacyPreview"

    sget-object v2, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Object;

    invoke-static {v0, v1, v2, v3}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 250
    goto :goto_0

    :catch_0
    move-exception v0

    const-string v1, "PREVIEW_RESTORE_FAILED"

    invoke-static {p0, v1, v0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string p0, "\u5f55\u50cf\u5df2\u7ed3\u675f\uff0c\u4f46\u9884\u89c8\u6062\u590d\u5931\u8d25\uff0c\u8bf7\u91cd\u65b0\u6253\u5f00\u76f8\u673a"

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V

    .line 251
    :goto_0
    return-void

    .line 248
    :cond_2
    :goto_1
    return-void
.end method

.method private static get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;
    .registers 2

    .line 53
    :try_start_0
    invoke-static {p0, p1}, Lorg/haotian/leicaport/R1VideoStop;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw p1
.end method

.method static synthetic lambda$beginStop$0(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 4

    .line 113
    iget-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->finished:Z

    if-nez v0, :cond_1

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->current(Lorg/haotian/leicaport/R1VideoStop$Transaction;)Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 114
    :cond_0
    iget-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->phase:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "STOP_TIMEOUT_AT_"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 115
    const-string p0, "\u505c\u6b62\u5f55\u50cf\u8d85\u65f6\uff0c\u89c6\u9891\u5c1a\u672a\u786e\u8ba4\u4fdd\u5b58\uff1b\u8bf7\u4fdd\u7559\u73b0\u573a\u4ee5\u4fbf\u6392\u67e5"

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V

    .line 117
    return-void

    .line 113
    :cond_1
    :goto_0
    return-void
.end method

.method static synthetic lambda$notice$0(Ljava/lang/String;)V
    .registers 3

    .line 91
    invoke-static {}, Lorg/haotian/leicaport/R1VideoStop;->context()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    :try_start_0
    invoke-static {v0, p0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 92
    goto :goto_0

    :catch_0
    move-exception p0

    const-string v0, "LeicaR1Stop"

    const-string v1, "NOTICE_FAILED"

    invoke-static {v0, v1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_0
    :goto_0
    return-void
.end method

.method static synthetic lambda$recover$0(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 4

    .line 209
    nop

    .line 210
    const/4 v0, 0x0

    :try_start_0
    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->validate(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    const/4 v0, 0x1

    const-string v1, "RECOVERY_CONTAINER_CHECKED"

    const/4 v2, 0x0

    invoke-static {p0, v1, v2}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 211
    goto :goto_0

    :catch_0
    move-exception v1

    const-string v2, "RECOVERY_CONTAINER_INVALID"

    invoke-static {p0, v2, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 212
    :goto_0
    nop

    .line 213
    sget-object v1, Lorg/haotian/leicaport/R1VideoStop;->MAIN:Landroid/os/Handler;

    new-instance v2, Lorg/haotian/leicaport/R1VideoStop$2;

    invoke-direct {v2, v0, p0}, Lorg/haotian/leicaport/R1VideoStop$2;-><init>(ZLorg/haotian/leicaport/R1VideoStop$Transaction;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 221
    return-void
.end method

.method static synthetic lambda$recover$1(ZLorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 3

    .line 215
    if-eqz p0, :cond_0

    :try_start_0
    invoke-static {p1}, Lorg/haotian/leicaport/R1VideoStop;->current(Lorg/haotian/leicaport/R1VideoStop$Transaction;)Z

    move-result p0

    if-eqz p0, :cond_0

    .line 216
    iget-object p0, p1, Lorg/haotian/leicaport/R1VideoStop$Transaction;->module:Ljava/lang/ref/WeakReference;

    invoke-virtual {p0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p0

    const/4 v0, 0x1

    invoke-static {p0, v0}, Lorg/haotian/leicaport/R1VideoStop;->save(Ljava/lang/Object;Z)V

    goto :goto_0

    .line 217
    :cond_0
    const-string p0, "\u89c6\u9891\u5c1a\u672a\u5b8c\u6210\u6709\u6548\u5c01\u88c5\uff0c\u672c\u6b21\u672a\u786e\u8ba4\u4fdd\u5b58"

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :goto_0
    nop

    .line 219
    :goto_1
    invoke-static {p1}, Lorg/haotian/leicaport/R1VideoStop;->finish(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    goto :goto_2

    :catchall_0
    move-exception p0

    goto :goto_3

    .line 218
    :catch_0
    move-exception p0

    :try_start_1
    const-string v0, "RECOVERY_SAVE_FAILED"

    invoke-static {p1, v0, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    const-string p0, "\u89c6\u9891\u4fdd\u5b58\u56de\u8c03\u5931\u8d25\uff0c\u8bf7\u4fdd\u7559\u8bb0\u5f55\u4ee5\u4fbf\u6392\u67e5"

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    .line 220
    :goto_2
    return-void

    .line 219
    :goto_3
    invoke-static {p1}, Lorg/haotian/leicaport/R1VideoStop;->finish(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    throw p0
.end method

.method static synthetic lambda$static$0(Ljava/lang/Runnable;)Ljava/lang/Thread;
    .registers 3

    .line 28
    new-instance v0, Ljava/lang/Thread;

    const-string v1, "LeicaR1StopWatch"

    invoke-direct {v0, p0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    const/4 p0, 0x1

    invoke-virtual {v0, p0}, Ljava/lang/Thread;->setDaemon(Z)V

    return-object v0
.end method

.method private static notice(Ljava/lang/String;)V
    .registers 3

    .line 91
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MAIN:Landroid/os/Handler;

    new-instance v1, Lorg/haotian/leicaport/R1VideoStop$1;

    invoke-direct {v1, p0}, Lorg/haotian/leicaport/R1VideoStop$1;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 93
    return-void
.end method

.method public static notifyStop(Ljava/lang/Object;Ljava/lang/Object;)V
    .registers 5

    .line 139
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    const/4 v1, 0x0

    const-string v2, "p1"

    if-nez v0, :cond_0

    sget-object p0, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v0, v1, [Ljava/lang/Object;

    invoke-static {p1, v2, p0, v0}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    .line 140
    :cond_0
    :try_start_0
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p1, v2, v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 141
    goto :goto_0

    :catch_0
    move-exception p1

    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    const-string v0, "VENDOR_STOP_NOTICE_FAILED"

    invoke-static {p0, v0, p1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 142
    :goto_0
    return-void
.end method

.method public static onReleased(Ljava/lang/Object;Z)V
    .registers 8

    .line 189
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 190
    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_0

    const-string v0, "r1StopLegacyReleased"

    new-array v2, v2, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {p0, v0, v2, p1}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    .line 191
    :cond_0
    monitor-enter v0

    :try_start_0
    iget-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseCallback:Z

    if-eqz v3, :cond_1

    monitor-exit v0

    return-void

    :cond_1
    iput-boolean v2, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseCallback:Z

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 192
    iget-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    if-nez v3, :cond_2

    .line 193
    const-string p0, "RELEASE_UNCONFIRMED"

    const/4 v1, 0x0

    invoke-static {v0, p0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-static {v0, p1}, Lorg/haotian/leicaport/R1VideoStop;->recover(Lorg/haotian/leicaport/R1VideoStop$Transaction;Z)V

    return-void

    .line 195
    :cond_2
    :try_start_1
    const-string v3, "r1StopLegacyReleased"

    new-array v4, v2, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v5, v4, v1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {p0, v3, v4, v1}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_1 .. :try_end_1} :catch_0

    .line 200
    goto :goto_0

    .line 196
    :catch_0
    move-exception p0

    .line 197
    const-string v1, "RELEASE_CALLBACK_FAILED"

    invoke-static {v0, v1, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 198
    if-eqz p1, :cond_3

    iget-boolean p0, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->saveAttempted:Z

    if-nez p0, :cond_3

    invoke-static {v0, v2}, Lorg/haotian/leicaport/R1VideoStop;->recover(Lorg/haotian/leicaport/R1VideoStop$Transaction;Z)V

    return-void

    .line 199
    :cond_3
    const-string p0, "\u5f55\u50cf\u6536\u5c3e\u53d1\u751f\u5f02\u5e38\uff0c\u4fdd\u5b58\u7ed3\u679c\u5c1a\u672a\u786e\u8ba4"

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V

    .line 201
    :goto_0
    invoke-static {v0}, Lorg/haotian/leicaport/R1VideoStop;->finish(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    .line 202
    return-void

    .line 191
    :catchall_0
    move-exception p0

    :try_start_2
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw p0
.end method

.method private static recover(Lorg/haotian/leicaport/R1VideoStop$Transaction;Z)V
    .registers 3

    .line 205
    if-eqz p1, :cond_1

    iget-boolean p1, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->stopReturned:Z

    if-eqz p1, :cond_1

    iget-boolean p1, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->saveAttempted:Z

    if-nez p1, :cond_1

    iget-object p1, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->uri:Landroid/net/Uri;

    if-nez p1, :cond_0

    goto :goto_0

    .line 208
    :cond_0
    new-instance p1, Ljava/lang/Thread;

    new-instance v0, Lorg/haotian/leicaport/R1VideoStop$3;

    invoke-direct {v0, p0}, Lorg/haotian/leicaport/R1VideoStop$3;-><init>(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    const-string p0, "LeicaR1StopRecovery"

    invoke-direct {p1, v0, p0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V

    .line 221
    const/4 p0, 0x1

    invoke-virtual {p1, p0}, Ljava/lang/Thread;->setDaemon(Z)V

    invoke-virtual {p1}, Ljava/lang/Thread;->start()V

    .line 222
    return-void

    .line 206
    :cond_1
    :goto_0
    const-string p1, "\u672c\u6b21\u5f55\u50cf\u672a\u786e\u8ba4\u4fdd\u5b58\uff0c\u8bf7\u4fdd\u7559\u8bb0\u5f55\u4ee5\u4fbf\u6392\u67e5"

    invoke-static {p1}, Lorg/haotian/leicaport/R1VideoStop;->notice(Ljava/lang/String;)V

    invoke-static {p0}, Lorg/haotian/leicaport/R1VideoStop;->finish(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V

    return-void
.end method

.method public static releaseAiAudio(Ljava/lang/Object;)V
    .registers 4

    .line 177
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    const/4 v1, 0x0

    const-string v2, "releaseAiAudio"

    if-nez v0, :cond_0

    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v2, v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    return-void

    .line 178
    :cond_0
    :try_start_0
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v2, v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 179
    goto :goto_0

    :catch_0
    move-exception v0

    sget-object v1, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    const-string v1, "AUDIO_CLEANUP_FAILED"

    invoke-static {p0, v1, v0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 180
    :goto_0
    return-void
.end method

.method public static releaseRecorder(Ljava/lang/Object;Ljava/lang/Object;)Z
    .registers 11

    .line 150
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->CONTROLLERS:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 153
    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 154
    :cond_0
    monitor-enter v0

    :try_start_0
    iget-boolean v2, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseStarted:Z

    const/4 v3, 0x1

    if-eqz v2, :cond_1

    monitor-exit v0

    return v3

    :cond_1
    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseStarted:Z

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 155
    nop

    .line 157
    :try_start_1
    const-string v2, "d"

    invoke-static {p0, v2}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    monitor-enter v2
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_1 .. :try_end_1} :catch_4

    :try_start_2
    const-string v4, "a"

    invoke-static {p0, v4}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    const-string v5, "a"

    const/4 v6, 0x0

    invoke-static {p0, v5, v6}, Lorg/haotian/leicaport/R1VideoStop;->set(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 158
    :try_start_3
    const-string v2, "RESET_ENTER"

    invoke-static {v0, v2, v6}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_3 .. :try_end_3} :catch_4

    .line 159
    :try_start_4
    const-string v2, "e"

    invoke-static {p0, v2}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    const-string v5, "a"

    sget-object v7, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v8, v1, [Ljava/lang/Object;

    invoke-static {v2, v5, v7, v8}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_4
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    .line 160
    :catch_0
    move-exception v2

    :try_start_5
    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->cleanupError:Z

    const-string v5, "FILE_CLEANUP_FAILED"

    invoke-static {v0, v5, v2}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_5 .. :try_end_5} :catch_4

    :goto_0
    nop

    .line 161
    if-eqz v4, :cond_2

    .line 162
    :try_start_6
    const-string v2, "reset"

    sget-object v5, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v7, v1, [Ljava/lang/Object;

    invoke-static {v4, v2, v5, v7}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    const-string v2, "RESET_RETURNED"

    invoke-static {v0, v2, v6}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_1
    .catch Ljava/lang/LinkageError; {:try_start_6 .. :try_end_6} :catch_1

    goto :goto_1

    .line 163
    :catch_1
    move-exception v2

    :try_start_7
    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->cleanupError:Z

    const-string v5, "RESET_FAILED"

    invoke-static {v0, v5, v2}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_1
    nop

    .line 165
    const-string v2, "RELEASE_ENTER"

    invoke-static {v0, v2, v6}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_7
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_7 .. :try_end_7} :catch_4

    .line 166
    :try_start_8
    const-string v2, "release"

    sget-object v5, Lorg/haotian/leicaport/R1VideoStop;->NONE:[Ljava/lang/Class;

    new-array v7, v1, [Ljava/lang/Object;

    invoke-static {v4, v2, v5, v7}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    const-string v2, "RELEASE_RETURNED"

    invoke-static {v0, v2, v6}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_8
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_2
    .catch Ljava/lang/LinkageError; {:try_start_8 .. :try_end_8} :catch_2

    goto :goto_2

    .line 167
    :catch_2
    move-exception v2

    :try_start_9
    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->cleanupError:Z

    const-string v4, "RELEASE_FAILED"

    invoke-static {v0, v4, v2}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    :goto_2
    goto :goto_3

    .line 168
    :cond_2
    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->releaseReturned:Z

    const-string v2, "NO_RECORDER_TO_RELEASE"

    invoke-static {v0, v2, v6}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_9
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_9 .. :try_end_9} :catch_4

    .line 169
    :goto_3
    :try_start_a
    const-string v2, "p"

    invoke-static {p0, v2}, Lorg/haotian/leicaport/R1VideoStop;->get(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_3

    const-string v2, "d"

    new-array v4, v3, [Ljava/lang/Class;

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v5, v4, v1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {p0, v2, v4, v5}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_a
    .catch Ljava/lang/RuntimeException; {:try_start_a .. :try_end_a} :catch_3
    .catch Ljava/lang/LinkageError; {:try_start_a .. :try_end_a} :catch_3

    .line 170
    :cond_3
    :goto_4
    goto :goto_5

    :catch_3
    move-exception p0

    :try_start_b
    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->cleanupError:Z

    const-string v2, "CONTINUATION_CLEANUP_FAILED"

    invoke-static {v0, v2, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_b
    .catch Ljava/lang/RuntimeException; {:try_start_b .. :try_end_b} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_b .. :try_end_b} :catch_4

    goto :goto_4

    .line 171
    :goto_5
    goto :goto_6

    .line 157
    :catchall_0
    move-exception p0

    :try_start_c
    monitor-exit v2
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    :try_start_d
    throw p0
    :try_end_d
    .catch Ljava/lang/RuntimeException; {:try_start_d .. :try_end_d} :catch_4
    .catch Ljava/lang/LinkageError; {:try_start_d .. :try_end_d} :catch_4

    .line 171
    :catch_4
    move-exception p0

    iput-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->cleanupError:Z

    const-string v2, "RELEASE_DISPATCH_FAILED"

    invoke-static {v0, v2, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 172
    :goto_6
    if-eqz p1, :cond_4

    :try_start_e
    check-cast p1, Ljava/lang/Runnable;

    invoke-interface {p1}, Ljava/lang/Runnable;->run()V
    :try_end_e
    .catch Ljava/lang/RuntimeException; {:try_start_e .. :try_end_e} :catch_5
    .catch Ljava/lang/LinkageError; {:try_start_e .. :try_end_e} :catch_5

    .line 173
    goto :goto_7

    :catch_5
    move-exception p0

    const-string p1, "RELEASE_COMPLETION_FAILED"

    invoke-static {v0, p1, p0}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-static {v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->recover(Lorg/haotian/leicaport/R1VideoStop$Transaction;Z)V

    .line 174
    :cond_4
    :goto_7
    return v3

    .line 154
    :catchall_1
    move-exception p0

    :try_start_f
    monitor-exit v0
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_1

    throw p0
.end method

.method public static save(Ljava/lang/Object;Z)V
    .registers 8

    .line 182
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->MODULES:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 183
    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    monitor-enter v0

    :try_start_0
    iget-boolean v3, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->saveAttempted:Z

    if-eqz v3, :cond_0

    monitor-exit v0

    return-void

    :cond_0
    iput-boolean v2, v0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->saveAttempted:Z

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 184
    if-eqz p1, :cond_1

    const-string v3, "SAVE_ATTEMPT"

    goto :goto_0

    :cond_1
    const-string v3, "SAVE_FAILURE_PATH"

    :goto_0
    invoke-static {v0, v3, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    goto :goto_1

    .line 183
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0

    .line 185
    :cond_2
    :goto_1
    const-string v3, "r1StopLegacyTrySave"

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v4, 0x0

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v5, v2, v4

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    filled-new-array {p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {p0, v3, v2, p1}, Lorg/haotian/leicaport/R1VideoStop;->call(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 186
    if-eqz v0, :cond_3

    const-string p0, "ORIGINAL_SAVE_PATH_RETURNED_NOT_FILE_PROOF"

    invoke-static {v0, p0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 187
    :cond_3
    return-void
.end method

.method private static set(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    .registers 3

    .line 56
    :try_start_0
    invoke-static {p0, p1}, Lorg/haotian/leicaport/R1VideoStop;->field(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p1

    invoke-virtual {p1, p0, p2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    .line 57
    return-void

    .line 56
    :catch_0
    move-exception p0

    new-instance p1, Ljava/lang/IllegalStateException;

    invoke-direct {p1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/Throwable;)V

    throw p1
.end method

.method private static stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V
    .registers 9

    .line 77
    const-string v0, ""

    if-eqz p0, :cond_0

    iput-object p1, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->phase:Ljava/lang/String;

    .line 78
    :cond_0
    if-nez p0, :cond_1

    const-wide/16 v1, 0x0

    goto :goto_0

    :cond_1
    iget-wide v1, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->id:J

    :goto_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "id="

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " phase="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 79
    const-string v2, "LeicaR1Stop"

    if-nez p2, :cond_2

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    :cond_2
    invoke-static {v2, v1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 80
    :goto_1
    invoke-static {}, Lorg/haotian/leicaport/R1VideoStop;->context()Landroid/content/Context;

    move-result-object v3

    if-eqz v3, :cond_6

    if-nez p0, :cond_3

    goto :goto_4

    .line 82
    :cond_3
    :try_start_0
    const-string v4, "leica_r1_stop_diagnostics"

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v3

    invoke-interface {v3}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "last_stage"

    .line 83
    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    const-string v4, "last_output"

    iget-object p0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->uri:Landroid/net/Uri;

    invoke-static {p0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    invoke-interface {v3, v4, p0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    .line 84
    const-string v3, "last_error"

    const-string v4, "last_failure_stage"

    if-eqz p2, :cond_4

    :try_start_1
    invoke-interface {p0, v4, v1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-static {p2}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, v3, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    goto :goto_2

    .line 85
    :cond_4
    const-string p2, "STOP_REQUESTED"

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_5

    invoke-interface {p0, v4, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1, v3, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 86
    :cond_5
    :goto_2
    invoke-interface {p0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_1 .. :try_end_1} :catch_0

    .line 88
    goto :goto_3

    :catch_0
    move-exception p0

    const-string p1, "DIAGNOSTIC_WRITE_FAILED"

    invoke-static {v2, p1, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 89
    :goto_3
    return-void

    .line 80
    :cond_6
    :goto_4
    return-void
.end method

.method public static stopped(Ljava/lang/Object;)V
    .registers 3

    .line 135
    sget-object v0, Lorg/haotian/leicaport/R1VideoStop;->CONTROLLERS:Ljava/util/Map;

    invoke-interface {v0, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;

    .line 136
    if-eqz p0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->stopReturned:Z

    const-string v0, "STOP_RETURNED"

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lorg/haotian/leicaport/R1VideoStop;->stage(Lorg/haotian/leicaport/R1VideoStop$Transaction;Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 137
    :cond_0
    return-void
.end method

.method private static validate(Lorg/haotian/leicaport/R1VideoStop$Transaction;)V
    .registers 13
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 224
    const-string v0, "video/"

    const-string v1, "durationUs"

    invoke-static {}, Lorg/haotian/leicaport/R1VideoStop;->context()Landroid/content/Context;

    move-result-object v2

    if-eqz v2, :cond_8

    .line 225
    new-instance v3, Landroid/media/MediaExtractor;

    invoke-direct {v3}, Landroid/media/MediaExtractor;-><init>()V

    .line 227
    :try_start_0
    iget-object p0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->uri:Landroid/net/Uri;

    const/4 v4, 0x0

    invoke-virtual {v3, v2, p0, v4}, Landroid/media/MediaExtractor;->setDataSource(Landroid/content/Context;Landroid/net/Uri;Ljava/util/Map;)V

    .line 228
    const/4 p0, 0x0

    move v2, p0

    move v4, v2

    move v5, v4

    :goto_0
    invoke-virtual {v3}, Landroid/media/MediaExtractor;->getTrackCount()I

    move-result v6

    if-ge v2, v6, :cond_6

    .line 229
    invoke-virtual {v3, v2}, Landroid/media/MediaExtractor;->getTrackFormat(I)Landroid/media/MediaFormat;

    move-result-object v6

    const-string v7, "mime"

    invoke-virtual {v6, v7}, Landroid/media/MediaFormat;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 230
    if-eqz v7, :cond_5

    invoke-virtual {v7, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_0

    const-string v8, "audio/"

    invoke-virtual {v7, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_0

    goto :goto_2

    .line 231
    :cond_0
    invoke-virtual {v6, v1}, Landroid/media/MediaFormat;->containsKey(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-virtual {v6, v1}, Landroid/media/MediaFormat;->getLong(Ljava/lang/String;)J

    move-result-wide v8

    const-wide/16 v10, 0x0

    cmp-long v8, v8, v10

    if-lez v8, :cond_4

    .line 233
    invoke-virtual {v3, v2}, Landroid/media/MediaExtractor;->selectTrack(I)V

    .line 234
    invoke-virtual {v3}, Landroid/media/MediaExtractor;->getSampleTime()J

    move-result-wide v8

    cmp-long v8, v8, v10

    if-ltz v8, :cond_3

    invoke-virtual {v3}, Landroid/media/MediaExtractor;->getSampleSize()J

    move-result-wide v8

    cmp-long v8, v8, v10

    if-lez v8, :cond_3

    .line 235
    invoke-virtual {v7, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v7

    const/4 v8, 0x1

    if-eqz v7, :cond_2

    .line 236
    invoke-virtual {v6, v1}, Landroid/media/MediaFormat;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    invoke-virtual {v3, v6, v7, p0}, Landroid/media/MediaExtractor;->seekTo(JI)V

    .line 237
    invoke-virtual {v3}, Landroid/media/MediaExtractor;->getSampleTime()J

    move-result-wide v6

    cmp-long v4, v6, v10

    if-ltz v4, :cond_1

    move v4, v8

    goto :goto_1

    :cond_1
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "Final video seek failed"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 238
    :cond_2
    move v5, v8

    .line 239
    :goto_1
    invoke-virtual {v3, v2}, Landroid/media/MediaExtractor;->unselectTrack(I)V

    goto :goto_2

    .line 234
    :cond_3
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "No encoded track sample"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 232
    :cond_4
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "Missing or zero track duration"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 228
    :cond_5
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 242
    :cond_6
    if-eqz v4, :cond_7

    if-eqz v5, :cond_7

    .line 243
    invoke-virtual {v3}, Landroid/media/MediaExtractor;->release()V

    .line 244
    return-void

    .line 242
    :cond_7
    :try_start_1
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "No complete video/audio tracks"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 243
    :catchall_0
    move-exception p0

    invoke-virtual {v3}, Landroid/media/MediaExtractor;->release()V

    throw p0

    .line 224
    :cond_8
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string v0, "No application context"

    invoke-direct {p0, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
