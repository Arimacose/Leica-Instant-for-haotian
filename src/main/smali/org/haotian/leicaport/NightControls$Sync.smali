.class final Lorg/haotian/leicaport/NightControls$Sync;
.super Ljava/lang/Object;
.source "NightControls.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnPreDrawListener;
.implements Landroid/view/View$OnAttachStateChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/haotian/leicaport/NightControls;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Sync"
.end annotation


# instance fields
.field final activity:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/app/Activity;",
            ">;"
        }
    .end annotation
.end field

.field deferred:Z

.field last:Ljava/lang/String;

.field final root:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Landroid/view/View;",
            ">;"
        }
    .end annotation
.end field

.field tree:Landroid/view/ViewTreeObserver;


# direct methods
.method constructor <init>(Landroid/view/View;Landroid/app/Activity;)V
    .registers 4

    .line 96
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 95
    const-string v0, ""

    iput-object v0, p0, Lorg/haotian/leicaport/NightControls$Sync;->last:Ljava/lang/String;

    .line 96
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lorg/haotian/leicaport/NightControls$Sync;->root:Ljava/lang/ref/WeakReference;

    new-instance p1, Ljava/lang/ref/WeakReference;

    invoke-direct {p1, p2}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->activity:Ljava/lang/ref/WeakReference;

    return-void
.end method

.method static signature(Landroid/view/View;Ljava/lang/StringBuilder;)V
    .registers 4

    if-nez p0, :cond_0

    .line 101
    const-string p0, "null"

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    return-void

    .line 102
    :cond_0
    invoke-static {p0}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v0, 0x3a

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getVisibility()I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getLeft()I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getTop()I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getWidth()I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getHeight()I

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getAlpha()F

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getRotation()F

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getTranslationX()F

    move-result v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/view/View;->getTranslationY()F

    move-result v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    const/16 v0, 0x3b

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 103
    instance-of v0, p0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_1

    check-cast p0, Landroid/view/ViewGroup;

    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p0}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_1

    invoke-virtual {p0, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    invoke-static {v1, p1}, Lorg/haotian/leicaport/NightControls$Sync;->signature(Landroid/view/View;Ljava/lang/StringBuilder;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_1
    return-void
.end method


# virtual methods
.method attach(Landroid/view/View;)V
    .registers 3

    .line 97
    iget-object v0, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/view/ViewTreeObserver;->isAlive()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeOnPreDrawListener(Landroid/view/ViewTreeObserver$OnPreDrawListener;)V

    :cond_0
    invoke-virtual {p1}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object p1

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    invoke-virtual {p1}, Landroid/view/ViewTreeObserver;->isAlive()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    invoke-virtual {p1, p0}, Landroid/view/ViewTreeObserver;->addOnPreDrawListener(Landroid/view/ViewTreeObserver$OnPreDrawListener;)V

    :cond_1
    const-string p1, ""

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->last:Ljava/lang/String;

    return-void
.end method

.method public onPreDraw()Z
    .registers 10

    .line 106
    iget-object v0, p0, Lorg/haotian/leicaport/NightControls$Sync;->root:Ljava/lang/ref/WeakReference;

    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    iget-object v1, p0, Lorg/haotian/leicaport/NightControls$Sync;->activity:Ljava/lang/ref/WeakReference;

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Activity;

    const/4 v2, 0x1

    if-eqz v0, :cond_7

    if-eqz v1, :cond_7

    invoke-virtual {v1}, Landroid/app/Activity;->isFinishing()Z

    move-result v3

    if-nez v3, :cond_7

    invoke-virtual {v1}, Landroid/app/Activity;->isDestroyed()Z

    move-result v3

    if-eqz v3, :cond_0

    goto/16 :goto_4

    .line 107
    :cond_0
    const-string v3, "top_menu_recyclerview"

    invoke-static {v1, v3}, Lorg/haotian/leicaport/NightControls;->access$000(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;

    move-result-object v3

    const-string v4, "top_menu_content"

    invoke-static {v1, v4}, Lorg/haotian/leicaport/NightControls;->access$000(Landroid/app/Activity;Ljava/lang/String;)Landroid/view/View;

    move-result-object v4

    .line 108
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v6, 0x0

    if-nez v4, :cond_1

    move v7, v6

    goto :goto_0

    :cond_1
    invoke-static {v4}, Ljava/lang/System;->identityHashCode(Ljava/lang/Object;)I

    move-result v7

    :goto_0
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const/16 v7, 0x3a

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    if-eqz v4, :cond_2

    invoke-virtual {v4}, Landroid/view/View;->isShown()Z

    move-result v8

    if-eqz v8, :cond_2

    move v8, v2

    goto :goto_1

    :cond_2
    move v8, v6

    :goto_1
    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    if-nez v4, :cond_3

    move v8, v6

    goto :goto_2

    :cond_3
    invoke-virtual {v4}, Landroid/view/View;->getWidth()I

    move-result v8

    :goto_2
    invoke-virtual {v5, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    if-nez v4, :cond_4

    move v7, v6

    goto :goto_3

    :cond_4
    invoke-virtual {v4}, Landroid/view/View;->getHeight()I

    move-result v7

    :goto_3
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 109
    invoke-static {v3, v5}, Lorg/haotian/leicaport/NightControls$Sync;->signature(Landroid/view/View;Ljava/lang/StringBuilder;)V

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 110
    iget-object v5, p0, Lorg/haotian/leicaport/NightControls$Sync;->last:Ljava/lang/String;

    invoke-virtual {v3, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_5

    iput-object v3, p0, Lorg/haotian/leicaport/NightControls$Sync;->last:Ljava/lang/String;

    invoke-static {v0, v1}, Lorg/haotian/leicaport/NightControls;->refresh(Landroid/view/View;Landroid/app/Activity;)I

    :cond_5
    if-eqz v4, :cond_6

    .line 113
    invoke-virtual {v4}, Landroid/view/View;->isShown()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {v4}, Landroid/view/View;->isLayoutRequested()Z

    move-result v0

    if-eqz v0, :cond_6

    iget-boolean v0, p0, Lorg/haotian/leicaport/NightControls$Sync;->deferred:Z

    if-nez v0, :cond_6

    iput-boolean v2, p0, Lorg/haotian/leicaport/NightControls$Sync;->deferred:Z

    return v6

    .line 114
    :cond_6
    iput-boolean v6, p0, Lorg/haotian/leicaport/NightControls$Sync;->deferred:Z

    :cond_7
    :goto_4
    return v2
.end method

.method public onViewAttachedToWindow(Landroid/view/View;)V
    .registers 2

    .line 98
    invoke-virtual {p0, p1}, Lorg/haotian/leicaport/NightControls$Sync;->attach(Landroid/view/View;)V

    return-void
.end method

.method public onViewDetachedFromWindow(Landroid/view/View;)V
    .registers 2

    .line 99
    iget-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Landroid/view/ViewTreeObserver;->isAlive()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    invoke-virtual {p1, p0}, Landroid/view/ViewTreeObserver;->removeOnPreDrawListener(Landroid/view/ViewTreeObserver$OnPreDrawListener;)V

    :cond_0
    const/4 p1, 0x0

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->tree:Landroid/view/ViewTreeObserver;

    const-string p1, ""

    iput-object p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->last:Ljava/lang/String;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lorg/haotian/leicaport/NightControls$Sync;->deferred:Z

    return-void
.end method
