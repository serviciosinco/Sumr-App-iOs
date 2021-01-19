
import Foundation
import UIKit

extension UIViewController {
    
    
    class ServerAPI{

        var U_Method = "POST"
        /*var Url_Method = "https://crm-api.urosario.net/d/login/"
        private let __u = "&__u=icgarzon@servicios.in"
        private let __k = "&__k=437aab8e633e48f3e06b5525913f97fbc4285fdf"
        private let __p = "&__p=e5e5a44613f677c02bec2bb1569871cb857f9146"*/
        
        var Url_Method = "https://crm-api.sumr.in/login/"
        private let __a = "&__a=PJTPsaehg3"
        private let __k = "&__k=4c590131e44eeba9a93b3429b4bc6ebc3dd57584"
        private let __p = "&__p=ef7f31d046517b90ec35df92a80549b3be3e95d6"
        private let __p1 = "&_p1=login"
        
        func SV_Request( tipo:String, data:[String:String], callback:@escaping (AnyObject?)->() ) -> String{
           
            var U_postString = "?"+__a+__k+__p+__p1
            for (myKey,myValue) in data {
                U_postString += "&\(myKey)=\(myValue)"
            }
            if self.U_Method == "GET"{
                self.Url_Method = Url_Method + tipo + "/" + U_postString
            }

			print(self.Url_Method)

			var U_Request = URLRequest(url: URL(string:Url_Method)! )
            U_Request.httpMethod = self.U_Method
            U_Request.httpBody = U_postString.data(using: String.Encoding.utf8)
           
            let U_Session = URLSession.shared

			activityIndicator()

            U_Session.dataTask(with: U_Request, completionHandler: { (data, response, error) in
                
                if response != nil {
                    
                    if let data = data {
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data,
                                                                        options: JSONSerialization.ReadingOptions.allowFragments)as! [String : AnyObject]
                            //print("\(U_postString) : El metodo es: \(self.Url_Method)")
                            
                            DispatchQueue.main.async {
                                callback(json as AnyObject)
                            }
                            
                            
                        } catch {
                            
                            print(error)
                            
                        }
                    }
                    
                }
                
            }).resume()
            
            
            return ""
        }




		func activityIndicator() {


		}

    }
}
