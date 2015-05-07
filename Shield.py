import os
import sys
import xml.dom.minidom
import codecs
import shutil 
import zipfile

def decypt(path):
	decypt = 'java -jar apktool.jar d -f -o out ' + path
	print decypt
	os.system(decypt)
	
def encypt(path):
	encypt = 'java -jar apktool.jar b out -o .\out\shield.apk';
	print encypt
	os.system(encypt)

def sign(path):
	sign = 'java -jar signapk.jar platform.x509.pem platform.pk8 .\out\shield.apk' + ' shield' + path
	print sign
	os.system(sign)	

def install(path):
	ins = 'adb install -r '+' shield' + path
	print ins
	os.system(ins)	

def parseXml():
	path = '.\out\AndroidManifest.xml'
	pathout = '.\out\AndroidManifest.xml'
	tree = xml.dom.minidom.parse(path)
	app = tree.getElementsByTagName('application')[0]
	applicationName = app.getAttribute('android:name')
	if len(applicationName) > 0:
		print "Already has application"
		return
	else:
		print "Normal"
		
	print app 
	app.setAttribute('android:name','com.apk.shield.ShieldApplication')
	
	f=file(pathout, 'w')
	writer = codecs.lookup('utf-8')[3](f)
	tree.writexml(writer, encoding='utf-8')
	writer.close()

def copyFile(src):	
	shieldsrc = '.\\ApkShield\\smali\\com\\apk\\shield\\'
	shielddst = '.\\out\\smali\\com\\apk\\shield\\'
	shutil.rmtree('.\\out\\smali\\')	
	shutil.copytree(shieldsrc,shielddst)
	#dstapk = '.\\out\\assets\\ex07.apk'
	#shutil.copy(src,dstapk)
	
def extractDex(src):
	zipFile = zipfile.ZipFile(src)
	dstpath = '.\\out\\assets\\'
	zipFile.extract('classes.dex',dstpath)
	shutil.copy(dstpath + 'classes.dex',dstpath + 'ex07.apk')
		
#===================================================================================	
print 'Begin decypt'
print 'Begin Shield'
args = ""
for i in range(1,len(sys.argv)):
	args += sys.argv[i]
print args
src = args
#解开apk
decypt(args)
#deal xml file
parseXml()
#
copyFile(src)
#
extractDex(src)
#apk打包
encypt(args)
#apk签名
sign(args)

shutil.rmtree('.\\out')	

#install(src)

print 'End decypt'
print 'End Shield'


