.class public Lcom/apk/shield/ShieldClassLoader;
.super Ldalvik/system/PathClassLoader;
.source "ShieldClassLoader.java"


# instance fields
.field private context:Landroid/content/Context;

.field private mClassLoader:Ldalvik/system/PathClassLoader;

.field private mDexClassLoader:Ldalvik/system/DexClassLoader;

.field private mDexPath:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;Ldalvik/system/PathClassLoader;)V
    .locals 11
    .param p1, "desDexPath"    # Ljava/lang/String;
    .param p2, "context"    # Landroid/content/Context;
    .param p3, "dexPath"    # Ljava/lang/String;
    .param p4, "parent"    # Ldalvik/system/PathClassLoader;

    .prologue
    .line 31
    invoke-direct {p0, p3, p4}, Ldalvik/system/PathClassLoader;-><init>(Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 20
    const/4 v6, 0x0

    iput-object v6, p0, Lcom/apk/shield/ShieldClassLoader;->mClassLoader:Ldalvik/system/PathClassLoader;

    .line 32
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 33
    .local v4, "file":Ljava/io/File;
    iput-object p2, p0, Lcom/apk/shield/ShieldClassLoader;->context:Landroid/content/Context;

    .line 34
    iput-object p4, p0, Lcom/apk/shield/ShieldClassLoader;->mClassLoader:Ldalvik/system/PathClassLoader;

    .line 40
    :try_start_0
    const-class v0, Ldalvik/system/PathClassLoader;

    .line 41
    .local v0, "cls":Ljava/lang/Class;
    invoke-virtual {v0}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v3

    .line 42
    .local v3, "fields":[Ljava/lang/reflect/Field;
    invoke-virtual {v0}, Ljava/lang/Class;->getDeclaredMethods()[Ljava/lang/reflect/Method;

    move-result-object v5

    .line 52
    .local v5, "methods":[Ljava/lang/reflect/Method;
    const-string v6, "dex"

    const/4 v7, 0x0

    invoke-virtual {p2, v6, v7}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v1

    .line 53
    .local v1, "dexOutputDir":Ljava/io/File;
    new-instance v7, Lcom/apk/shield/ShieldDexClassLoader;

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v4}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {p2}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v6

    check-cast v6, Ldalvik/system/PathClassLoader;

    invoke-direct {v7, v8, v9, v10, v6}, Lcom/apk/shield/ShieldDexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ldalvik/system/PathClassLoader;)V

    iput-object v7, p0, Lcom/apk/shield/ShieldClassLoader;->mDexClassLoader:Ldalvik/system/DexClassLoader;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 61
    .end local v0    # "cls":Ljava/lang/Class;
    .end local v1    # "dexOutputDir":Ljava/io/File;
    .end local v3    # "fields":[Ljava/lang/reflect/Field;
    .end local v5    # "methods":[Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 55
    :catch_0
    move-exception v2

    .line 58
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method


# virtual methods
.method protected findClass(Ljava/lang/String;)Ljava/lang/Class;
    .locals 4
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
    .line 67
    const-string v1, "MM"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "findClass name "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 68
    const/4 v0, 0x0

    .line 71
    .local v0, "clazz":Ljava/lang/Class;
    :try_start_0
    iget-object v1, p0, Lcom/apk/shield/ShieldClassLoader;->mClassLoader:Ldalvik/system/PathClassLoader;

    invoke-virtual {v1, p1}, Ldalvik/system/PathClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 76
    :goto_0
    if-eqz v0, :cond_0

    .line 80
    .end local v0    # "clazz":Ljava/lang/Class;
    :goto_1
    return-object v0

    .restart local v0    # "clazz":Ljava/lang/Class;
    :cond_0
    iget-object v1, p0, Lcom/apk/shield/ShieldClassLoader;->mDexClassLoader:Ldalvik/system/DexClassLoader;

    invoke-virtual {v1, p1}, Ldalvik/system/DexClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    goto :goto_1

    .line 73
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public findLibrary(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 89
    const-string v1, "MM"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "findLibrary name "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 92
    :try_start_0
    iget-object v1, p0, Lcom/apk/shield/ShieldClassLoader;->mClassLoader:Ldalvik/system/PathClassLoader;

    invoke-virtual {v1, p1}, Ldalvik/system/PathClassLoader;->findLibrary(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    .line 96
    :goto_0
    return-object v1

    .line 94
    :catch_0
    move-exception v0

    .line 96
    .local v0, "e":Ljava/lang/Exception;
    iget-object v1, p0, Lcom/apk/shield/ShieldClassLoader;->mDexClassLoader:Ldalvik/system/DexClassLoader;

    invoke-virtual {v1, p1}, Ldalvik/system/DexClassLoader;->findLibrary(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0
.end method

.method protected findResource(Ljava/lang/String;)Ljava/net/URL;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 105
    const-string v0, "MM"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "findResource name "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 106
    invoke-super {p0, p1}, Ldalvik/system/PathClassLoader;->findResource(Ljava/lang/String;)Ljava/net/URL;

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
    .line 113
    const-string v0, "MM"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "findResources name "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 115
    invoke-super {p0, p1}, Ldalvik/system/PathClassLoader;->findResources(Ljava/lang/String;)Ljava/util/Enumeration;

    move-result-object v0

    return-object v0
.end method

.method protected declared-synchronized getPackage(Ljava/lang/String;)Ljava/lang/Package;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;

    .prologue
    .line 123
    monitor-enter p0

    :try_start_0
    const-string v0, "MM"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, " getPackage name "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 124
    invoke-super {p0, p1}, Ldalvik/system/PathClassLoader;->getPackage(Ljava/lang/String;)Ljava/lang/Package;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v0

    monitor-exit p0

    return-object v0

    .line 123
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 131
    const-string v0, "MM"

    const-string v1, " toString "

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 132
    invoke-super {p0}, Ldalvik/system/PathClassLoader;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
