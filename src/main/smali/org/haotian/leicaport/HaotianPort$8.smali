.class public final synthetic Lorg/haotian/leicaport/HaotianPort$8;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/util/function/Predicate;


# annotations
.annotation runtime Lcom/android/tools/r8/annotations/LambdaMethod;
    holder = "Lorg/haotian/leicaport/HaotianPort;"
    method = "lambda$limitVideoRates$0"
    proto = "(Ljava/lang/Integer;)Z"
.end annotation


# direct methods
.method public synthetic constructor <init>()V
    .registers 1

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final test(Ljava/lang/Object;)Z
    .registers 2

    .line 0
    check-cast p1, Ljava/lang/Integer;

    invoke-static {p1}, Lorg/haotian/leicaport/HaotianPort;->lambda$limitVideoRates$0(Ljava/lang/Integer;)Z

    move-result p1

    return p1
.end method
