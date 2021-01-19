//
//  MainNavigationController.swift
//  CRM SUMR
//
//  Created by Programador Master on 17/08/17.
//  Copyright © 2017 Servicios.in. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class MainNavigationController : UINavigationController{
    
    let Sess = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let chkSess = self.Sess.ShowSession(_k: "_cl")
        print("Llegaste al controlador ")
        
    }
    
}
