import UIKit

class tra: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    let Server = ServerAPI()
    
    var tableView: UITableView{
        let tv = UITableView(frame: self.view.bounds, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return tv
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
    }
    
   
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    //Retornar el numero de filas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return self.colors.count
		return 1
    }
    
    
    //Mostrar la informacion en las filas
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as? UITableViewCell
        
        //cell?.textLabel?.text = colors[indexPath.row]
        //cell?.imageView?.image = UIImage(named: (self.colors[indexPath.row] + ".jpg"))
        
        return cell!
    }
    
    
    //Desleccionar fila
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Diste click")
    }

    
}
