import Foundation
import UIKit
import LocalAuthentication
import Alamofire
import SwiftyJSON


extension UIViewController {

	class ServerAPI{

		var U_Method = "POST"
		var Url_Method = "https://crm-api.sumr.in/login/"
		private let __a = "&__a=PJTPsaehg3"
		private let __k = "&__k=4c590131e44eeba9a93b3429b4bc6ebc3dd57584"
		private let __p = "&__p=ef7f31d046517b90ec35df92a80549b3be3e95d6"
		private let __p1 = "&_p1=login"

		func SV_Request( tipo:String, data:[String:String], callback:@escaping (_ reviews: JSON) -> ()) {

			var U_postString = "?"+__a+__k+__p+__p1
			for (myKey,myValue) in data {
				U_postString += "&\(myKey)=\(myValue)"
			}
			if self.U_Method == "GET"{
				self.Url_Method = Url_Method + tipo + "/" + U_postString
			}

			var U_Request = URLRequest(url: URL(string:Url_Method)! )
			U_Request.httpMethod = self.U_Method
			U_Request.httpBody = U_postString.data(using: String.Encoding.utf8)

			activityIndicator()

			Alamofire.request(U_Request).responseJSON { r in
				if r.result.isSuccess == true {
					let json = JSON(r.result.value!)
					callback(json)
				}
			}

		}

		func activityIndicator() {
		}

	}

	

	class Session{

		let Sv_Notify = Notify()

		func ShowSession(_k:String) -> String{
			if _k.isEmpty == false{
				let Var_Sess = UserDefaults.standard.string(forKey: _k)
				if((Var_Sess) != nil && (Var_Sess) != ""){
					return Var_Sess!
				}else{
					return "no"
				}
			}
			return "no"
		}

		func SaveSession(_v:Any, _k:String){
			let _u = UserDefaults.standard
			_u.set(_v, forKey: _k)
			_u.synchronize();
		}

		func ShowSession_JSON(_k:String) -> JSON{
			if _k.isEmpty == false {
				let _u = UserDefaults.standard
				if let string = _u.value(forKey: _k) {
					if let Var_Sess = (string as AnyObject).data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false){
						if(Var_Sess.isEmpty == false){
							return JSON(Var_Sess)
						}else{
							return "no"
						}
					}
				}
			}
			return JSON()
		}

		func SaveSession_JSON(_v:JSON, _k:String){
			let _u = UserDefaults.standard
			_u.set(_v.rawString(), forKey: _k)
			_u.synchronize()
		}

		func DeleteSession(_v:String){
			UserDefaults.standard.removeObject(forKey: _v)
			UserDefaults.standard.synchronize();
		}

		func DeviceOwner( callback:@escaping (String?)->() ){

			let authenticationContext = LAContext()
			var error: NSError?

			if authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){

				authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
				                                     localizedReason: "Touch ID para CRM",
				                                     reply: { (success, error) in

														if success {

															callback("ok" as String)

														}else{

															if error != nil {

																//self.Sv_Notify.showAlert(_t:"NO", _m:self.errorMessageForLAErrorCode(errorCode: (error! as NSError).code) )

																callback("no" as String)

															}

														}


				})

			}else{

				//self.Sv_Notify.showAlert(_t:"Error", _m:"No tiene Touch ID" )
				callback("no_id" as String)
			}


		}



		func errorMessageForLAErrorCode( errorCode:Int ) -> String{

			var message = ""

			switch errorCode {

			case LAError.appCancel.rawValue:
				message = "Authentication was cancelled by application"

			case LAError.authenticationFailed.rawValue:
				message = "The user failed to provide valid credentials"

			case LAError.invalidContext.rawValue:
				message = "The context is invalid"

			case LAError.passcodeNotSet.rawValue:
				message = "Passcode is not set on the device"

			case LAError.systemCancel.rawValue:
				message = "Authentication was cancelled by the system"

			case LAError.touchIDLockout.rawValue:
				message = "Too many failed attempts."

			case LAError.touchIDNotAvailable.rawValue:
				message = "TouchID is not available on the device"

			case LAError.userCancel.rawValue:
				message = "The user did cancel"

			case LAError.userFallback.rawValue:
				message = "The user chose to use the fallback"

			default:
				message = "Did not find error code on LAError object"

			}

			return message

		}


	}

}
