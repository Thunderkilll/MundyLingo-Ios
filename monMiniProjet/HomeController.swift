//
//  TestClassViewController.swift
//  monMiniProjet
//
//  Created by Khaled&Raoudha on 04/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AlamofireImage
import Alamofire
class HomeController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    
    var levelPlayerFR = 6
    
    var levelPlayerAng = 6
    var levelPlayerESP = 6
    var levelPlayerGER = 6
    
    var url = ViewController.Ip + "miniProjetWebService/selectUser.php?email="
    var profile : NSArray = []
    
    let blockImage = ["block" , "block" , "block" , "block" ,"block" , "block" , "block"]
    
    @IBOutlet var collection1: UICollectionView!
    @IBOutlet var collection2: UICollectionView!
    @IBOutlet var collection3: UICollectionView!
    @IBOutlet var collection4: UICollectionView!
    
    
    
    var idLangue :String?
    var idLevel :String?
    
    
    @IBAction func deconnect(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()
        print("logout")
        fbLoginManager.logOut()
        // transition(Sender: log)
        // switchScreen()
        //performSegue(withIdentifier: "versHome", sender: nil)
        
        let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let loginPageNav = UINavigationController(rootViewController: loginPage)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginPageNav
    }
    /*@IBAction func déconnectionFaceBook(_ sender: Any) {
     let fbLoginManager = FBSDKLoginManager()
     print("logout")
     fbLoginManager.logOut()
     // transition(Sender: log)
     // switchScreen()
     //performSegue(withIdentifier: "versHome", sender: nil)
     
     let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
     let loginPageNav = UINavigationController(rootViewController: loginPage)
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     appDelegate.window?.rootViewController = loginPageNav
     }*/
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collection1 {
            return lvlTab.count
        }
        if collectionView == self.collection2 {
            return lvlTab.count
        }
        if collectionView == self.collection3 {
            return lvlTab.count
        }
        
        return lvlTab.count   }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // français
        if collectionView == self.collection1
        {
            let cellule = collectionView.dequeueReusableCell(withReuseIdentifier: "celu", for: indexPath)  as! MyFirstCollectionViewCell
            
            //si index path + 1 > level player block the biatch
            if(indexPath.row + 1 > levelPlayerFR)
            {
                cellule.monImage.image = UIImage(named: blockImage[indexPath.row])
            }else if (indexPath.row + 1 <=  levelPlayerFR)
            {
                cellule.monImage.image = UIImage(named: imgTab[indexPath.row])
            }
            cellule.monLevel.text = lvlTab[indexPath.row]
            return cellule
            
        }else
            if collectionView == self.collection2
            {//english
                let cellule2 = collectionView.dequeueReusableCell(withReuseIdentifier: "celu2", for: indexPath)  as! secondCollectionViewCell
                
                if(indexPath.row + 1 > levelPlayerAng)
                {
                    cellule2.img2.image = UIImage(named: blockImage[indexPath.row])
                }else if (indexPath.row + 1 <=  levelPlayerAng)
                {
                    cellule2.img2.image = UIImage(named: imgTab[indexPath.row])
                    
                }
                
                cellule2.lvl.text = lvlTab[indexPath.row]
                return cellule2
                
                
            }else
                if collectionView == self.collection3
                {//german
                    
                    let cellule3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)  as! therCollectionViewCell
                    
                    if(indexPath.row + 1 > levelPlayerGER)
                    {
                        cellule3.im3.image = UIImage(named: blockImage[indexPath.row])
                    }
                    else if (indexPath.row + 1 <= levelPlayerGER){
                        cellule3.im3.image = UIImage(named: imgTab[indexPath.row])
                    }
                    
                    
                    cellule3.lv3.text = lvlTab[indexPath.row]
                    return cellule3
                    
        }
        //spanish
        let cellule4 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath)  as! forthCollectionViewCell
        
        if(indexPath.row + 1 > levelPlayerESP)
        {
            cellule4.im4.image = UIImage(named: blockImage[indexPath.row])
            
        } else if(indexPath.row + 1 <= levelPlayerESP)
        {
            cellule4.im4.image = UIImage(named: imgTab[indexPath.row])
        }
        
        cellule4.lvl4.text = lvlTab[indexPath.row]
        return cellule4
        
        
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //  let cell = collectionView.cellForItem(at: indexPath) as! MyFirstCollectionViewCell
        //let cell2 = collectionView.cellForItem(at: indexPath) as! secondCollectionViewCell
        
        if collectionView == self.collection1
        {idLangue = "1"
            idLevel = lvlTab[indexPath.item]
            print("mon level player fran ", levelPlayerFR)
            if(indexPath.row + 1 > levelPlayerFR){
                
                let index = indexPath.row + 1
                let alert = UIAlertController(title: "Sorry", message: "level bigger than your actual level " +   String(index) + "your level is " + String(levelPlayerFR), preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
                
            }else if(indexPath.row + 1 <= levelPlayerFR){
                
                print("go ahead " , levelPlayerFR)
                performSegue(withIdentifier: "toDetails", sender: self)
                idLangue = "1"
            }
            
            
            
            
        } else
            if collectionView == self.collection2
            {
                
                idLangue = "2"
                
                print(indexPath.row + 1 )
                idLevel = lvlTab[indexPath.item]
                if(indexPath.row + 1 > levelPlayerAng){
                    let index = indexPath.row + 1
                    let alert = UIAlertController(title: "Sorry", message: "level bigger than your actual level " +   String(index) + "your level is " + String(levelPlayerAng), preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                    
                }else{
                    print("You can pass your level is " ,levelPlayerAng )
                    performSegue(withIdentifier: "toDetails", sender: self)
                    idLangue = "2"
                }
                
                
                
                
                
            } else
                if collectionView == self.collection3
                {
                    idLangue = "3"
                    
                    idLevel = lvlTab[indexPath.item]
                    
                    if(indexPath.item + 1 > levelPlayerGER){
                        let index = indexPath.row + 1
                        let alert = UIAlertController(title: "Sorry", message: "level bigger than your actual level " +   String(index) + "your level is " + String(levelPlayerGER), preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert,animated: true,completion: nil)
                    }else{
                        print("You can pass your level is " ,levelPlayerGER )
                        performSegue(withIdentifier: "toDetails", sender: self)
                        idLangue = "3"
                    }
                    
                    
                    
                }
                else{
                    idLangue = "4"
                    idLevel = lvlTab[indexPath.item]
                    
                    if(indexPath.row + 1 > levelPlayerESP){
                        let index = indexPath.row + 1
                        let alert = UIAlertController(title: "Sorry", message: "level bigger than your actual level " +   String(index) + "your level is " + String(levelPlayerESP), preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert,animated: true,completion: nil)
                    }else{
                        print("You can pass your level is " ,levelPlayerESP )
                        performSegue(withIdentifier: "toDetails", sender: self)
                        idLangue = "4"
                    }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetails"{
            
            
            if let destViewController : DetailsViewController = segue.destination as? DetailsViewController
            {
                //    destViewController.labelText = "test"  //**** this works
                destViewController.idlang = idLangue
                destViewController.idlev = idLevel
                
                
            }
        }else if segue.identifier == "shared"{
            //do something
            
            
        }
        
    }
    
    
    
    
    let lvlTab = ["1", "2" ,"3","4","5","6","7"]
    
    let imgTab = ["star1" , "star1" ,"star1","star1","star1","star1","star1"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hey it is view Didload")
        let email = ViewController.monEmail
        self.url += email
        print("mon url est *****",url)
        Alamofire.request(self.url).responseJSON{
            response in
            if response.result.value != nil
            {
                self.profile = response.result.value as! NSArray
                
                let table = self.profile[0] as! Dictionary<String,Any>
                
                
                let levelFr = table["levelFr"] as! String
                print("level francaisssssssssssssss",levelFr)
                let x = Int(levelFr)
                self.levelPlayerFR = x!
                print(x!)
                let levelEn = table["levelAng"] as! String
                let y = Int(levelEn)
                self.levelPlayerAng = y!
                print(y!)
                let levelEsp = table["levelEsp"] as! String
                let z = Int(levelEsp)
                self.levelPlayerESP = z!
                print(z!)
                let levelGer = table["levelGer"] as! String
                let w = Int(levelGer)
                self.levelPlayerGER = w!
                print(w!)
                
            }
            self.collection1.reloadData()
            self.collection2.reloadData()
            self.collection3.reloadData()
            self.collection4.reloadData()
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}


