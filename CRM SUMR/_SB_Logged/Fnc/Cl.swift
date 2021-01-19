/*Codigo completo de tabla automatica*/

import Foundation
import UIKit
import Alamofire
//import AlamofireImage
import SwiftyJSON

class Sv_Cl_ViewCell: UITableViewCell {
	@IBOutlet weak var logo: UIImageView!
	@IBOutlet weak var label: UILabel!
}

 class Sv_Cl: BaseViewController, UITableViewDataSource, UITableViewDelegate{

	@IBOutlet weak var t_clientes: UITableView!
	@IBOutlet weak var logo: UIImageView!
	@IBOutlet weak var label: UILabel!

	let Server = ServerAPI()
    let Sess = Session()
//	var Sess_UsData = JSON()

	
	var clients = JSON()
	var client_pic = String()
	var Sess_C = JSON()
	var Sess_U = JSON()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()

		Sess_C = self.Sess.ShowSession_JSON(_k: "Sess_C_Data")
		Sess_U = self.Sess.ShowSession_JSON(_k: "Sess_U_Data")

		var i_cl:Int = 0

		for (_, v) in self.Sess_U["cl"]["ls"] {
			let id = String(i_cl)
			self.clients["cl-"+id] = v
			i_cl+=1
        }
		//self.t_clientes.reloadData()
    }

	public func numberOfSections(in t_clientes: UITableView) -> Int {
		return self.Sess_U["cl"]["tot"].int!
	}

	public func tableView(_ t_clientes: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	public func tableView(_ t_clientes: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 15
	}

	public func tableView(_ t_clientes: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = UIColor.clear
		return headerView
	}

    //Mostrar la informacion en las filas
    public func tableView(_ t_clientes: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{




		let cell = t_clientes.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! Sv_Cl_ViewCell
		let view = UIView()

		let id_row = "cl-"+String(indexPath.section)
		let cl_clr = self.clients[id_row]["clr"]["main"].stringValue

		cell.label.text = self.clients[id_row]["nm"].stringValue.uppercased()

		cell.clipsToBounds = true;
		cell.contentView.layer.cornerRadius = 10
		cell.contentView.layer.borderColor = UIColor.gray.withAlphaComponent(0.6).cgColor
		cell.contentView.layer.borderWidth = 1
		cell.contentView.layer.masksToBounds = true;
		cell.logo.layer.cornerRadius = (cell.logo.frame.size.width) / 2
		cell.logo.layer.borderWidth = 10

		if self.Sess_C["clr"]["main"].isEmpty == false {
			if self.Sess_C["enc"].stringValue != self.clients[id_row]["enc"].stringValue {
				cell.alpha = 0.4
			}else{
				cell.alpha = 1
			}
		}

		if cl_clr.isEmpty == false {
			cell.logo.layer.borderColor = UIColor(hex:cl_clr)?.cgColor
			cell.label.textColor = UIColor(hex:cl_clr)
		} else {
			cell.logo.layer.borderColor = UIColor.white.cgColor
			cell.label.textColor = UIColor.white
		}

		
		if self.clients[id_row]["img"].isEmpty == false {
			self.client_pic = self.clients[id_row]["img"]["th_200"].stringValue
		}else{
			self.client_pic = String("https://img.sumr.in/estr/noncl.png")
		}

		Alamofire.request(self.client_pic).responseData { response in
			if let image = response.result.value {
				cell.logo.image = UIImage(data: image as Data)
			}
		}
		
		return cell
    }

	var shownIndexes : [IndexPath] = []

	public func tableView(_ t_clientes: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if (shownIndexes.contains(indexPath) == false) {
			shownIndexes.append(indexPath)

			cell.transform = CGAffineTransform(translationX: 0, y: 700)
			cell.alpha = 0
			
			UIView.beginAnimations("rotation", context: nil)
			UIView.setAnimationDuration(0.4)
			cell.transform = CGAffineTransform(translationX: 0, y: 0)
			cell.alpha = 1
			UIView.commitAnimations()

		}
	}


	
    //Seleccionar fila
    public func tableView(_ t_clientes: UITableView, didSelectRowAt indexPath: IndexPath){
    t_clientes.deselectRow(at: indexPath, animated: true)

		let id_row = "cl-"+String(indexPath.section)
		self.Sess.SaveSession_JSON(_v:self.clients[id_row] , _k: "Sess_C_Data")

        let Cl_Homes = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController") as! MainNavigationController
        self.present(Cl_Homes, animated: true, completion: nil)

    }
 
 
 }
