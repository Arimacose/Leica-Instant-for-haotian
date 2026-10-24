.class public final Lorg/haotian/leicaport/NightControls;
.super Ljava/lang/Object;
.source "NightControls.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/haotian/leicaport/NightControls$Sync;
    }
.end annotation


# static fields
.field private static final MAIN:Landroid/os/Handler;

.field private static final REFRESH:Ljava/lang/Runnable;

.field private static final TAG:Ljava/lang/String; = "haotian_independent_night_control"

.field private static current:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field

.field private static final lastLayout:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/view/View;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final observers:Ljava/util/WeakHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/WeakHashMap<",
            "Landroid/view/View;",
            "Lorg/haotian/leicaport/NightControls$Sync;",
            ">;"
        }
    .end annotation
.end field

.field private static previousState:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    .line 24
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lorg/haotian/leicaport/NightControls;->MAIN:Landroid/os/Handler;

    .line 25
    new-instance v0, Ljava/lang/ref/WeakReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lorg/haotian/leicaport/NightControls;->current:Ljava/lang/ref/WeakReference;

    .line 26
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lorg/haotian/leicaport/NightControls;->lastLayout:Ljava/util/WeakHashMap;

    .line 27
    new-instance v0, Lorg/haotian/leicaport/NightControls$2;

    invoke-direct {v0}, Lorg/haotian/leicaport/NightControls$2;-><init>()V

    sput-object v0, Lorg/haotian/leicaport/NightControls;->REFRESH:Ljava/lang/Runnable;

    .line 88
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    sput-object v0, Lorg/haotian/leicaport/NightControls;->observers:Ljava/util/WeakHashMap;

    .line 118
    const-string v0, ""

    sput-object v0, Lorg/haotian/leicaport/NightControls;->previousState:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;
    .registers 2

    .line 22
    invoke-static {p0, p1}, Lorg/haotian/leicaport/NightControls;->named(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method public static containsTouch(Landroid/app/Activity;Landroid/view/MotionEvent;)Z
    .registers 5

    .line 192
    const-string v0, "top_menu_content"

    invoke-static {p0, v0}, Lorg/haotian/leicaport/NightControls;->named(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;

    move-result-object p0

    instance-of v0, p0, Landroid/view/ViewGroup;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 193
    :cond_0
    check-cast p0, Landroid/view/ViewGroup;

    const-string v0, "haotian_independent_night_control"

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object p0

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    if-eqz p0, :cond_1

    .line 194
    invoke-virtual {p0}, Landroid/view/View;->isShown()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {p0, v0}, Landroid/view/View;->getGlobalVisibleRect(Landroid/graphics/Rect;)Z

    move-result p0

    if-eqz p0, :cond_1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawX()F

    move-result p0

    float-to-int p0, p0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getRawY()F

    move-result p1

    float-to-int p1, p1

    invoke-virtual {v0, p0, p1}, Landroid/graphics/Rect;->contains(II)Z

    move-result p0

    if-eqz p0, :cond_1

    const/4 p0, 0x1

    return p0

    :cond_1
    return v1
.end method

.method static synthetic lambda$refresh$0(Landroid/view/View;Landroid/app/Activity;)V
    .registers 2

    .line 35
    invoke-static {p0, p1}, Lorg/haotian/leicaport/NightControls;->refresh(Landroid/view/View;Landroid/app/Activity;)I

    return-void
.end method

.method static synthetic lambda$refresh$1(Landroid/app/Activity;Landroid/view/View;)V
    .registers 2

    .line 69
    invoke-static {p0}, Lorg/haotian/leicaport/NightControls;->toggle(Landroid/app/Activity;)V

    return-void
.end method

.method static synthetic lambda$static$0()V
    .registers 2

    .line 28
    sget-object v0, Lorg/haotian/leicaport/NightControls;->current:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 29
    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->refresh(Landroid/view/View;Landroid/app/Activity;)I

    :cond_0
    return-void
.end method

.method private static layoutLog(Landroid/view/View;Ljava/lang/String;)V
    .registers 4

    .line 173
    sget-object v0, Lorg/haotian/leicaport/NightControls;->lastLayout:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0, p0, p1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p1}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method private static named(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;
    .registers 3

    .line 178
    const-string v0, "id"

    invoke-static {p0, p1, v0}, Lorg/haotian/leicaport/NightControls;->resource(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    if-nez p1, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    invoke-virtual {p0, p1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object p0

    return-object p0
.end method

.method private static observe(Landroid/view/View;Landroid/app/Activity;)V
    .registers 4

    .line 90
    sget-object v0, Lorg/haotian/leicaport/NightControls;->observers:Ljava/util/WeakHashMap;

    invoke-virtual {v0, p0}, Ljava/util/WeakHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    .line 91
    :cond_0
    new-instance v1, Lorg/haotian/leicaport/NightControls$Sync;

    invoke-direct {v1, p0, p1}, Lorg/haotian/leicaport/NightControls$Sync;-><init>(Landroid/view/View;Landroid/app/Activity;)V

    invoke-virtual {v0, p0, v1}, Ljava/util/WeakHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-virtual {p0, v1}, Landroid/view/View;->addOnAttachStateChangeListener(Landroid/view/View$OnAttachStateChangeListener;)V

    invoke-virtual {v1, p0}, Lorg/haotian/leicaport/NightControls$Sync;->attach(Landroid/view/View;)V

    return-void
.end method

.method private static position(Landroid/widget/FrameLayout;Landroid/view/ViewGroup;Landroid/app/Activity;)[I
    .registers 14

    .line 144
    new-instance p2, Landroid/graphics/Rect;

    invoke-direct {p2}, Landroid/graphics/Rect;-><init>()V

    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    .line 145
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v1

    const/4 v2, 0x0

    if-lez v1, :cond_6

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v1

    if-lez v1, :cond_6

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    const/4 v3, 0x5

    if-eq v1, v3, :cond_0

    goto/16 :goto_2

    .line 146
    :cond_0
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v4

    const/4 v5, 0x0

    invoke-virtual {p2, v5, v5, v1, v4}, Landroid/graphics/Rect;->set(IIII)V

    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getDrawingRect(Landroid/graphics/Rect;)V

    invoke-virtual {p0, p1, v0}, Landroid/widget/FrameLayout;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    const/4 v1, 0x2

    .line 147
    new-array v4, v1, [I

    invoke-virtual {p0, v4}, Landroid/widget/FrameLayout;->getLocationOnScreen([I)V

    new-array v4, v3, [[I

    move v6, v5

    :goto_0
    if-ge v6, v3, :cond_3

    .line 149
    invoke-virtual {p1, v6}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v7

    new-instance v8, Landroid/graphics/Rect;

    invoke-direct {v8}, Landroid/graphics/Rect;-><init>()V

    .line 150
    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v9

    const-string v10, "o5.N"

    invoke-virtual {v10, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_2

    invoke-virtual {v7}, Landroid/view/View;->getWidth()I

    move-result v9

    if-lez v9, :cond_2

    invoke-virtual {v7}, Landroid/view/View;->getHeight()I

    move-result v9

    if-lez v9, :cond_2

    invoke-virtual {v7}, Landroid/view/View;->getVisibility()I

    move-result v9

    if-eqz v9, :cond_1

    goto :goto_1

    .line 151
    :cond_1
    invoke-virtual {v7, v8}, Landroid/view/View;->getDrawingRect(Landroid/graphics/Rect;)V

    invoke-virtual {p0, v7, v8}, Landroid/widget/FrameLayout;->offsetDescendantRectToMyCoords(Landroid/view/View;Landroid/graphics/Rect;)V

    .line 152
    iget v7, v8, Landroid/graphics/Rect;->left:I

    iget v9, v8, Landroid/graphics/Rect;->top:I

    iget v10, v8, Landroid/graphics/Rect;->right:I

    iget v8, v8, Landroid/graphics/Rect;->bottom:I

    filled-new-array {v7, v9, v10, v8}, [I

    move-result-object v7

    aput-object v7, v4, v6

    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    return-object v2

    .line 154
    :cond_3
    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result p1

    invoke-virtual {p0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result p0

    invoke-static {p1, p0, v4}, Lorg/haotian/leicaport/NightMenuLayout;->emptyCell(II[[I)[I

    move-result-object p0

    if-nez p0, :cond_4

    return-object v2

    .line 156
    :cond_4
    new-instance p1, Landroid/graphics/Rect;

    aget v3, p0, v5

    const/4 v4, 0x1

    aget v4, p0, v4

    aget v1, p0, v1

    const/4 v5, 0x3

    aget v5, p0, v5

    invoke-direct {p1, v3, v4, v1, v5}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 157
    invoke-virtual {p2, p1}, Landroid/graphics/Rect;->contains(Landroid/graphics/Rect;)Z

    move-result p2

    if-eqz p2, :cond_6

    invoke-virtual {v0, p1}, Landroid/graphics/Rect;->contains(Landroid/graphics/Rect;)Z

    move-result p1

    if-nez p1, :cond_5

    goto :goto_2

    :cond_5
    return-object p0

    :cond_6
    :goto_2
    return-object v2
.end method

.method public static refresh(Landroid/view/View;Landroid/app/Activity;)I
    .registers 20

    invoke-static/range {p0 .. p1}, Lorg/haotian/palette/PaletteUi;->refresh(Landroid/view/View;Landroid/app/Activity;)V

    invoke-static {}, Lorg/haotian/palette/ProMode;->isActive()Z

    move-result v0

    if-eqz v0, :cond_1

    move-object/from16 v0, p0

    if-eqz v0, :cond_0

    const-string v1, "haotian_independent_night_control"

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    const/4 v0, 0x0

    return v0

    :cond_1
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    .line 34
    const-string v2, "getText"

    const-string v3, "getBgLayout"

    const-string v4, "getRoot"

    const/4 v5, 0x0

    if-eqz v0, :cond_f

    if-eqz v1, :cond_f

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    const-string v7, "com.android.camera.Camera"

    invoke-virtual {v7, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_f

    invoke-virtual {v1}, Landroid/app/Activity;->isFinishing()Z

    move-result v6

    if-nez v6, :cond_f

    invoke-virtual {v1}, Landroid/app/Activity;->isDestroyed()Z

    move-result v6

    if-eqz v6, :cond_2

    goto/16 :goto_5

    .line 35
    :cond_2
    invoke-static {}, Landroid/os/Looper;->myLooper()Landroid/os/Looper;

    move-result-object v6

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v7

    if-eq v6, v7, :cond_3

    new-instance v2, Lorg/haotian/leicaport/NightControls$0;

    invoke-direct {v2, v0, v1}, Lorg/haotian/leicaport/NightControls$0;-><init>(Landroid/view/View;Landroid/app/Activity;)V

    invoke-virtual {v1, v2}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return v5

    .line 36
    :cond_3
    new-instance v6, Ljava/lang/ref/WeakReference;

    invoke-direct {v6, v1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v6, Lorg/haotian/leicaport/NightControls;->current:Ljava/lang/ref/WeakReference;

    .line 37
    sget-object v6, Lorg/haotian/leicaport/NightControls;->MAIN:Landroid/os/Handler;

    sget-object v7, Lorg/haotian/leicaport/NightControls;->REFRESH:Ljava/lang/Runnable;

    invoke-virtual {v6, v7}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    .line 38
    invoke-static/range {p0 .. p1}, Lorg/haotian/leicaport/NightControls;->observe(Landroid/view/View;Landroid/app/Activity;)V

    .line 39
    const-string v0, "refresh"

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->state(Landroid/app/Activity;Ljava/lang/String;)V

    .line 40
    const-string v0, "top_menu_content"

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->named(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;

    move-result-object v0

    const-string v6, "top_menu_recyclerview"

    invoke-static {v1, v6}, Lorg/haotian/leicaport/NightControls;->named(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;

    move-result-object v6

    .line 41
    instance-of v7, v0, Landroid/widget/FrameLayout;

    if-eqz v7, :cond_e

    instance-of v7, v6, Landroid/view/ViewGroup;

    if-nez v7, :cond_4

    goto/16 :goto_4

    .line 42
    :cond_4
    check-cast v0, Landroid/widget/FrameLayout;

    check-cast v6, Landroid/view/ViewGroup;

    .line 43
    const-string v7, "haotian_independent_night_control"

    invoke-virtual {v0, v7}, Landroid/widget/FrameLayout;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    move-result-object v8

    .line 44
    sget-object v9, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {v1}, Lorg/haotian/leicaport/PhotoControls;->videoMode(Landroid/app/Activity;)Ljava/lang/Boolean;

    move-result-object v10

    invoke-virtual {v9, v10}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v9

    const-string v10, " shown="

    const/16 v11, 0x8

    if-eqz v9, :cond_c

    invoke-virtual {v6}, Landroid/view/ViewGroup;->isShown()Z

    move-result v9

    if-nez v9, :cond_5

    goto/16 :goto_3

    .line 45
    :cond_5
    invoke-static {v0, v6, v1}, Lorg/haotian/leicaport/NightControls;->position(Landroid/widget/FrameLayout;Landroid/view/ViewGroup;Landroid/app/Activity;)[I

    move-result-object v9

    if-nez v9, :cond_7

    .line 46
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "no-slot host="

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getWidth()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, "x"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " grid="

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getWidth()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getHeight()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " children="

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->state(Landroid/app/Activity;Ljava/lang/String;)V

    if-eqz v8, :cond_6

    invoke-virtual {v8, v11}, Landroid/view/View;->setVisibility(I)V

    :cond_6
    return v5

    :cond_7
    const/4 v14, 0x1

    if-nez v8, :cond_9

    .line 50
    :try_start_0
    invoke-virtual {v6, v5}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v8

    .line 51
    const-string v15, "o5.N"

    invoke-static {v15}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v15

    const/16 p0, 0x3

    new-array v12, v14, [Ljava/lang/Class;

    const-class v16, Landroid/content/Context;

    aput-object v16, v12, v5

    invoke-virtual {v15, v12}, Ljava/lang/Class;->getConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v12

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v15

    invoke-virtual {v12, v15}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/view/View;

    const/4 v15, -0x1

    .line 52
    invoke-virtual {v12, v15}, Landroid/view/View;->setId(I)V

    invoke-virtual {v12, v7}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    invoke-virtual {v12, v11}, Landroid/view/View;->setVisibility(I)V

    .line 53
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    new-array v11, v5, [Ljava/lang/Class;

    const/4 v11, 0x0

    invoke-virtual {v7, v4, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    invoke-virtual {v7, v12, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Landroid/view/View;

    .line 54
    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v15

    new-array v13, v5, [Ljava/lang/Class;

    invoke-virtual {v15, v4, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-virtual {v4, v8, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/View;

    .line 55
    invoke-virtual {v7}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v13

    invoke-virtual {v4}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v4

    .line 56
    iget v15, v4, Landroid/view/ViewGroup$LayoutParams;->width:I

    iput v15, v13, Landroid/view/ViewGroup$LayoutParams;->width:I

    iget v4, v4, Landroid/view/ViewGroup$LayoutParams;->height:I

    iput v4, v13, Landroid/view/ViewGroup$LayoutParams;->height:I

    invoke-virtual {v7, v13}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 57
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    new-array v13, v5, [Ljava/lang/Class;

    invoke-virtual {v4, v3, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-virtual {v4, v12, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/View;

    .line 58
    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v13

    new-array v15, v5, [Ljava/lang/Class;

    invoke-virtual {v13, v3, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    invoke-virtual {v3, v8, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/view/View;

    .line 59
    invoke-virtual {v3}, Landroid/view/View;->getPaddingLeft()I

    move-result v13

    invoke-virtual {v3}, Landroid/view/View;->getPaddingTop()I

    move-result v15

    invoke-virtual {v3}, Landroid/view/View;->getPaddingRight()I

    move-result v11

    move/from16 v17, v5

    invoke-virtual {v3}, Landroid/view/View;->getPaddingBottom()I

    move-result v5

    invoke-virtual {v4, v13, v15, v11, v5}, Landroid/view/View;->setPadding(IIII)V

    .line 60
    invoke-virtual {v3}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    if-eqz v3, :cond_8

    .line 61
    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v5

    if-eqz v5, :cond_8

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getConstantState()Landroid/graphics/drawable/Drawable$ConstantState;

    move-result-object v3

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/graphics/drawable/Drawable$ConstantState;->newDrawable(Landroid/content/res/Resources;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->mutate()Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v4, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 62
    :cond_8
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    const-string v5, "setEnableBlur"

    new-array v11, v14, [Ljava/lang/Class;

    sget-object v13, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v13, v11, v17

    invoke-virtual {v3, v5, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    invoke-static/range {v17 .. v17}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    invoke-virtual {v12}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    move/from16 v5, v17

    new-array v11, v5, [Ljava/lang/Class;

    const/4 v11, 0x0

    invoke-virtual {v3, v2, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    invoke-virtual {v3, v12, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 64
    invoke-virtual {v8}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v13

    new-array v15, v5, [Ljava/lang/Class;

    invoke-virtual {v13, v2, v11}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    invoke-virtual {v2, v8, v11}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 65
    invoke-virtual {v2}, Landroid/widget/TextView;->getTextSize()F

    move-result v8

    invoke-virtual {v3, v5, v8}, Landroid/widget/TextView;->setTextSize(IF)V

    invoke-virtual {v2}, Landroid/widget/TextView;->getTypeface()Landroid/graphics/Typeface;

    move-result-object v2

    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 66
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v5, "setCustomText"

    new-array v8, v14, [Ljava/lang/Class;

    const-class v11, Ljava/lang/CharSequence;

    const/16 v17, 0x0

    aput-object v11, v8, v17

    invoke-virtual {v2, v5, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    const-string v5, "\u591c\u666f\u589e\u5f3a"

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v2, v3, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v2, 0x2

    .line 67
    invoke-virtual {v3, v2}, Landroid/widget/TextView;->setImportantForAccessibility(I)V

    .line 68
    invoke-virtual {v12, v14}, Landroid/view/View;->setImportantForAccessibility(I)V

    .line 69
    new-instance v2, Lorg/haotian/leicaport/NightControls$1;

    invoke-direct {v2, v1}, Lorg/haotian/leicaport/NightControls$1;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v12, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const/4 v5, 0x0

    .line 71
    invoke-virtual {v4, v5}, Landroid/view/View;->setClickable(Z)V

    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setClickable(Z)V

    invoke-virtual {v7, v5}, Landroid/view/View;->setClickable(Z)V

    .line 72
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v16, 0x2

    aget v3, v9, v16

    aget v4, v9, v5

    sub-int/2addr v3, v4

    aget v4, v9, p0

    aget v5, v9, v14

    sub-int/2addr v4, v5

    const/16 v5, 0x33

    invoke-direct {v2, v3, v4, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    invoke-virtual {v0, v12, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 73
    const-string v2, "NIGHT_CONTROL_ATTACHED parent=top_menu_content nativeItem=o5.N originalItems=5 noPreviewOverlay=true"

    invoke-static {v2}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    move-object v8, v12

    const/16 v17, 0x0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 74
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "create-failed "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lorg/haotian/leicaport/NightControls;->state(Landroid/app/Activity;Ljava/lang/String;)V

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "NIGHT_MENU_CREATE_FAILED="

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    const/16 v17, 0x0

    return v17

    :cond_9
    move/from16 v17, v5

    const/16 p0, 0x3

    .line 76
    :goto_0
    invoke-virtual {v8}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Landroid/widget/FrameLayout$LayoutParams;

    .line 77
    iget v3, v2, Landroid/widget/FrameLayout$LayoutParams;->leftMargin:I

    aget v4, v9, v17

    if-ne v3, v4, :cond_b

    iget v3, v2, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    aget v4, v9, v14

    if-ne v3, v4, :cond_b

    iget v3, v2, Landroid/widget/FrameLayout$LayoutParams;->width:I

    const/16 v16, 0x2

    aget v4, v9, v16

    aget v5, v9, v17

    sub-int/2addr v4, v5

    if-ne v3, v4, :cond_b

    iget v3, v2, Landroid/widget/FrameLayout$LayoutParams;->height:I

    aget v4, v9, p0

    aget v5, v9, v14

    sub-int/2addr v4, v5

    if-eq v3, v4, :cond_a

    goto :goto_1

    :cond_a
    const/4 v5, 0x0

    goto :goto_2

    :cond_b
    :goto_1
    const/4 v5, 0x0

    .line 78
    aget v3, v9, v5

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->leftMargin:I

    aget v3, v9, v14

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    const/16 v16, 0x2

    aget v3, v9, v16

    aget v4, v9, v5

    sub-int/2addr v3, v4

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->width:I

    aget v3, v9, p0

    aget v4, v9, v14

    sub-int/2addr v3, v4

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->height:I

    invoke-virtual {v8, v2}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 80
    :goto_2
    invoke-virtual {v6, v5}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    invoke-static {v8, v2}, Lorg/haotian/leicaport/NightControls;->syncOrientation(Landroid/view/View;Landroid/view/View;)Z

    move-result v2

    .line 81
    invoke-static {v8, v1}, Lorg/haotian/leicaport/NightControls;->update(Landroid/view/View;Landroid/app/Activity;)V

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getAlpha()F

    move-result v3

    invoke-virtual {v8, v3}, Landroid/view/View;->setAlpha(F)V

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getTranslationX()F

    move-result v3

    invoke-virtual {v8, v3}, Landroid/view/View;->setTranslationX(F)V

    invoke-virtual {v6}, Landroid/view/ViewGroup;->getTranslationY()F

    move-result v3

    invoke-virtual {v8, v3}, Landroid/view/View;->setTranslationY(F)V

    invoke-virtual {v8, v5}, Landroid/view/View;->setVisibility(I)V

    const/4 v3, 0x2

    .line 82
    new-array v4, v3, [I

    invoke-virtual {v0, v4}, Landroid/widget/FrameLayout;->getLocationOnScreen([I)V

    .line 83
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "visible "

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v9}, Ljava/util/Arrays;->toString([I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Landroid/view/View;->isShown()Z

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->state(Landroid/app/Activity;Ljava/lang/String;)V

    .line 84
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "NIGHT_CONTROL_POSITION rect="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    new-instance v1, Landroid/graphics/Rect;

    const/16 v17, 0x0

    aget v3, v4, v17

    aget v5, v9, v17

    add-int/2addr v5, v3

    aget v4, v4, v14

    aget v7, v9, v14

    add-int/2addr v7, v4

    const/16 v16, 0x2

    aget v10, v9, v16

    add-int/2addr v3, v10

    aget v9, v9, p0

    add-int/2addr v4, v9

    invoke-direct {v1, v5, v7, v3, v4}, Landroid/graphics/Rect;-><init>(IIII)V

    invoke-virtual {v1}, Landroid/graphics/Rect;->toShortString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " parent=top_menu_content cell=6 nativeRotation="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v5, 0x0

    invoke-virtual {v6, v5}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getRotation()F

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v1, " ownRotation="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Landroid/view/View;->getRotation()F

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const-string v1, " poseSynced="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v8, v0}, Lorg/haotian/leicaport/NightControls;->layoutLog(Landroid/view/View;Ljava/lang/String;)V

    return v14

    .line 44
    :cond_c
    :goto_3
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v2, "hidden video="

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {v1}, Lorg/haotian/leicaport/PhotoControls;->videoMode(Landroid/app/Activity;)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Landroid/view/ViewGroup;->isShown()Z

    move-result v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->state(Landroid/app/Activity;Ljava/lang/String;)V

    if-eqz v8, :cond_d

    invoke-virtual {v8, v11}, Landroid/view/View;->setVisibility(I)V

    :cond_d
    const/16 v17, 0x0

    return v17

    :cond_e
    :goto_4
    move/from16 v17, v5

    .line 41
    const-string v0, "menu-not-inflated"

    invoke-static {v1, v0}, Lorg/haotian/leicaport/NightControls;->state(Landroid/app/Activity;Ljava/lang/String;)V

    return v17

    :cond_f
    :goto_5
    move/from16 v17, v5

    return v17
.end method

.method public static requestRefresh()V
    .registers 2

    .line 31
    sget-object v0, Lorg/haotian/leicaport/NightControls;->MAIN:Landroid/os/Handler;

    sget-object v1, Lorg/haotian/leicaport/NightControls;->REFRESH:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method private static resource(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)I
    .registers 5

    .line 175
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "com.android.camera"

    invoke-virtual {v0, p1, p2, v1}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-eqz v0, :cond_0

    return v0

    .line 176
    :cond_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {p0}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p1, p2, p0}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p0

    return p0
.end method

.method private static state(Landroid/app/Activity;Ljava/lang/String;)V
    .registers 5

    .line 120
    sget-object v0, Lorg/haotian/leicaport/NightControls;->previousState:Ljava/lang/String;

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "refresh"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_1

    :cond_0
    sput-object p1, Lorg/haotian/leicaport/NightControls;->previousState:Ljava/lang/String;

    .line 121
    :try_start_0
    new-instance v0, Ljava/io/FileOutputStream;

    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/app/Activity;->getFilesDir()Ljava/io/File;

    move-result-object p0

    const-string v2, "night-control-state.txt"

    invoke-direct {v1, p0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    new-instance p0, Ljava/lang/StringBuilder;

    invoke-direct {p0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v1

    invoke-virtual {p0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v1, " "

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    sget-object p1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, p1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/io/FileOutputStream;->write([B)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    return-void

    :catchall_0
    move-exception p0

    :try_start_3
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    :try_start_4
    invoke-virtual {p0, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p0
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    :cond_1
    :goto_1
    return-void
.end method

.method private static syncOrientation(Landroid/view/View;Landroid/view/View;)Z
    .registers 7

    .line 125
    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v0

    if-lez v0, :cond_0

    .line 126
    invoke-virtual {p1}, Landroid/view/View;->getPivotX()F

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v0, v1

    invoke-virtual {p1}, Landroid/view/View;->getWidth()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v0, v1

    .line 127
    invoke-virtual {p0}, Landroid/view/View;->getPivotX()F

    move-result v1

    invoke-static {v1, v0}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {p0, v0}, Landroid/view/View;->setPivotX(F)V

    .line 129
    :cond_0
    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v0

    if-lez v0, :cond_1

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v0

    if-lez v0, :cond_1

    .line 130
    invoke-virtual {p1}, Landroid/view/View;->getPivotY()F

    move-result v0

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v1

    int-to-float v1, v1

    mul-float/2addr v0, v1

    invoke-virtual {p1}, Landroid/view/View;->getHeight()I

    move-result v1

    int-to-float v1, v1

    div-float/2addr v0, v1

    .line 131
    invoke-virtual {p0}, Landroid/view/View;->getPivotY()F

    move-result v1

    invoke-static {v1, v0}, Ljava/lang/Float;->compare(FF)I

    move-result v1

    if-eqz v1, :cond_1

    invoke-virtual {p0, v0}, Landroid/view/View;->setPivotY(F)V

    .line 133
    :cond_1
    invoke-virtual {p0}, Landroid/view/View;->getRotation()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/View;->getRotation()F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Float;->compare(FF)I

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Landroid/view/View;->getRotation()F

    move-result v0

    invoke-virtual {p0, v0}, Landroid/view/View;->setRotation(F)V

    .line 134
    :cond_2
    invoke-virtual {p0}, Landroid/view/View;->getRotation()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/View;->getRotation()F

    move-result v1

    invoke-static {v0, v1}, Ljava/lang/Float;->compare(FF)I

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_3

    move v0, v1

    goto :goto_0

    :cond_3
    move v0, v2

    .line 135
    :goto_0
    instance-of v3, p0, Landroid/view/ViewGroup;

    if-eqz v3, :cond_5

    instance-of v3, p1, Landroid/view/ViewGroup;

    if-eqz v3, :cond_5

    .line 136
    check-cast p0, Landroid/view/ViewGroup;

    check-cast p1, Landroid/view/ViewGroup;

    .line 137
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v4

    if-ne v3, v4, :cond_4

    goto :goto_1

    :cond_4
    move v1, v2

    :goto_1
    and-int/2addr v0, v1

    .line 138
    :goto_2
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    invoke-static {v1, v3}, Ljava/lang/Math;->min(II)I

    move-result v1

    if-ge v2, v1, :cond_5

    invoke-virtual {p0, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {p1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    invoke-static {v1, v3}, Lorg/haotian/leicaport/NightControls;->syncOrientation(Landroid/view/View;Landroid/view/View;)Z

    move-result v1

    and-int/2addr v0, v1

    add-int/lit8 v2, v2, 0x1

    goto :goto_2

    :cond_5
    return v0
.end method

.method public static toggle(Landroid/app/Activity;)V
    .registers 8

    .line 181
    const-string v0, "\u591c\u666f\u589e\u5f3a\u5207\u6362\u5931\u8d25\uff0c\u8bf7\u91cd\u8bd5"

    .line 0
    const-string v1, "NIGHT_TOGGLE enabled="

    if-eqz p0, :cond_3

    .line 181
    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v2

    if-nez v2, :cond_3

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v2

    if-nez v2, :cond_3

    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {p0}, Lorg/haotian/leicaport/PhotoControls;->videoMode(Landroid/app/Activity;)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_1

    .line 182
    :cond_0
    invoke-static {}, Lorg/haotian/leicaport/HaotianPort;->nightEnabled()Z

    move-result v2

    const/4 v3, 0x0

    .line 184
    :try_start_0
    const-string v4, "com.codex.leicaapp.SessionPolicy"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "toggleNightBoost"

    new-array v6, v3, [Ljava/lang/Class;

    const/4 v6, 0x0

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    invoke-virtual {v4, v6, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/Boolean;

    invoke-virtual {v4}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-ne v4, v2, :cond_1

    .line 185
    invoke-static {p0, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    return-void

    .line 186
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v1, " scope=next-still-request activityRestart=false"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    if-eqz v4, :cond_2

    .line 187
    const-string v1, "\u591c\u666f\u589e\u5f3a\u5df2\u5f00\u542f\uff0c\u5c06\u7528\u4e8e\u540e\u7eed\u62cd\u7167"

    goto :goto_0

    :cond_2
    const-string v1, "\u591c\u666f\u589e\u5f3a\u5df2\u5173\u95ed\uff0c\u5c06\u7528\u4e8e\u540e\u7eed\u62cd\u7167"

    :goto_0
    invoke-static {p0, v1, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 188
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v1

    invoke-static {v1, p0}, Lorg/haotian/leicaport/NightControls;->refresh(Landroid/view/View;Landroid/app/Activity;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v1

    .line 189
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "NIGHT_TOGGLE_FAILED="

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    invoke-static {p0, v0, v3}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p0

    invoke-virtual {p0}, Landroid/widget/Toast;->show()V

    :cond_3
    :goto_1
    return-void
.end method

.method private static update(Landroid/view/View;Landroid/app/Activity;)V
    .registers 9

    .line 162
    invoke-static {}, Lorg/haotian/leicaport/HaotianPort;->nightEnabled()Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v1, "\u591c\u666f\u589e\u5f3a\uff0c\u5df2\u5f00\u542f\uff0c\u70b9\u51fb\u5173\u95ed"

    goto :goto_0

    :cond_0
    const-string v1, "\u591c\u666f\u589e\u5f3a\uff0c\u5df2\u5173\u95ed\uff0c\u70b9\u51fb\u5f00\u542f"

    .line 163
    :goto_0
    invoke-virtual {p0}, Landroid/view/View;->getContentDescription()Ljava/lang/CharSequence;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 164
    invoke-virtual {v1, v2}, Ljava/lang/String;->contentEquals(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    return-void

    .line 166
    :cond_1
    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v3, "getIcon"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    invoke-virtual {v2, v3, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    invoke-virtual {v2, p0, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    if-eqz v0, :cond_2

    .line 167
    const-string v3, "ic_function_open_super_night"

    goto :goto_1

    :cond_2
    const-string v3, "ic_function_close_super_night"

    :goto_1
    const-string v6, "drawable"

    invoke-static {p1, v3, v6}, Lorg/haotian/leicaport/NightControls;->resource(Landroid/app/Activity;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    invoke-virtual {v2, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    const p1, -0xc4d0

    const/4 v3, -0x1

    if-eqz v0, :cond_3

    move v6, p1

    goto :goto_2

    :cond_3
    move v6, v3

    .line 168
    :goto_2
    invoke-virtual {v2, v6}, Landroid/widget/ImageView;->setColorFilter(I)V

    const/4 v6, 0x2

    invoke-virtual {v2, v6}, Landroid/widget/ImageView;->setImportantForAccessibility(I)V

    .line 169
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    const-string v6, "getText"

    new-array v4, v4, [Ljava/lang/Class;

    invoke-virtual {v2, v6, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v2

    invoke-virtual {v2, p0, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    if-eqz v0, :cond_4

    goto :goto_3

    :cond_4
    move p1, v3

    .line 170
    :goto_3
    invoke-virtual {v2, p1}, Landroid/widget/TextView;->setTextColor(I)V

    invoke-virtual {p0, v0}, Landroid/view/View;->setSelected(Z)V

    invoke-virtual {p0, v1}, Landroid/view/View;->setContentDescription(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/LinkageError; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    .line 171
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "NIGHT_MENU_UPDATE_FAILED="

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lorg/haotian/leicaport/HaotianPort;->line(Ljava/lang/String;)V

    return-void
.end method
