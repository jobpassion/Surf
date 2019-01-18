
//
//  PacketTunnelProvider.swift
//  PacketTunnel
//
//  Created by kiwi on 15/11/23.
//  Copyright © 2015年 yarshure. All rights reserved.
//

import NetworkExtension
import SwiftyJSON
import SFSocket
import AxLogger
import Crashlytics
import Fabric
import Xcon
import XRuler
import XSocket
class PacketTunnelProvider: SFPacketTunnelProvider{

    override init() {
        prepare()
        
        super.init()
    }
    override func startTunnel(options: [String : NSObject]? = nil, completionHandler: @escaping (Error?) -> Void) {
        
        RawSocketFactory.TunnelProvider = self;
        #if os(iOS)
        Fabric.with([Crashlytics.self])
        Fabric.with([Answers.self])
            DispatchQueue.main.async {
                autoreleasepool {
                    
                    Answers.logCustomEvent(withName: "VPN",
                                           customAttributes: [
                                            "Started": "",
                                            
                                            ])
                }
                
            }
        #endif
        super.start(options: options, completionHandler: completionHandler)
    }
}
