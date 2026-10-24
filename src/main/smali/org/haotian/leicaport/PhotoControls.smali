.class public final Lorg/haotian/leicaport/PhotoControls;
.super Ljava/lang/Object;
.source "PhotoControls.java"


# static fields
.field private static final BASE:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/hardware/camera2/CaptureRequest$Builder;",
            "[",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private static final KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "[",
            "Landroid/hardware/camera2/CaptureRequest$Key<",
            "*>;"
        }
    .end annotation
.end field

.field private static volatile personNativeFailed:Z


# direct methods
.method static constructor <clinit>()V
    .registers 3

    .line 9
    const/4 v0, 0x3

    new-array v0, v0, [Landroid/hardware/camera2/CaptureRequest$Key;

    const/4 v1, 0x0

    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->NOISE_REDUCTION_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    aput-object v2, v0, v1

    const/4 v1, 0x1

    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->EDGE_MODE:Landroid/hardware/camera2/CaptureRequest$Key;

    aput-object v2, v0, v1

    const/4 v1, 0x2

    sget-object v2, Landroid/hardware/camera2/CaptureRequest;->CONTROL_AE_TARGET_FPS_RANGE:Landroid/hardware/camera2/CaptureRequest$Key;

    aput-object v2, v0, v1

    sput-object v0, Lorg/haotian/leicaport/PhotoControls;->KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;

    .line 10
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lorg/haotian/leicaport/PhotoControls;->BASE:Ljava/util/WeakHashMap;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static declared-synchronized night(Landroid/hardware/camera2/CaptureRequest$Builder;Z)V
    .registers 6

    const-class v0, Lorg/haotian/leicaport/PhotoControls;

    monitor-enter v0

    .line 12
    const/4 v1, 0x0

    if-eqz p1, :cond_1

    :try_start_0
    sget-object p1, Lorg/haotian/leicaport/PhotoControls;->BASE:Ljava/util/WeakHashMap;

    invoke-virtual {p1, p0}, Ljava/util/WeakHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_2

    sget-object p1, Lorg/haotian/leicaport/PhotoControls;->KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;

    array-length p1, p1

    new-array p1, p1, [Ljava/lang/Object;

    :goto_0
    sget-object v2, Lorg/haotian/leicaport/PhotoControls;->KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;

    array-length v2, v2

    if-ge v1, v2, :cond_0

    sget-object v2, Lorg/haotian/leicaport/PhotoControls;->KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;

    aget-object v2, v2, v1

    invoke-virtual {p0, v2}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object v2

    aput-object v2, p1, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    sget-object v1, Lorg/haotian/leicaport/PhotoControls;->BASE:Ljava/util/WeakHashMap;

    invoke-virtual {v1, p0, p1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_2

    .line 13
    :cond_1
    sget-object p1, Lorg/haotian/leicaport/PhotoControls;->BASE:Ljava/util/WeakHashMap;

    invoke-virtual {p1, p0}, Ljava/util/WeakHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/Object;

    if-eqz p1, :cond_2

    :goto_1
    sget-object v2, Lorg/haotian/leicaport/PhotoControls;->KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;

    array-length v2, v2

    if-ge v1, v2, :cond_2

    sget-object v2, Lorg/haotian/leicaport/PhotoControls;->KEYS:[Landroid/hardware/camera2/CaptureRequest$Key;

    aget-object v2, v2, v1

    aget-object v3, p1, v1

    invoke-virtual {p0, v2, v3}, Landroid/hardware/camera2/CaptureRequest$Builder;->set(Landroid/hardware/camera2/CaptureRequest$Key;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 14
    :cond_2
    :goto_2
    monitor-exit v0

    return-void

    .line 11
    :catchall_0
    move-exception p0

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw p0
.end method

.method public static personPreferred(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;ILjava/lang/String;Ljava/io/File;Ljava/io/File;)Z
    .registers 14

    .line 18
    sget-boolean v0, Lorg/haotian/leicaport/PhotoControls;->personNativeFailed:Z

    if-nez v0, :cond_1

    .line 19
    const/4 v1, 0x1

    :try_start_0
    const-string v0, "com.codex.leicaapp.LeicaQuality"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    const-string v2, "applyPersonNative"

    const/4 v3, 0x6

    new-array v3, v3, [Ljava/lang/Class;

    const-class v4, Landroid/graphics/Bitmap;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const-class v4, Landroid/graphics/Bitmap;

    aput-object v4, v3, v1

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v5, 0x2

    aput-object v4, v3, v5

    const-class v4, Ljava/lang/String;

    const/4 v5, 0x3

    aput-object v4, v3, v5

    const-class v4, Ljava/io/File;

    const/4 v5, 0x4

    aput-object v4, v3, v5

    const-class v4, Ljava/io/File;

    const/4 v5, 0x5

    aput-object v4, v3, v5

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 20
    invoke-virtual {v0, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_1

    move-object v2, p0

    move-object v3, p1

    move-object v5, p3

    move-object v6, p4

    move-object v7, p5

    :try_start_1
    filled-new-array/range {v2 .. v7}, [Ljava/lang/Object;

    move-result-object p0

    const/4 p1, 0x0

    invoke-virtual {v0, p1, p0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    .line 21
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "PERSON_NATIVE_RESULT="

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    if-eqz p0, :cond_0

    return v1

    .line 22
    :cond_0
    sput-boolean v1, Lorg/haotian/leicaport/PhotoControls;->personNativeFailed:Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_1 .. :try_end_1} :catch_0

    .line 23
    goto :goto_1

    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    move-object v2, p0

    move-object v3, p1

    :goto_0
    move-object p0, v0

    sput-boolean v1, Lorg/haotian/leicaport/PhotoControls;->personNativeFailed:Z

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "PERSON_NATIVE_FALLBACK="

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    goto :goto_1

    .line 18
    :cond_1
    move-object v2, p0

    move-object v3, p1

    .line 24
    :goto_1
    invoke-static {v2, v3, p2}, Lorg/haotian/leicaport/HaotianPort;->person(Landroid/graphics/Bitmap;Landroid/graphics/Bitmap;I)Z

    move-result p0

    return p0
.end method

.method public static videoMode()Ljava/lang/Boolean;
    .registers 3

    .line 6
    const/4 v0, 0x0

    :try_start_0
    const-string v1, "com.codex.leicaapp.NightBadge"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "current"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    invoke-virtual {v1, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Activity;

    invoke-static {v1}, Lorg/haotian/leicaport/PhotoControls;->videoMode(Landroid/app/Activity;)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v1

    return-object v0
.end method

.method public static videoMode(Landroid/app/Activity;)Ljava/lang/Boolean;
    .registers 6

    .line 7
    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "Lq"

    const/4 v3, 0x0

    new-array v4, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    new-array v2, v3, [Ljava/lang/Object;

    invoke-virtual {v1, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-nez p0, :cond_1

    return-object v0

    :cond_1
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "o"

    invoke-virtual {v1, v2}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    if-nez p0, :cond_2

    return-object v0

    :cond_2
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p0

    const-string v1, "Video"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_3

    sget-object v0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    goto :goto_0

    :cond_3
    const-string v1, "Legendary"

    invoke-virtual {p0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_4

    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    :goto_0
    return-object v0

    :catch_0
    move-exception p0

    return-object v0
.end method
