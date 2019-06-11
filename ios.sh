cd Carthage/Build/iOS
rm -rf Crashlytics.framework Fabric.framework
curl https://building42.github.io/Specs/Carthage/iOS/Fabric.json|grep .zip|head -1|cut -d\" -f4|xargs curl -O 
unzip io.fabric.sdk.ios-default.zip
curl https://building42.github.io/Specs/Carthage/iOS/Crashlytics.json|grep .zip|head -1|cut -d\" -f4|xargs curl -O 
unzip com.twitter.crashlytics.ios-default.zip
echo "Do clean"
rm io.fabric.sdk.mac-default.zip
rm com.twitter.crashlytics.mac-default.zip
cd -
