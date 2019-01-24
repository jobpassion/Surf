# Swift lang opensource VPN application #

这是一个利用Network extension framework 的项目

### 使用技术 ###

* Swift lang opensource proxy application
* libsodium,shadowsocks libev port
* exculde SFSocket not open source(if you want to  build, req a issue)
* use Open Source framework XProxy,XSocket,XRuler,Xcon,libkcp (see Cartfile.resolved)
* include iOS app and macOS app 
### other depend Frameworks###
* github "networkextension/liblwip" "0.3"
* github "networkextension/SystemKit" "56d5ff28f862f39f6e0a8aefe3964b75ade0dd31"
* github "ashleymills/Reachability.swift" ~> 3.0
* github "yarshure/XProxy.git" "master"
* git "file:///tmp/GRDB_project_name_temp" "patched-for-carthage" 
