package com.apk.shield;

import java.net.URL;
import java.util.Enumeration;

import android.text.TextUtils;
import android.util.Log;

import dalvik.system.DexClassLoader;
import dalvik.system.PathClassLoader;


public class ShieldDexClassLoader extends DexClassLoader
{
	PathClassLoader mParent = null;
	public ShieldDexClassLoader(
			String dexPath ,
			String optimizedDirectory ,
			String libraryPath ,
			PathClassLoader parent )
	{		
		super( dexPath , optimizedDirectory , libraryPath , parent );
		// TODO Auto-generated constructor stub
	}

	@Override
	protected Class<?> findClass(
			String name ) throws ClassNotFoundException
	{
		// TODO Auto-generated method stub
		return super.findClass( name );
	}

	@Override
	public String findLibrary(
			String name )
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , "ShieldDexClassLoader findLibrary name " + name );
		String libpath = super.findLibrary( name );
		if(TextUtils.isEmpty( libpath ))
		{
			libpath = ((PathClassLoader)this.getParent()).findLibrary( name );
		}				
		return libpath;
	}

	@Override
	protected URL findResource(
			String name )
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , "ShieldDexClassLoader findResource name " + name );
		return super.findResource( name );
	}

	@Override
	protected Enumeration<URL> findResources(
			String name )
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , "ShieldDexClassLoader findResources name " + name );
		return super.findResources( name );
	}

	@Override
	protected synchronized Package getPackage(
			String name )
	{
		// TODO Auto-generated method stub
		Log.d( "MM" , "ShieldDexClassLoader getPackage name " + name );
		return super.getPackage( name );
	}

	@Override
	public String toString()
	{
		// TODO Auto-generated method stub
		return super.toString();
	}
	
	
}
