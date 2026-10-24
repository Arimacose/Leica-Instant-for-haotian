.class public final Lorg/haotian/leicaport/NightLayout;
.super Ljava/lang/Object;
.source "NightLayout.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static gap(III[[I)I
    .registers 13

    .line 9
    const/4 v0, -0x1

    if-lez p0, :cond_6

    if-lez p1, :cond_6

    if-ltz p2, :cond_6

    mul-int/lit8 v1, p2, 0x2

    add-int/2addr v1, p1

    if-le v1, p0, :cond_0

    goto/16 :goto_2

    .line 10
    :cond_0
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 11
    array-length v2, p3

    const/4 v3, 0x0

    move v4, v3

    :goto_0
    const/4 v5, 0x1

    if-ge v4, v2, :cond_2

    aget-object v6, p3, v4

    if-eqz v6, :cond_1

    array-length v7, v6

    const/4 v8, 0x2

    if-lt v7, v8, :cond_1

    aget v7, v6, v5

    aget v8, v6, v3

    if-le v7, v8, :cond_1

    aget v7, v6, v5

    if-lez v7, :cond_1

    aget v7, v6, v3

    if-ge v7, p0, :cond_1

    aget v7, v6, v3

    invoke-static {v3, v7}, Ljava/lang/Math;->max(II)I

    move-result v7

    aget v5, v6, v5

    invoke-static {p0, v5}, Ljava/lang/Math;->min(II)I

    move-result v5

    filled-new-array {v7, v5}, [I

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_1
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 12
    :cond_2
    new-instance p3, Lorg/haotian/leicaport/NightLayout$0;

    invoke-direct {p3}, Lorg/haotian/leicaport/NightLayout$0;-><init>()V

    invoke-static {p3}, Ljava/util/Comparator;->comparingInt(Ljava/util/function/ToIntFunction;)Ljava/util/Comparator;

    move-result-object p3

    invoke-interface {v1, p3}, Ljava/util/List;->sort(Ljava/util/Comparator;)V

    .line 13
    nop

    .line 14
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p3

    move v1, p2

    :goto_1
    invoke-interface {p3}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_4

    invoke-interface {p3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    .line 15
    add-int v4, v1, p1

    add-int/2addr v4, p2

    aget v6, v2, v3

    if-gt v4, v6, :cond_3

    return v1

    .line 16
    :cond_3
    aget v2, v2, v5

    add-int/2addr v2, p2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 17
    goto :goto_1

    .line 18
    :cond_4
    add-int/2addr p1, v1

    add-int/2addr p1, p2

    if-gt p1, p0, :cond_5

    move v0, v1

    :cond_5
    return v0

    .line 9
    :cond_6
    :goto_2
    return v0
.end method

.method static synthetic lambda$gap$0([I)I
    .registers 2

    .line 12
    const/4 v0, 0x0

    aget p0, p0, v0

    return p0
.end method
