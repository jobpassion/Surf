# Swift lang opensource VPN application #

这是一个利用Network extension framework 的项目

### 使用技术 ###

* Swift lang opensource proxy application
* use Open Source framework SFSocket,XProxy,XSocket,XRuler,Xcon,libkcp (see Cartfile.resolved)
* include iOS app and macOS app 
### How to build ###
* exec grdbfix.sh ,download and tun GRDB
* ios.sh download Fabric and Crashlytics
* carthage update --platform iOS/Mac , install depend Framework
* build Surf iOS target 

