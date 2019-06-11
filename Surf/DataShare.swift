//
//  DataShare.swift
//  Surf
//
//  Created by yarshure on 15/12/4.
//  Copyright © 2015年 yarshure. All rights reserved.
//

import Foundation
class  DataShare:NSObject{
    
    static  func configPath() ->String{
        
        let urlContain = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.jeffery.Surf")
        let url = urlContain!.appendingPathComponent(".config")
         let u = url.path 
        return u

    }
   
}
