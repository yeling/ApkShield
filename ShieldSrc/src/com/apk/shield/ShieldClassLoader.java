package com.apk.shield;


import java.io.File;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.Enumeration;
import java.util.List;

import android.content.Context;
import android.util.Log;
import dalvik.system.DexClassLoader;
import dalvik.system.PathClassLoader;


public class ShieldClassLoader extends PathClassLoader
{
	
	private PathClassLoader mClassLoader = null;
	private Context context;
	private DexClassLoader mDexClassLoader;
	private String mDexPath;
	
	public ShieldClassLoader(
			String desDexPath ,
			Context context ,
			String dexPath ,
			PathClassLoader parent )
	{
		super( dexPath , parent );
		File file = new File( desDexPath );
		this.context = context;
		this.mClassLoader = parent;
		//  		
		try
		{
			List<String> libraryPathElements;
			//			Class cls = mClassLoader.getClass();
			Class cls = PathClassLoader.class;
			Field[] fields = cls.getDeclaredFields();
			Method[] methods = cls.getDeclaredMethods();
			//			Field field = mClassLoader.getClass().getDeclaredField( "pathList" );			
			//			field.setAccessible( true );
			//			Object pathList = field.get( mClassLoader );
			//			field = pathList.getClass().getDeclaredField( "nativeLibraryDirectories" );
			//			field.setAccessible( true );
			//			File[] path = (File[])field.get( pathList );
			//拿到originalclassloader  
			//			List<String> libraryPath = (List<String>)field.get( mClassLoader );
			//====================================
			File dexOutputDir = context.getDir( "dex" , 0 );
			mDexClassLoader = new ShieldDexClassLoader( file.getAbsolutePath() , dexOutputDir.getAbsolutePath() , file.getAbsolutePath() , (PathClassLoader)context.getClassLoader() );
		}
		catch( Exception e )
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// TODO Auto-generated constructor stub
	}
	
	@Override
	protected Class<?> findClass(
			String name ) throws ClassNotFoundException
	{
		Log.d( "MM" , "findClass name " + name );
		Class clazz = null;
		try
		{
			clazz = mClassLoader.loadClass( name );
		}
		catch( Exception e )
		{
		}
		if( clazz != null )
		{
			return clazz;
		}
		return mDexClassLoader.loadClass( name );
		//		return super.findClass( name );
	}
	
	@Override
	protected URL findResource(
			String name )
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , "findResource name " + name );
		return super.findResource( name );
	}
	
	@Override
	protected Enumeration<URL> findResources(
			String name )
	{
		Log.d( "MM" , "findResources name " + name );
		// TODO Auto-generated method stub
		return super.findResources( name );
	}
	
	@Override
	protected synchronized Package getPackage(
			String name )
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , " getPackage name " + name );
		return super.getPackage( name );
	}
	
	@Override
	public String toString()
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , " toString " );
		return super.toString();
	}		
	
}
