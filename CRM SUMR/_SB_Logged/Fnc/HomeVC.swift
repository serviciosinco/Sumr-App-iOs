//
//  HomeVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeVC: BaseViewController{

    @IBOutlet weak var cl_tt: UINavigationItem!
    
    let Sess = Session()
	var Sess_C = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
		Sess_C = self.Sess.ShowSession_JSON(_k: "Sess_C_Data")

		self.cl_tt.title = "Dashboard - " + self.Sess_C["nm"].stringValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print( deviceTokenString )
        
        let dataSend = [ "Device":deviceTokenString ]

        //_ = ServerAPI(tipo: "sve_dvce", data: dataSend ) PIPE aca esta el ID del cel que le genera el sistema para enviarselo a la API no lo borre para trabajarlo
    }

    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }

  
    
}
