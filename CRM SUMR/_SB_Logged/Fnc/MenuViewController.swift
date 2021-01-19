//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
//import AlamofireImage






protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tblMenuOptions : UITableView!
    @IBOutlet var btnCloseMenuOverlay : UIButton!
	@IBOutlet var tblMenuView: UIView!
	@IBOutlet var UsImg: UIImageView!


	let Sess = Session()
    
    var arrayMenuOptions = [Dictionary<String,String>]()
    var btnMenu : UIButton!
    var btnOver : UIButton!
    var delegate : SlideMenuDelegate?
	var Sess_C = JSON()
	var Sess_U = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
		Sess_C = self.Sess.ShowSession_JSON(_k: "Sess_C_Data")
		Sess_U = self.Sess.ShowSession_JSON(_k: "Sess_U_Data")

		self.tblMenuView.backgroundColor = UIColor(hex: _sClr()["menu-b"].stringValue )

		self.UsImg.layer.cornerRadius = (self.UsImg.frame.size.width) / 2
		self.UsImg.layer.borderWidth = 2
		self.UsImg.layer.borderColor = UIColor.white.cgColor

		Alamofire.request(self.Sess_U["img"]["sm_s"].stringValue).responseData { response in
			if let image = response.result.value {
				self.UsImg.image = UIImage(data: image as Data)
			}
		}

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Inicio", "_k":"Home", "icon":"Icon_Home"])
        arrayMenuOptions.append(["title":"Tareas", "_k":"tra", "icon":"Icon_Tarea"])
        arrayMenuOptions.append(["title":"Visitas", "_k":"vst", "icon":"Icon_Visita"])
        arrayMenuOptions.append(["title":"Eventos", "_k":"evn", "icon":"Icon_Evento"])
        arrayMenuOptions.append(["title":"Salir", "_k":"Sv_Exit", "icon":"Icon_Out"])
        tblMenuOptions.reloadData()
    }

    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0

        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }

        UIView.animate(withDuration: 0.2, animations: { () -> Void in
			self.tblMenuView.frame = CGRect(x: -UIScreen.main.bounds.size.width,
			                                y: 66,
			                                width: UIScreen.main.bounds.size.width,
			                                height: UIScreen.main.bounds.size.height)

			self.tblMenuView.layoutIfNeeded()

        }, completion: { (finished) -> Void in
			if finished {
				self.oPnMnu(
					completionHandler:{
						(success:Bool) -> Void in
						self.view.removeFromSuperview()
						self.removeFromParentViewController()
				})
			}
        })

    }







	@IBAction func btnAccounts(_ sender:UIButton) {
		print("Show account")
		let GoTo = self.storyboard?.instantiateViewController(withIdentifier: "Sv_Cl") as! Sv_Cl
		self.present(GoTo, animated: false, completion: nil)
	}




    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
		

		let viewSeparatorLine = UIView(frame:CGRect(x: 0,
		                                            y: cell.contentView.frame.size.height - 1.0,
		                                            width: cell.contentView.frame.size.width,
		                                            height: 1))

		viewSeparatorLine.backgroundColor = UIColor(hex: _sClr()["menu-l"].stringValue )
		cell.contentView.addSubview(viewSeparatorLine)

        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
		lblTitle.textColor = UIColor( hex:_sClr()["menu-t"].stringValue )

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
        
        //Cerrar sesion
        if arrayMenuOptions[indexPath.row]["_k"] == "Sv_Exit"{

            self.Sess.DeleteSession(_v: "Sess_U_Id")
			self.Sess.DeleteSession(_v: "Sess_C_Data")

            let Login = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.present(Login, animated: true, completion: nil)
        }
        else if arrayMenuOptions[indexPath.row]["_k"] == "Home"{
            let Login = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
            Login.modalTransitionStyle = .flipHorizontal
            self.present(Login, animated: true, completion: nil)
        }
        else if arrayMenuOptions[indexPath.row]["_k"] == "tra"{
            let Login = self.storyboard?.instantiateViewController(withIdentifier: "TraNavigationController") as! TraNavigationController
            Login.modalTransitionStyle = .flipHorizontal
            self.present(Login, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }


    func oPnMnu(
		estado:String="",
		completionHandler:((_ success:Bool)->Void)? = nil
		){
        if estado == "o" {
            
            self.btnCloseMenuOverlay.alpha = 0;
            self.tblMenuView.slideInFromLeft()
            
            self.btnCloseMenuOverlay.fadeIn(
				_dly:0.2,
				completionHandler:{
					(success:Bool) -> Void in
				}
            )

        }else{

			self.btnCloseMenuOverlay.fadeOut(
				_dly:0,
				_drt:0.2,
				completionHandler:{
					(success:Bool) -> Void in

					if completionHandler != nil {
						completionHandler!(true)
					}
			})

        }
    }

}
