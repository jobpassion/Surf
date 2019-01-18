//
//  SwitchCell.swift
//  Surf
//
//  Created by yarshure on 16/2/24.
//  Copyright © 2016年 yarshure. All rights reserved.
//

import UIKit
import XRuler
class SwitchCell: UITableViewCell {
    
    @IBOutlet  weak var enableSwitch:UISwitch!
    @IBOutlet weak var label: UILabel!
    func wwdc(){
        if ProxyGroupSettings.share.wwdcStyle {
            label.textColor = UIColor.white
        }else {
            label.textColor = UIColor.black
        }
    }
}
