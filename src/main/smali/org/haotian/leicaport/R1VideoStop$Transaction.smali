.class final Lorg/haotian/leicaport/R1VideoStop$Transaction;
.super Ljava/lang/Object;
.source "R1VideoStop.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/haotian/leicaport/R1VideoStop;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Transaction"
.end annotation


# instance fields
.field volatile cleanupError:Z

.field volatile finished:Z

.field final id:J

.field final module:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field volatile phase:Ljava/lang/String;

.field volatile previewPending:Z

.field volatile releaseCallback:Z

.field volatile releaseReturned:Z

.field volatile releaseStarted:Z

.field volatile saveAttempted:Z

.field final settings:Ljava/lang/Object;

.field volatile stopReturned:Z

.field final uri:Landroid/net/Uri;


# direct methods
.method constructor <init>(Ljava/lang/Object;Ljava/lang/Object;Landroid/net/Uri;)V
    .registers 6

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    invoke-static {}, Lorg/haotian/leicaport/R1VideoStop;->-$$Nest$sfgetIDS()Ljava/util/concurrent/atomic/AtomicLong;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->incrementAndGet()J

    move-result-wide v0

    iput-wide v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->id:J

    .line 42
    const-string v0, "STOP_REQUESTED"

    iput-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->phase:Ljava/lang/String;

    .line 43
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->module:Ljava/lang/ref/WeakReference;

    iput-object p2, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->settings:Ljava/lang/Object;

    iput-object p3, p0, Lorg/haotian/leicaport/R1VideoStop$Transaction;->uri:Landroid/net/Uri;

    return-void
.end method
