//
//  HomeVC.swift
//  AKSwiftSlideMenu
//
//  Created by MAC-186 on 4/8/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginVC: BaseViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var LoginL: UIImageView!
    @IBOutlet weak var CRMUser: UITextField!
    @IBOutlet weak var CRMPass: UITextField!
    @IBOutlet weak var CRMLogin: UIButton!
    @IBOutlet weak var Next_Login: UIButton!
	@IBOutlet weak var Login_Ldr: UIActivityIndicatorView!
    @IBOutlet weak var MyTbl: UITableView!
    
    var error:NSError?
    
    let Server = ServerAPI()
    let Sv_Notify = Notify()
    let Sess = Session()
    var animals = ["panda", "leon"]
    //let CellCntr = ViewControllerTableViewCell()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.Sess.DeleteSession(_v: "_cl")
        
        /*let dataSend = [ "tp": "_cl" ] as! [String : String]
        let _ = self.Server.SV_Request( tipo: "login", data: dataSend){
            returnJSON in
            let _r = returnJSON!
            
            print(_r["colors"])
            self.animals = _r["colors"]! as! [String]
            self.view.addSubview(self.MyTbl)
        }*/
        self.MyTbl.isHidden = true
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
                                completionHandler:{
                                    (success:Bool) -> Void in
                                    let chkSess = self.Sess.ShowSession(_v: "UsSessId")

                                    if chkSess != "no"{
										_ = self.Sess.DeviceOwner(){
											_r in

											if _r != "no" || _r == "no_id"{

												let Homes = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
												self.present(Homes, animated: true, completion: nil)

											}
										}
										
                                    }
                                }
                            )
                    })
            })
        })
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.animals.count)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
         let dataSend = [ "tp": "_cl" ] as! [String : String]
         let _ = self.Server.SV_Request( tipo: "login", data: dataSend){
         returnJSON in
            let _r = returnJSON!
            self.animals = _r["colors"]! as! [String]
            cell._ec_img.image = UIImage(named: (self.animals[indexPath.row] + ".jpg"))
            cell._ec_tt.text = self.animals[indexPath.row]
            //self.view.addSubview(self.MyTbl)
         }
        
         return (cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        print("Diste click")
        
    }
    
    
    func isValidEmail(_t:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: _t)
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
                    let _r = returnJSON!
                    print(_r)
					if _r["e"] != nil {

						if _r["e"]! as! String == "ok" {
                            
                            self.Sess.SaveSession(_v:_r["cl"] , _k: "_cl")
                            self.Sess.SaveSession(_v:_r["cl_l"] , _k: "_cl_k")
							self.Sess.SaveSession(_v:_r["enc"] , _k: "UsSessId")

							//let Home = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
                            let Home = self.storyboard?.instantiateViewController(withIdentifier: "Cl_Controller") as! Cl_Controller
							self.present(Home, animated: true, completion: nil)
                            
                            /*self.CRMLogin.isHidden = true
                            self.CRMUser.isHidden = true
                            self.CRMPass.isHidden = true*/
                            
						}else if _r["w"] != nil{
							self.Sv_Notify.showAlert(_t:"Error", _m:_r["w"] as! String )
						}
						else{
							self.Sv_Notify.showAlert(_t:"Error", _m:"Error en la solicitud")
						}
					}
                    
                    self.Login_Ldr.stopAnimating()
					self.LoginPrcLdr()

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
