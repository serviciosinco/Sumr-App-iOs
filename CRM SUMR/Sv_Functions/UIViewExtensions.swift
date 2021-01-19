

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
//import AlamofireImage

extension UIView {

	func fadeIn(
		_dly:Double=0.0,
		_drt:Double=0.5,
		completionHandler:((_ success:Bool)->Void)? = nil) {
		UIView.animate(withDuration:_drt, delay: _dly, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion:{ (finished: Bool) in
			if completionHandler != nil {
				completionHandler!(true)
			}
        })
    }


    func fadeOut(
		_dly:Double=0.0,
		_drt:Double=0.5,
		completionHandler:((_ success:Bool) -> Void)? = nil) {
        UIView.animate(withDuration: _drt, delay: _dly, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
		},
	    completion:{ (finished: Bool) in
			if completionHandler != nil {
				completionHandler!(true)
			}
		})
	}


    func slideInFromLeft(duration: TimeInterval = 0.3) {

        let _o = CATransition()

            _o.type = kCATransitionPush
            _o.subtype = kCATransitionFromLeft
            _o.duration = duration
            _o.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            _o.fillMode = kCAFillModeRemoved

        self.layer.add(_o, forKey: "slideInFromLeftTransition")
    }

	func slideOut(duration: TimeInterval = 0.5) {

		let _o = CATransition()

		_o.type = kCATransitionPush
		_o.subtype = kCATransitionFromRight
		_o.duration = duration

		self.layer.add(_o, forKey: "slideOutTransition")

	}


}


extension UIViewController {

    /*func showAlert(_t:String="Alert", _m:String="Message"){
        let alert = UIAlertView()
        alert.title = _t
        alert.message = _m
        alert.addButton(withTitle: "Ok")
        alert.show()
    }*/
    
    func showAlert(_t:String="Alert", _m:String="Message") {
        let alert = UIAlertController(title: _t, message: _m, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


	func _sClr() -> JSON{

		let Sess = Session()
		let Sess_C = Sess.ShowSession_JSON(_k: "Sess_C_Data")

		//let Sess_U = Sess.ShowSession_JSON(_k: "Sess_U_Data")
		var _r = JSON()

		if !isN( v: Sess_C["clr"]["menu-app"] ) {
			_r["menu-b"] = Sess_C["clr"]["menu-app"]
		}else if !isN( v: Sess_C["clr"]["main"] ) {
			_r["menu-b"] = Sess_C["clr"]["main"]
		}else{
			_r["menu-b"] = "#000"
		}

		if !isN( v: Sess_C["clr"]["menu-app-txt"] ) {
			_r["menu-t"] = Sess_C["clr"]["menu-app-txt"]
		}else{
			_r["menu-t"] = "#fff"
		}

		if !isN( v: Sess_C["clr"]["menu-app-txt"] ) {
			_r["menu-l"] = Sess_C["clr"]["menu-app-lne"]
		}else if !isN( v: Sess_C["clr"]["menu_h"] ) {
			_r["menu-l"] = Sess_C["clr"]["menu_h"]
		}else{
			_r["menu-l"] = "#fff"
		}

		return _r
	}

}

