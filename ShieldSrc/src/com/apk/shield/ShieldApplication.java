package com.apk.shield;


import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

import android.app.Application;
import android.content.Context;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.content.res.Resources.Theme;
import android.util.Log;
import dalvik.system.PathClassLoader;


public class ShieldApplication extends Application
{
	
	private Field field;
	private AssetManager mAssetManager;
	private Resources mResources;
	private Theme mTheme;
	//	private String mDexPath = "/android_asset/ex07.apk";
	private String mDexPath = "/mnt/sdcard/ex07.apk";
	
	public void copyLib(
			String src ,
			String dst )
	{
		try
		{
			File out = new File( dst );
			if( out.exists() )
			{
				return;
			}
			InputStream fis = this.getAssets().open( src );			
			FileOutputStream fos = new FileOutputStream( out );
			byte[] buffer = new byte[1024];
			int len = 0;
			while( ( len = fis.read( buffer ) ) != 0 )
			{
				fos.write( buffer , 0 , len );
			}
			fis.close();
			fos.close();
		}
		catch( Exception e )
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	protected void attachBaseContext(
			Context base )
	{
		// TODO Auto-generated method stub
		super.attachBaseContext( base );
		File dir = getFilesDir();
		String path = dir.getAbsolutePath() + "/ex07.apk";
		copyLib( "ex07.apk" , path );
		mDexPath = path;
		Context context = getBaseContext();
		Field loadedApkField;
		try
		{			
			loadedApkField = context.getClass().getDeclaredField( "mPackageInfo" );
			loadedApkField.setAccessible( true );
			Object mPackageInfo = loadedApkField.get( context );
			field = mPackageInfo.getClass().getDeclaredField( "mClassLoader" );
			field.setAccessible( true );
			//拿到originalclassloader  
			Object mClassLoader = field.get( mPackageInfo );
			//创建自定义的classloader  
			ClassLoader loader = new ShieldClassLoader( mDexPath , this , this.getApplicationInfo().sourceDir , (PathClassLoader)mClassLoader );
			//替换originalclassloader为自定义的classloader  
			field.set( mPackageInfo , loader );
			//			
			AssetManager am;
			am = (AssetManager)AssetManager.class.newInstance();
			am.getClass().getMethod( "addAssetPath" , String.class ).invoke( am , mDexPath );
			Resources rs = context.getResources();
			Resources res = new Resources( am , rs.getDisplayMetrics() , rs.getConfiguration() );
			Field field = mPackageInfo.getClass().getDeclaredField( "mResources" );
			field.setAccessible( true );
			field.set( mPackageInfo , res );
			//			loadResources();
		}
		catch( Exception e )
		{
			e.printStackTrace();
		}
	}
	
	//	protected void loadResources()
	//	{
	//		try
	//		{
	//			AssetManager assetManager = AssetManager.class.newInstance();
	//			Method addAssetPath = assetManager.getClass().getMethod( "addAssetPath" , String.class );
	//			addAssetPath.invoke( assetManager , mDexPath );
	//			mAssetManager = assetManager;
	//		}
	//		catch( Exception e )
	//		{
	//			e.printStackTrace();
	//		}
	//		Resources superRes = super.getResources();
	//		mResources = new Resources( mAssetManager , superRes.getDisplayMetrics() , superRes.getConfiguration() );
	//		mTheme = mResources.newTheme();
	//		mTheme.setTo( super.getTheme() );
	//	}
	@Override
	public AssetManager getAssets()
	{
		//		return mAssetManager == null ? super.getAssets() : mAssetManager;
		Log.d( "MM" , "getAssets" );
		return super.getAssets();
	}
	
	@Override
	public Resources getResources()
	{
		//		return mResources == null ? super.getResources() : mResources;
		Log.d( "MM" , "getAssets" );
		return super.getResources();
	}
}
