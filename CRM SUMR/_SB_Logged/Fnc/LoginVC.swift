//
//  HomeVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import LocalAuthentication
import Alamofire
import SwiftyJSON

class LoginVC: BaseViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var LoginL: UIImageView!
    @IBOutlet weak var CRMUser: UITextField!
    @IBOutlet weak var CRMPass: UITextField!
    @IBOutlet weak var CRMLogin: UIButton!
    @IBOutlet weak var Next_Login: UIButton!
	@IBOutlet weak var Login_Ldr: UIActivityIndicatorView!
    
    var error:NSError?
    
    let Server = ServerAPI()
    let Sv_Notify = Notify()
    let Sess = Session()

    override func viewDidLoad() {
        
        super.viewDidLoad()

		self.Next_Login.isHidden = true
        self.LoginL.frame.origin.y = 111
        self.LoginL.frame.size.height = 200
        self.CRMUser.alpha = 0;
        self.CRMPass.alpha = 0;
        self.CRMLogin.alpha = 0;
        self.CRMUser.layer.cornerRadius = 20;
        self.CRMPass.layer.cornerRadius = 20;
        self.CRMLogin.layer.cornerRadius = 20;
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.LoginL.frame.origin.y = 50
            self.LoginL.frame.size.height = 150
        }, completion: { (finished: Bool) in

			let chkSess = self.Sess.ShowSession(_k:"Sess_U_Id")
			let chkSessCl = self.Sess.ShowSession_JSON(_k:"Sess_C_Data")
			let chkSessData = self.Sess.ShowSession_JSON(_k:"Sess_U_Data")

			//print("chkSessData: \(chkSessData)")
			if chkSess != "no"{
				_ = self.Sess.DeviceOwner(){
					_r in

					if _r != "no" || _r == "no_id"{
						if chkSessCl["id"].isEmpty == true {
							let GoTo = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
							self.present(GoTo, animated: true, completion: nil)
						}else{
							if chkSessData.isEmpty == false {
								let GoTo = self.storyboard?.instantiateViewController(withIdentifier: "Sv_Cl") as! Sv_Cl
								//GoTo.Sess_UsData = chkSessData
								self.present(GoTo, animated: false, completion: nil)
							}
						}
					}
				}

			}else{
				self._ShowLogin()
			}
        })
        
        
    }

	func _ShowLogin(){
		self.CRMUser.fadeIn(
			_dly:0,
			_drt:0.2,
			completionHandler:{
				(success:Bool) -> Void in
				self.CRMPass.fadeIn(
					_dly:0,
					_drt:0.2,
					completionHandler:{
						(success:Bool) -> Void in
						self.CRMLogin.fadeIn(
							_dly:0,
							_drt:0.2,
							completionHandler:{ (success:Bool) -> Void in }
						)
				})
		})
	}

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
         return (cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    @IBAction func loginDo(_ sender:UIButton) { LoginPrc() }
    @IBAction func CRMUser(_ sender: Any) { LoginPrc() }
    @IBAction func CRMPass(_ sender: Any) { LoginPrc() }
    
    func LoginPrc(){
        
        let dataSend = [ "user": self.CRMUser.text, "pass": self.CRMPass.text ] as! [String : String]
        if isValidEmail(_t:self.CRMUser.text!){
            
            
            if self.CRMPass.text != nil && self.CRMPass.text?.isEmpty == false {

				self.LoginPrcLdr(_e:"o")

                let _ = self.Server.SV_Request( tipo: "login", data: dataSend){
                    returnJSON in

					let _r = returnJSON

					if _r["e"].exists() {

						if _r["e"].string == "ok" {

							self.CRMLogin.fadeOut()
							self.CRMUser.fadeOut()
							self.CRMPass.fadeOut()

							self.Sess.SaveSession(_v:_r["us"]["enc"].string! , _k: "Sess_U_Id")
							self.Sess.SaveSession_JSON(_v:_r["us"] , _k: "Sess_U_Data")

                            let _ClLs = self.storyboard?.instantiateViewController(withIdentifier: "Sv_Cl") as! Sv_Cl

							//_ClLs.Sess_UsData = _r["us"]
                            self.present(_ClLs, animated: false, completion: nil)

						}else if _r["w"].exists() {
							self.Sv_Notify.showAlert(_t:"Error", _m:_r["w"].string! )
							self.Login_Ldr.stopAnimating()
							self.LoginPrcLdr()
						}
						else{
							self.Sv_Notify.showAlert(_t:"Error", _m:"Error en la solicitud")
							self.Login_Ldr.stopAnimating()
							self.LoginPrcLdr()
						}
					}else{
						self.Login_Ldr.stopAnimating()
						self.LoginPrcLdr()
					}

                }
            }
            else{
                self.Sv_Notify.showAlert(_t:"Error", _m:"Debe ingresar su clave")
            }
            
        }
        else{
             self.Sv_Notify.showAlert(_t:"Error", _m:"El correo no es valido o esta vacio")
        }
    }

	func LoginPrcLdr(_e:String=""){

		if _e == "o" {

			Login_Ldr.startAnimating()
			CRMUser.isHidden = true
			CRMPass.isHidden = true
			CRMLogin.isHidden = true

		}else{

			Login_Ldr.stopAnimating()
			CRMUser.isHidden = false
			CRMPass.isHidden = false
			CRMLogin.isHidden = false

		}

	}

}
