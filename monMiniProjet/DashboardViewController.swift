

import UIKit
import Alamofire
import AlamofireImage

class DashboardViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate{
    
    
    var urlFr = ViewController.Ip  + "miniProjetWebService/Langue/leaderboard/LeaderboardFr.php"
    var urlEng = ViewController.Ip + "miniProjetWebService/Langue/leaderboard/LeaderboardENG.php"
    var urlEsp = ViewController.Ip + "miniProjetWebService/Langue/leaderboard/LeaderboardESP.php"
    var urlGer = ViewController.Ip + "miniProjetWebService/Langue/leaderboard/LeaderboardGER.php"
    var Url : String = ""
    var idLevel : String?
    var idLangue : String?
    var Leaders : NSArray = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(idLevel!)
        //if idlangue = 1 urlFr
        //if idlangue = 1 urlEng
        //if idlangue = 1 urlEsp
        //if idlangue = 1 urlGer
        if idLangue! == "1" {
            //urlFr += self.idLevel!
            Url = urlFr
            print(Url)
        }
        if idLangue! == "2" {
            // urlEng += self.idLevel!
            Url = urlEng
            print(Url)
        }
        if idLangue! == "3" {
            // urlGer += self.idLevel!
            Url = urlGer
            print(Url)
        }
        if idLangue! == "4" {
            //urlEsp += self.idLevel!
            Url = urlEsp
            print(Url)
        }
        
        
        
        FetchData()
        
        
        
    }
    func FetchData() {
        Alamofire.request(Url).responseJSON{
            response in
            
            self.Leaders = response.result.value as! NSArray
            self.tableView.reloadData()
            
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Leaders.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoard", for : indexPath)
        
        
        let names = cell.viewWithTag(1) as!  UILabel
        let scores = cell.viewWithTag(2) as!  UILabel
        let image = cell.viewWithTag(3) as! UIImageView
        
        // names.text = leaderboardNamesTab[indexPath.row]
        //scores.text = ScoresTab[indexPath.row]
        //image.image = UIImage (named: imgTab[indexPath.row])
        
        
        
        let tabLead = Leaders[indexPath.row] as! Dictionary<String,Any>
        let img = tabLead["image"] as! String
        let user = tabLead["username"] as! String
        
        image.af_setImage(withURL: URL(string: img)!)
        
        names.text = user
        if idLangue! == "1" {
            let score = tabLead["scoreF"] as! String
            scores.text = score
        }else if idLangue! == "2" {
            let score = tabLead["scoreAng"] as! String
            scores.text = score
            
        }else if idLangue! == "3" {
            let score = tabLead["scoreGerm"] as! String
            scores.text = score
            
        }else   {
            let score = tabLead["scoreEsp"] as! String
            scores.text = score
            
        }
        
        
        
        return cell
        
    }
    
    
}
