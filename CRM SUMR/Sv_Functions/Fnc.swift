import Foundation
import UIKit

extension UIViewController {

	func isValidEmail(_t:String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: _t)
	}

	func isN(v:Any) -> Bool{
		var _r = true

		let _v_str = String(describing: v)

		if (v as AnyObject).isEmpty == true{
			_r = true
		}else if _v_str == "null" {
			_r = true
		}else{
			_r = false
		}
		return _r
	}


	class Notify{

		func showAlert(_t:String="Alert", _m:String="Message"){
			let alert = UIAlertView()
			alert.title = _t
			alert.message = _m
			alert.addButton(withTitle: "Ok")
			alert.show()
		}


	}

}
