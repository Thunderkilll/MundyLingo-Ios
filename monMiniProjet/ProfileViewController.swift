//
//  ProfileViewController.swift
//  monMiniProjet
//
//  Created by Khaled&Raoudha on 18/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class ProfileViewController: UIViewController {
    
    @IBOutlet var LScoreEn: UILabelX!
    @IBOutlet var LScoreGerm: UILabelX!
    
    @IBOutlet var LScoreEsp: UILabelX!
    @IBOutlet var LScoreFr: UILabelX!
    @IBOutlet var usernameLabel: UILabelX!
    @IBOutlet var img: UIImageViewX!
    
    
    var url = ViewController.Ip + "miniProjetWebService/selectUser.php?email="
    var profile : NSArray = []
    static var scoreFrancais = ""
    static var scoreAnglais = ""
    static var scoreEspagno = ""
    static var scoreGerman = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // round image
        img.layer.cornerRadius = img.frame.size.width / 3;
        img.clipsToBounds = true;
        let email = ViewController.monEmail
        
        
        print("my email " , email)
        self.url += email
        Alamofire.request(self.url).responseJSON{
            response in
            if response.result.value != nil
            {
                self.profile = response.result.value as! NSArray
                
                let table = self.profile[0] as! Dictionary<String,Any>
                let image1 = table["image"] as! String
                print ( image1)
                let scoreFr = table["scoreF"] as! String
                ProfileViewController.scoreFrancais = scoreFr
                let scoreEn = table["scoreAng"] as! String
                ProfileViewController.scoreAnglais = scoreEn
                let scoreEsp = table["scoreEsp"] as! String
                ProfileViewController.scoreEspagno = scoreEsp
                let scoreGer = table["scoreGerm"] as! String
                ProfileViewController.scoreGerman = scoreGer
                /*
                 let levelFr = table["levelFr"] as! String
                 //  ProfileViewController.levelFrancais = levelFr
                 // print("level francais",ProfileViewController.levelFrancais)
                 let levelEn = table["levelAng"] as! String
                 //ProfileViewController.levelAnglais = levelEn
                 let levelEsp = table["levelEsp"] as! String
                 //ProfileViewController.levelEspagno = levelEsp
                 let levelGer = table["levelGer"] as! String
                 //  ProfileViewController.levelGerman = levelGer
                 // print("level Gremaaaaa",ProfileViewController.levelGerman)
                 */
                
                //remplir
                
                self.LScoreEn.text = scoreEn
                self.LScoreFr.text = scoreFr
                self.LScoreEsp.text = scoreEsp
                self.LScoreGerm.text = scoreGer
                
                self.usernameLabel.text = email
                self.img.af_setImage(withURL: URL(string: image1)!)
            }
            
        }
    }
    
    
    
    
    
    
    
    
}
