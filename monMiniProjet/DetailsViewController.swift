//
//  DetailsViewController.swift
//  ListeCollectionKG
//
//  Created by ESPRIT on 11/14/18.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var GOCours: UIButtonX!
    @IBOutlet weak var lb_preq: UITextView!
    
    @IBOutlet weak var lbDiff: UILabel!
    
    @IBOutlet weak var lbNBQ: UILabel!
    
    @IBOutlet weak var LevelIdUI: UILabel!
    var url = ViewController.Ip + "miniProjetWebService/selectDetailLevel.php?NumLVL="
    var leveldetails : NSArray = []
    var difficulty: String?
    var lvlID : Int = 0
    var diff: String = ""
    var nbQuestion : String = ""
    var idPreq : String = ""
    var idCours : String = ""
    
    var idlang  : String?
    var idlev : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LevelIdUI.text = idlev!
        //    connection a notre alamofire
        print(lvlID)
        url += idlev ?? "1"
        url += "&langue="
        url += idlang ?? "1"
        print("my url detail " , url)
        
        Alamofire.request(url).responseJSON{
            response in
            
            if response.result.value != nil
            {
                self.leveldetails = response.result.value as! NSArray
                
                let table = self.leveldetails[0] as! Dictionary<String,Any>
                
                self.diff = table["diffeculte"] as! String
                self.idPreq = table["Prerequis"] as! String
                self.nbQuestion = table["nbrQuestion"] as! String
                self.idCours = table["idCour"] as! String
                self.idlang = table["langue"] as? String
                
                self.lbDiff.text = self.diff
                self.lbNBQ.text  = self.nbQuestion
                self.lb_preq.text = self.idPreq
                
                
                
            }
            
        }
        
        
        
    }
    
    
    
    @IBAction func SendInfo(_ sender: Any) {
        performSegue(withIdentifier: "courSegue", sender: IndexPath.self )
    }
    
    @IBAction func ToLeaderBoard(_ sender: Any) {
        performSegue(withIdentifier: "toLeaderboard", sender: IndexPath.self )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "courSegue"{
            
            
            let destination_viewcontroller = segue.destination as? Cours1ViewController
            
            destination_viewcontroller?.lvlId = self.idlev
            destination_viewcontroller?.id_cour = self.idCours
            destination_viewcontroller?.id_langue = self.idlang
        }
        
        if segue.identifier == "toLeaderboard"{
            let destination_viewcontroller = segue.destination as? DashboardViewController
            
            destination_viewcontroller?.idLevel = self.idlev
            destination_viewcontroller?.idLangue = self.idlang
            
        }
        
    }
    
}
