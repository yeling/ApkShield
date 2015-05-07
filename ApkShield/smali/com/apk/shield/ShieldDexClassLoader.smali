.class public Lcom/apk/shield/ShieldDexClassLoader;
.super Ldalvik/system/DexClassLoader;
.source "ShieldDexClassLoader.java"


# instance fields
.field mParent:Ldalvik/system/PathClassLoader;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ldalvik/system/PathClassLoader;)V
    .locals 1
    .param p1, "dexPath"    # Ljava/lang/String;
    .param p2, "optimizedDirectory"    # Ljava/lang/String;
    .param p3, "libraryPath"    # Ljava/lang/String;
    .param p4, "parent"    # Ldalvik/system/PathClassLoader;

    .prologue
    .line 22
    invoke-direct {p0, p1, p2, p3, p4}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 15
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/apk/shield/ShieldDexClassLoader;->mParent:Ldalvik/system/PathClassLoader;

    .line 24
    return-void
.end method


# virtual methods
.method protected findClass(Ljava/lang/String;)Ljava/lang/Class;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/ClassNotFoundException;
        }
    .end annotation

    .prologue
    .line 31
    invoke-super {p0, p1}, Ldalvik/system/DexClassLoader;->findClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    return-object v0
.end method

.method public findLibrary(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 39
    const-string v1, "MM"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "ShieldDexClassLoader findLibrary name "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 40
    invoke-super {p0, p1}, Ldalvik/system/DexClassLoader;->findLibrary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 41
    .local v0, "libpath":Ljava/lang/String;
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 43
    invoke-virtual {p0}, Lcom/apk/shield/ShieldDexClassLoader;->getParent()Ljava/lang/ClassLoader;

    move-result-object v1

    check-cast v1, Ldalvik/system/PathClassLoader;

    invoke-virtual {v1, p1}, Ldalvik/system/PathClassLoader;->findLibrary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 45
    :cond_0
    return-object v0
.end method

.method protected findResource(Ljava/lang/String;)Ljava/net/URL;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 53
    const-string v0, "MM"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ShieldDexClassLoader findResource name "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 54
    invoke-super {p0, p1}, Ldalvik/system/DexClassLoader;->findResource(Ljava/lang/String;)Ljava/net/URL;

    move-result-object v0

    return-object v0
.end method

.method protected findResources(Ljava/lang/String;)Ljava/util/Enumeration;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Enumeration",
            "<",
            "Ljava/net/URL;",
            ">;"
        }
    .end annotation

    .prologue
    .line 62
    const-string v0, "MM"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ShieldDexClassLoader findResources name "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 63
    invoke-super {p0, p1}, Ldalvik/system/DexClassLoader;->findResources(Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method protected declared-synchronized getPackage(Ljava/lang/String;)Ljava/lang/Package;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 71
    monitor-enter p0

    :try_start_0
    const-string v0, "MM"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ShieldDexClassLoader getPackage name "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    invoke-super {p0, p1}, Ldalvik/system/DexClassLoader;->getPackage(Ljava/lang/String;)Ljava/lang/Package;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 71
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    .prologue
    .line 79
    invoke-super {p0}, Ldalvik/system/DexClassLoader;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
