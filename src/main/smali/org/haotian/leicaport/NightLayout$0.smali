.class public final synthetic Lorg/haotian/leicaport/NightLayout$0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/ToIntFunction;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/NightLayout;"
    method = "lambda$gap$0"
    proto = "([I)I"
.end annotation


# direct methods
.method public synthetic constructor <init>()V
    .registers 1

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final applyAsInt(Ljava/lang/Object;)I
    .registers 2

    .line 0
    check-cast p1, [I

    invoke-static {p1}, Lorg/haotian/leicaport/NightLayout;->lambda$gap$0([I)I

    move-result p1

    return p1
.end method
