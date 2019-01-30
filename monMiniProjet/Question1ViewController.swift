//
//  Question1ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 05/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Question1ViewController: UIViewController {
    
    
    @IBOutlet var LabelNbrOfLives: UILabel!
    
    @IBOutlet var monScoreICI: UILabel!
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet weak var prop2: UILabel!
    @IBOutlet weak var prop3: UILabel!
    @IBOutlet weak var prop4: UILabel!
    @IBOutlet weak var prop1: UILabel!
    @IBOutlet weak var MonQuestion: UILabel!
    @IBOutlet weak var SW1: UISwitch!
    @IBOutlet weak var SW2: UISwitch!
    @IBOutlet weak var SW3: UISwitch!
    @IBOutlet weak var SW4: UISwitch!
    
    static var counteurT = ""
    var type :String = "0"
    var IdQuestion : String = ""
    var url =  ViewController.Ip + "miniProjetWebService/selectQuestion.php?level="
    var url2 = ViewController.Ip + "miniProjetWebService/selectProposition.php?level="
    var url3 = ViewController.Ip + "miniProjetWebService/selectReponsedeQuestion.php?level="
    var url4 = ViewController.Ip + "miniProjetWebService/updateUser.php"
    var url5 = ViewController.Ip + "miniProjetWebService/updateUserAng.php"
    var url6 = ViewController.Ip + "miniProjetWebService/updateUserEsp.php"
    var url7 = ViewController.Ip + "miniProjetWebService/updateUserGerm.php"
    var url8 = ViewController.Ip + "miniProjetWebService/selectUser.php?email="
    var numPropo :String?
    var courdetails : NSArray = []
    var propsitiondetails : NSArray = []
    var reponsedetails : NSArray = []
    var Userdetails : NSArray = []
    var reponseVrai : String = ""
    var propo1 : String = ""
    var propo2 : String = ""
    var propo3 : String = ""
    var propo4 : String = ""
    var monScoreFrancais : Int = 0
    var monScoreAnglais : Int = 0
    var monScoreGerman : Int = 0
    var monScoreEspa  : Int = 0
    var monBonus : Int = 0
    var scoreFinal : Int = 0
    var LevelFinal : Int = 0
    var lvlId3 : String?
    var id_cour3 : String?
    var id_langue3: String?
    var counter = 0
    var counterTime = Timer()
    var counterStartValue = 30
    var isOver = false
    
    
    
    
    @IBAction func action1(_ sender: UISwitch) {
        if(sender.isOn == true )
        {
            print("action1")
            SW2.setOn(false, animated: false)
            SW3.setOn(false, animated: false)
            SW4.setOn(false, animated: false)
            
            
        }
    }
    
    @IBAction func action2(_ sender: UISwitch) {
        if(sender.isOn == true )
        {  print("action2")
            
            SW1.setOn(false, animated: false)
            SW3.setOn(false, animated: false)
            SW4.setOn(false, animated: false)
            
            
        }
    }
    
    
    @IBAction func action3(_ sender: UISwitch) {
        if(sender.isOn == true )
        {print("action3")
            SW1.setOn(false, animated: false)
            SW2.setOn(false, animated: false)
            SW4.setOn(false, animated: false)
            
        }
    }
    
    
    @IBAction func action4(_ sender: UISwitch) {
        if(sender.isOn == true )
        {print("action4")
            SW1.setOn(false, animated: false)
            SW2.setOn(false, animated: false)
            SW3.setOn(false, animated: false)
            
        }
        
    }
    
    
    
    
    
    
    @IBAction func validate(_ sender: Any) {
        
        if (ViewController.nbrOfLives == 0)
        { print("you can not play you dont have lives")
            let alert = UIAlertController(title: "Sorry !!!", message: "Hey !!! you dont have Lives any more", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "ToHome", sender: IndexPath.self )
                
            } )
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert,animated: true,completion: nil)
            
        }
        else
        {//nbr de vie != 0
            
            
            if (!isOver){
                
                
                
                ///premier choix du proposition is clicked
                if (SW1.isOn == true)
                { if (propo1 == reponseVrai )
                {
                    counterTime.invalidate()
                    Question1ViewController.counteurT = self.counterLabel.text!
                    print("counteur stopped at : ")
                    print( Question1ViewController.counteurT)
                    
                    
                    if id_langue3 == "1"
                    {
                        //update scoreUserFrancais
                        print("score : ", ProfileViewController.scoreFrancais)
                        monScoreICI.text = ProfileViewController.scoreFrancais
                        
                        self.scoreFinal = self.monScoreFrancais + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "2"
                    {
                        print("score " ,ProfileViewController.scoreAnglais)
                        monScoreICI.text = ProfileViewController.scoreAnglais
                        //update scoreUserAnglais
                        self.scoreFinal = self.monScoreAnglais + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "3"
                        
                    {//update scoreUserGerman
                        monScoreICI.text = ProfileViewController.scoreGerman
                        self.scoreFinal = self.monScoreGerman + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "4"
                    {
                        //update scoreUserEspa
                        monScoreICI.text = ProfileViewController.scoreEspagno
                        self.scoreFinal = self.monScoreEspa + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        //  performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    ///message de félicitation
                    let alert = UIAlertController(title: "Felicitations", message: "YOU SELECTED THE BEST RESPONSE ", preferredStyle: .alert)
             
                   
                    let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                        self.performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        
                    } )
                    
                    
                    alert.addAction(action)
                    
                    self.present(alert,animated: true,completion: nil)
                    
                    
                }
                else
                {
                    ////ici code si propsition pas vrai
                    ///message de félicitation
                    let alert = UIAlertController(title: "Oups!!", message: "Try again !!!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert,animated: true,completion: nil)
                    SenarioFaux()
                    }
                }
                if (SW2.isOn == true)
                { if (propo2 == reponseVrai )
                {
                    
                    
                    counterTime.invalidate()
                    Question1ViewController.counteurT = self.counterLabel.text!
                    print("counteur stopped at : ")
                    print( Question1ViewController.counteurT)
                    
                    
                    
                    if id_langue3 == "1"
                    {
                        
                        //update scoreUserFrancais
                        
                        self.scoreFinal = self.monScoreFrancais + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        //performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "2"
                    {
                        //update scoreUserAnglais
                        self.scoreFinal = self.monScoreAnglais + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        //  performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "3"
                        
                    { //update scoreUserGerman
                        self.scoreFinal = self.monScoreGerman + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        //performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "4"
                    {
                        //update scoreUserEspa
                        self.scoreFinal = self.monScoreEspa + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        //  performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    
                    ///message de félicitation
                    let alert = UIAlertController(title: "Felicitations", message: "Good you've done it well done !!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                        self.performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        
                    } )
                    
                    
                    
                    alert.addAction(action)
                    
                    self.present(alert,animated: true,completion: nil)
                    
                }else {
                    ///code si reponse pas vrais
                    let alert = UIAlertController(title: "Oups!!", message: "Try again !!!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert,animated: true,completion: nil)
                    SenarioFaux()
                    }
                    
                }
                if (SW3.isOn == true)
                {if (propo3 == reponseVrai )
                {
                    
                    
                    counterTime.invalidate()
                    Question1ViewController.counteurT = self.counterLabel.text!
                    print("counteur stopped at : ")
                    print( Question1ViewController.counteurT)
                    
                    
                    if id_langue3 == "1"
                    {
                        //update scoreUserFrancais
                        
                        self.scoreFinal = self.monScoreFrancais + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "2"
                    {
                        //update scoreUserAnglais
                        self.scoreFinal = self.monScoreAnglais + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        //performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "3"
                        
                    {//update scoreUserGerman
                        self.scoreFinal = self.monScoreGerman + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if id_langue3 == "4"
                    {
                        //update scoreUserEspa
                        self.scoreFinal = self.monScoreEspa + self.monBonus
                        self.LevelFinal = Int(lvlId3!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    ///message de félicitation
                    let alert = UIAlertController(title: "Felicitations ", message: "Good you've done it well done !!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                        self.performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        
                    } )
                    
                    
                    alert.addAction(action)
                    
                    self.present(alert,animated: true,completion: nil)
                }else {
                    let alert = UIAlertController(title: "Oups!!", message: "Try again !!!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: nil)
                    
                    alert.addAction(action)
                    
                    self.present(alert,animated: true,completion: nil)
                    SenarioFaux()
                    }
                }
                if (SW4.isOn == true)
                {
                    
                    
                    
                    
                    if (propo4 == reponseVrai )
                    {
                        
                        counterTime.invalidate()
                        Question1ViewController.counteurT = self.counterLabel.text!
                        print("counteur stopped at : ")
                        print( Question1ViewController.counteurT)
                        
                        if id_langue3 == "1"
                        {
                            //update scoreUserFrancais
                            
                            self.scoreFinal = self.monScoreFrancais + self.monBonus
                            self.LevelFinal = Int(lvlId3!)!
                            let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                                print(repsonse)}
                            
                            //  performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        }
                        if id_langue3 == "2"
                        {
                            //update scoreUserAnglais
                            self.scoreFinal = self.monScoreAnglais + self.monBonus
                            self.LevelFinal = Int(lvlId3!)!
                            let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                                print(repsonse)}
                            
                            // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        }
                        if id_langue3 == "3"
                            
                        {//update scoreUserGerman
                            self.scoreFinal = self.monScoreGerman + self.monBonus
                            self.LevelFinal = Int(lvlId3!)!
                            
                            let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                                print(repsonse)}
                            
                            //performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        }
                        if id_langue3 == "4"
                        {
                            //update scoreUserEspa
                            self.scoreFinal = self.monScoreEspa + self.monBonus
                            self.LevelFinal = Int(lvlId3!)!
                            
                            let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                                print(repsonse)}
                            
                            // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                        }
                        ///message de félicitation
                        let alert = UIAlertController(title: "Felicitations", message: "Good you've done it well done !!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                            self.performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                            
                        } )
                        
                        
                        
                        alert.addAction(action)
                        
                        self.present(alert,animated: true,completion: nil)
                    }else {
                        ///code si reponse pas vrais
                        let alert = UIAlertController(title: "Oups!!", message: "Try again !!!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "ok", style: .default , handler: nil)
                        
                        alert.addAction(action)
                        
                        self.present(alert,animated: true,completion: nil)
                        SenarioFaux()
                    }
                }
                
            }else {
                print("   ")
                print("   ")
                print("timer is out ")
                let alert = UIAlertController(title: "Too Slow", message: "Timer is out", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                    
                } )
                
                
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)
            }}
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///initialisation du code
        
        
        counter = counterStartValue
        counterLabel.text = "00:00"
        
        getUserData()
        updateData ()
        startCounter()
        
        
        
        
        LabelNbrOfLives.text = String(ViewController.nbrOfLives)
        
        
        url += lvlId3 ?? ""
        url += "&langue="
        url += id_langue3!
        url += "&type="
        url += type
        print(url)
        Alamofire.request(url).responseJSON{
            response in
            
            // print(response.result.value)
            if response.result.value != nil
            {
                self.courdetails = response.result.value as! NSArray
                
                let table = self.courdetails[0] as! Dictionary<String,Any>
                
                let contenu = table["contenu"] as! String
                
                let id = table["id"] as! String
                self.IdQuestion  = id
                print("this is alamo" ,self.IdQuestion)
                
                //  let level = table["level"] as! String
                // let image = table["image"] as! String
                // let vocal = table["vocal"] as! String
                //  let reponse = table["reponse"] as! String
                //let questionTest = table["questionTest"] as! String
                //print(questionTest)
                // let langue = table["langue"] as! String
                // print(langue)
                
                self.MonQuestion.text = contenu
                
                
                //remlpir url 2
                
                
                
                self.url2 += self.lvlId3 ?? ""
                self.url2 += "&question="
                self.url2 += self.IdQuestion
                self.url2 += "&langue="
                self.url2 +=  self.id_langue3 ?? ""
                
                print(self.url2)
                
                Alamofire.request(self.url2).responseJSON{
                    response in
                    
                    // print(response2.result.value)
                    if response.result.value != nil
                    {
                        print(response.result.value as Any)
                        
                        self.propsitiondetails = response.result.value as! NSArray
                        
                        let table2 = self.propsitiondetails[0] as! Dictionary<String,Any>
                        
                        let contenu2 = table2["contenu"] as! String
                        
                        //let image2 = table2["image"] as! String
                        //let vocal2 = table2["vocal"] as! String
                        //let reponse2 = table2["reponse"] as! String
                        
                        self.prop1.text = contenu2
                        self.propo1 = contenu2
                        let table3 = self.propsitiondetails[1] as! Dictionary<String,Any>
                        
                        let contenu3 = table3["contenu"] as! String
                        self.prop2.text = contenu3
                        self.propo2 = contenu3
                        
                        
                        let table4 = self.propsitiondetails[2] as! Dictionary<String,Any>
                        
                        let contenu4 = table4["contenu"] as! String
                        self.prop3.text = contenu4
                        self.propo3 = contenu4
                        
                        
                        let table5 = self.propsitiondetails[3] as! Dictionary<String,Any>
                        
                        let contenu5 = table5["contenu"] as! String
                        self.prop4.text = contenu5
                        self.propo4 = contenu5
                        
                        
                    }
                    
                }
                
                self.url3 += self.lvlId3 ?? ""
                self.url3 += "&question="
                self.url3 += self.IdQuestion
                self.url3 += "&idLangue="
                self.url3 +=  self.id_langue3 ?? ""
                //  print(self.url3)
                
                Alamofire.request(self.url3).responseJSON{
                    response in
                    
                    
                    if response.result.value != nil
                    {
                        print(response.result.value as Any)
                        
                        self.reponsedetails = response.result.value as! NSArray
                        
                        let table6 = self.reponsedetails[0] as! Dictionary<String,Any>
                        
                        let contenu6 = table6["text"] as! String
                        let Bonus = table6["bonus"] as! String
                        self.monBonus = Int(Bonus)!
                        print("affichage Bonus")
                        print(self.monBonus)
                        self.reponseVrai = contenu6
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
                
            }
            
        }
        
        
        
        
        
        
        
    }
    
    func updateData () {
        if id_langue3 == "1"
        {
            //update scoreUserFrancais
            
            self.scoreFinal = self.monScoreFrancais + self.monBonus
            self.LevelFinal = Int(lvlId3!)!
            let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
            
            //  performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
        }
        if id_langue3 == "2"
        {
            //update scoreUserAnglais
            self.scoreFinal = self.monScoreAnglais + self.monBonus
            self.LevelFinal = Int(lvlId3!)!
            let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
            
            // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
        }
        if id_langue3 == "3"
            
        {//update scoreUserGerman
            self.scoreFinal = self.monScoreGerman + self.monBonus
            self.LevelFinal = Int(lvlId3!)!
            
            let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
            
            //performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
        }
        if id_langue3 == "4"
        {
            //update scoreUserEspa
            self.scoreFinal = self.monScoreEspa + self.monBonus
            self.LevelFinal = Int(lvlId3!)!
            
            let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
            
            // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
        }
        
    }
    
    //counteur
    
    func startCounter(){
        
        counterTime = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func decrementCounter()  {
        if !isOver {
            
            if self.counter <= 1{
                isOver = true
                //alert
                self.counterLabel.text = "00:00"
                counterTime.invalidate()
            }
            self.counter -= 1
            //self.counterLabel.text = String(self.counter)
            
            let min = counter / 60
            let secs = counter % 60
            var secText = "\(secs)"
            var minText = "\(min)"
            print(secText)
            
            if secs < 10 {
                secText = "0\(secs)"
            }
            if min < 10 {
                minText = "0\(min)"
            }
            self.counterLabel.text = "\(minText):\(secText)"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "versQuestio2"{
            
            
            if let destViewController : Type2QuestionViewController = segue.destination as? Type2QuestionViewController
            {
                //    destViewController.labelText = "test"  //**** this works
                destViewController.idlanguex = id_langue3
                destViewController.idlevelx  = lvlId3
                
                
            }
        }
    }
    
    
    
    
    
    
    /*********/
    func SenarioFaux ( )
    {
        print("nombre de vies siario faux avant ",ViewController.nbrOfLives)
        
        
        if (ViewController.nbrOfLives < 0 )
        {
            ViewController.nbrOfLives = 0
            
        }
        else  {
            ViewController.nbrOfLives -= 1
            //self.live1Img.image = UIImage(named: "heart_empty")
            
            
            print("Wrong try again ")
            print(ViewController.nbrOfLives)
            if (ViewController.nbrOfLives == 2){
                print("nombre de vies siario faux aprs 1 faute",ViewController.nbrOfLives)
                
                self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if (ViewController.nbrOfLives == 1){
                self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if ViewController.nbrOfLives == 0 {
                self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                ///senario kol sa3a bech tetzad 1 vie
                
                print("You are out of lives try to get  help from friend")
                print("go next question or restart level")
                
                let alert = UIAlertController(title: "Wrong 3 times ", message: "You don't have more lives please go back and read the course so you can answer better ", preferredStyle: .alert)
                
                
                //   let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    print("senario livessss ok to home")
                    self.SenarioLives()
                    NSLog("OK Pressed")
                    //redirection
                    /*   let SB = UIStoryboard(name: "Main", bundle: nil)
                     let vc = SB.instantiateViewController(withIdentifier: "CourStoryBoard")
                     self.present(vc,animated: true,completion: nil)*/
                    self.performSegue(withIdentifier: "ToHome", sender: IndexPath.self )
                    
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    print("senario livessss cancel")
                    self.SenarioLives()
                    NSLog("Cancel Pressed")
                    
                }
                
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                self.present(alert,animated: true,completion: nil)
                
                
                
            }
            
        }}
    func SenarioLives(){
        
        if(ViewController.nbrOfLives > 3)
        { ViewController.nbrOfLives = 3 }
        
        if (ViewController.nbrOfLives < 3 ) {
            
            
            if ( ViewController.nbrOfLives == 0)
            {
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3600)
                {
                    ViewController.nbrOfLives += 1
                    print("ajout du 1 er vie",ViewController.nbrOfLives)
                    //  self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                }
            }
            if ( ViewController.nbrOfLives == 1)
            {
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3600)
                {
                    ViewController.nbrOfLives += 1
                    print("ajout du 2 nd vie",ViewController.nbrOfLives)
                    //  self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                }
            }
            if ( ViewController.nbrOfLives == 2)
            {
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3600)
                {
                    ViewController.nbrOfLives += 1
                    print("ajout du 3 rd vie",ViewController.nbrOfLives)
                    //   self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                }
            }
        }
        self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
    }
    
    
    
    
    func getUserData()  {
        //this function will return user info from database because i can't wait the user untill he go to check ihis profile first sio we can store the informations
        var url = ViewController.Ip + "miniProjetWebService/selectUser.php?email="
        url += ViewController.monEmail
        
        
        Alamofire.request(url).responseJSON{
            response in
            
            
            if response.result.value != nil
            {
                print(response.result.value as Any)
                self.Userdetails = response.result.value as! NSArray
                
                let table = self.Userdetails[0] as! Dictionary<String,Any>
                
                
                let scoreFrancais = table["scoreF"] as! String
                self.monScoreFrancais = Int(scoreFrancais)!
                self.monScoreFrancais = 0
                let scoreAnglais = table["scoreAng"] as! String
                self.monScoreAnglais = Int(scoreAnglais)!
                self.monScoreAnglais = 0
                let scoreGerma = table["scoreGerm"] as! String
                self.monScoreGerman = Int(scoreGerma)!
                self.monScoreGerman = 0
                let scoreEsp = table["scoreEsp"] as! String
                self.monScoreEspa = Int(scoreEsp)!
                self.monScoreEspa = 0
                
                if self.id_langue3 == "1"
                {
                    
                    self.monScoreICI.text = String(self.monScoreFrancais)
                }
                if self.id_langue3 == "2"
                {
                    
                    self.monScoreICI.text = String(self.monScoreAnglais)
                    
                }
                if self.id_langue3 == "3"
                {
                    
                    self.monScoreICI.text = String(self.monScoreGerman)
                }
                if self.id_langue3 == "4"
                {
                    
                    self.monScoreICI.text = String(self.monScoreEspa)
                    
                }
                
                
            }
            
        }
        
    }
    
}

