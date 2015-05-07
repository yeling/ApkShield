java -jar "%~dp0\apktool.jar" b %1 -o %1.apk
java -jar signapk.jar platform.x509.pem platform.pk8 %1.apk %1-signed.apk
adb install -r %1-signed.apk
echo "Complete yeling"
