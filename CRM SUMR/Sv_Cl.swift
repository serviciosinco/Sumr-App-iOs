/*Codigo completo de tabla automatica*/

 import Foundation
 import UIKit
 
 class Sv_Cl: BaseViewController, UITableViewDataSource, UITableViewDelegate{
 
    let Server = ServerAPI()
    let Sess = Session()
 
    var tableView: UITableView{
        let Tbl = UITableView(frame: self.view.bounds, style: .plain)
        Tbl.dataSource = self
        Tbl.delegate = self
        Tbl.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return Tbl
    }
 
    var colors = [""]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
 
        var _cl = self.Sess.ShowSession(_v: "_cl").components(separatedBy: ",")
        self.colors = _cl
        self.view.addSubview(self.tableView)
    }
 

    //Retornar el numero de filas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.colors.count
    }
 
 
    //Mostrar la informacion en las filas
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as? UITableViewCell
 
        cell?.textLabel?.text = colors[indexPath.row]
        //cell?.imageView?.image = UIImage(named: (self.colors[indexPath.row] + ".jpg"))
 
        
        if let url = NSURL(string: "https://apatel.sumr.in/__ac/apatel/_img/estr/cl_logo.png") {
            if let data = NSData(contentsOf: url as URL) {
                cell?.imageView?.image = UIImage(data: data as Data)
            }
        }
 
        return cell!
    }
 
 
    //Desleccionar fila
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    tableView.deselectRow(at: indexPath, animated: true)
        print("Diste click")
    }
 
 
 }



/*Codigo completo de tabla manual*/
/*import UIKit
import LocalAuthentication

class Sv_Cl: BaseViewController, UITableViewDataSource, UITableViewDelegate{
 
    @IBOutlet weak var MyTbl: UITableView!
    let Sess = Session()
    let Server = ServerAPI()
    var animals = ["panda", "leon"]
 
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
}*/
/*Codigo completo de tabla manual*/
