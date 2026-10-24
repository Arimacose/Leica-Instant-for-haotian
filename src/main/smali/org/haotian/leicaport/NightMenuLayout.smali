.class public final Lorg/haotian/leicaport/NightMenuLayout;
.super Ljava/lang/Object;
.source "NightMenuLayout.java"


# direct methods
.method public constructor <init>()V
    .registers 1

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static emptyCell(II[[I)[I
    .registers 14

    .line 8
    const/4 v0, 0x0

    if-lez p0, :cond_f

    if-lez p1, :cond_f

    if-eqz p2, :cond_f

    array-length v1, p2

    const/4 v2, 0x5

    if-eq v1, v2, :cond_0

    goto/16 :goto_8

    .line 9
    :cond_0
    new-array v1, v2, [[I

    .line 10
    const/4 v3, 0x0

    move v4, v3

    :goto_0
    const/4 v5, 0x4

    const/4 v6, 0x2

    const/4 v7, 0x3

    const/4 v8, 0x1

    if-ge v4, v2, :cond_3

    .line 11
    aget-object v9, p2, v4

    .line 12
    if-eqz v9, :cond_2

    array-length v10, v9

    if-ne v10, v5, :cond_2

    aget v5, v9, v3

    if-ltz v5, :cond_2

    aget v5, v9, v8

    if-ltz v5, :cond_2

    aget v5, v9, v6

    if-gt v5, p0, :cond_2

    aget v5, v9, v7

    if-gt v5, p1, :cond_2

    aget v5, v9, v6

    aget v6, v9, v3

    if-le v5, v6, :cond_2

    aget v5, v9, v7

    aget v6, v9, v8

    if-gt v5, v6, :cond_1

    goto :goto_1

    .line 13
    :cond_1
    invoke-virtual {v9}, [I->clone()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [I

    aput-object v5, v1, v4

    .line 10
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 12
    :cond_2
    :goto_1
    return-object v0

    .line 15
    :cond_3
    new-instance p2, Lorg/haotian/leicaport/NightMenuLayout$0;

    invoke-direct {p2}, Lorg/haotian/leicaport/NightMenuLayout$0;-><init>()V

    invoke-static {p2}, Ljava/util/Comparator;->comparingInt(Ljava/util/function/ToIntFunction;)Ljava/util/Comparator;

    move-result-object p2

    new-instance v4, Lorg/haotian/leicaport/NightMenuLayout$1;

    invoke-direct {v4}, Lorg/haotian/leicaport/NightMenuLayout$1;-><init>()V

    invoke-interface {p2, v4}, Ljava/util/Comparator;->thenComparingInt(Ljava/util/function/ToIntFunction;)Ljava/util/Comparator;

    move-result-object p2

    invoke-static {v1, p2}, Ljava/util/Arrays;->sort([Ljava/lang/Object;Ljava/util/Comparator;)V

    .line 16
    aget-object p2, v1, v3

    aget p2, p2, v7

    aget-object v4, v1, v3

    aget v4, v4, v8

    sub-int/2addr p2, v4

    div-int/lit8 p2, p2, 0xa

    invoke-static {v7, p2}, Ljava/lang/Math;->max(II)I

    move-result p2

    .line 17
    move v4, v8

    :goto_2
    if-ge v4, v7, :cond_6

    aget-object v9, v1, v4

    aget v9, v9, v8

    aget-object v10, v1, v3

    aget v10, v10, v8

    sub-int/2addr v9, v10

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v9

    if-gt v9, p2, :cond_5

    add-int/lit8 v9, v4, -0x1

    aget-object v9, v1, v9

    aget v9, v9, v6

    aget-object v10, v1, v4

    aget v10, v10, v3

    if-le v9, v10, :cond_4

    goto :goto_3

    :cond_4
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_5
    :goto_3
    return-object v0

    .line 18
    :cond_6
    aget-object v4, v1, v7

    aget v4, v4, v8

    aget-object v9, v1, v3

    aget v9, v9, v7

    if-lt v4, v9, :cond_e

    aget-object v4, v1, v5

    aget v4, v4, v8

    aget-object v9, v1, v7

    aget v9, v9, v8

    sub-int/2addr v4, v9

    invoke-static {v4}, Ljava/lang/Math;->abs(I)I

    move-result v4

    if-gt v4, p2, :cond_e

    aget-object v4, v1, v7

    aget v4, v4, v6

    aget-object v9, v1, v5

    aget v9, v9, v3

    if-le v4, v9, :cond_7

    goto :goto_7

    .line 19
    :cond_7
    aget-object v4, v1, v7

    aget v4, v4, v3

    aget-object v9, v1, v3

    aget v9, v9, v3

    sub-int/2addr v4, v9

    invoke-static {v4}, Ljava/lang/Math;->abs(I)I

    move-result v4

    if-gt v4, p2, :cond_d

    aget-object v4, v1, v5

    aget v4, v4, v3

    aget-object v5, v1, v8

    aget v5, v5, v3

    sub-int/2addr v4, v5

    invoke-static {v4}, Ljava/lang/Math;->abs(I)I

    move-result v4

    if-le v4, p2, :cond_8

    goto :goto_6

    .line 20
    :cond_8
    aget-object p2, v1, v6

    aget p2, p2, v3

    aget-object v4, v1, v7

    aget v4, v4, v8

    aget-object v5, v1, v6

    aget v5, v5, v6

    aget-object v9, v1, v7

    aget v9, v9, v7

    filled-new-array {p2, v4, v5, v9}, [I

    move-result-object p2

    .line 21
    aget v4, p2, v3

    if-ltz v4, :cond_c

    aget v4, p2, v8

    if-ltz v4, :cond_c

    aget v4, p2, v6

    if-gt v4, p0, :cond_c

    aget p0, p2, v7

    if-le p0, p1, :cond_9

    goto :goto_5

    .line 22
    :cond_9
    nop

    :goto_4
    if-ge v3, v2, :cond_b

    aget-object p0, v1, v3

    invoke-static {p0, p2}, Lorg/haotian/leicaport/NightMenuLayout;->intersects([I[I)Z

    move-result p0

    if-eqz p0, :cond_a

    return-object v0

    :cond_a
    add-int/lit8 v3, v3, 0x1

    goto :goto_4

    .line 23
    :cond_b
    return-object p2

    .line 21
    :cond_c
    :goto_5
    return-object v0

    .line 19
    :cond_d
    :goto_6
    return-object v0

    .line 18
    :cond_e
    :goto_7
    return-object v0

    .line 8
    :cond_f
    :goto_8
    return-object v0
.end method

.method public static intersects([I[I)Z
    .registers 7

    .line 25
    const/4 v0, 0x0

    aget v1, p0, v0

    const/4 v2, 0x2

    aget v3, p1, v2

    if-ge v1, v3, :cond_0

    aget v1, p1, v0

    aget v2, p0, v2

    if-ge v1, v2, :cond_0

    const/4 v1, 0x1

    aget v2, p0, v1

    const/4 v3, 0x3

    aget v4, p1, v3

    if-ge v2, v4, :cond_0

    aget p1, p1, v1

    aget p0, p0, v3

    if-ge p1, p0, :cond_0

    move v0, v1

    :cond_0
    return v0
.end method

.method static synthetic lambda$emptyCell$0([I)I
    .registers 2

    .line 15
    const/4 v0, 0x1

    aget p0, p0, v0

    return p0
.end method

.method static synthetic lambda$emptyCell$1([I)I
    .registers 2

    .line 15
    const/4 v0, 0x0

    aget p0, p0, v0

    return p0
.end method
