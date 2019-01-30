//
//  Type2QuestionViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 12/12/18.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire



class Type2QuestionViewController: UIViewController {
    
    //conterLabel
    
    var choix:Int = 0
    var Yes: Int = 0
    var lives : Int = 0
    var questions : NSArray = []
    
    
    @IBOutlet weak var conterLabel: UILabel!
    
    
    @IBOutlet var live1Label: UIImageViewX!
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var nbLivesLbL: UILabel!
    @IBOutlet weak var questionLabel: UILabelX!
    @IBOutlet weak var choix1Img: UIImageViewX!
    @IBOutlet weak var choix2Img: UIImageViewX!
    @IBOutlet weak var choix3Img: UIImageViewX!
    @IBOutlet weak var choix4Img: UIImageViewX!
    var idlevelx : String?
    var idlanguex : String?
    var IdQuestion : String = ""
    var Userdetails : NSArray = []
    var reponsedetails : NSArray = []
    var reponseVrai : String = ""
    var monScoreFrancais : Int = 0
    var monScoreAnglais : Int = 0
    var monScoreGerman : Int = 0
    var monScoreEspa  : Int = 0
    var monBonus : Int = 0
    var scoreFinal : Int = 0
    var LevelFinal : Int = 0
    var imgProp1 : String = ""
    var imgProp2 : String = ""
    var imgProp3 : String = ""
    var imgProp4 : String = ""
    var counter = 0
    var counterTime1 = Timer()
    var counterStartValue = 80
    var isOver = false
    static var Yes: Int = 0
    
    var urlPropositions = ViewController.Ip + "miniProjetWebService/selectProposition.php?level="
    var urlQuestion = ViewController.Ip + "miniProjetWebService/selectQuestion.php?level="
    var urlReponse = ViewController.Ip + "miniProjetWebService/selectReponsedeQuestion.php?level="
    var propsitiondetails : NSArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = counterStartValue
        self.conterLabel.text = "00:00"
        startCounter()
        print("counter in q 2 " ,counter)
        nbLivesLbL.text = String(ViewController.nbrOfLives)
        // lives = ViewController.nbrOfLives
        getUserData()
        
        print("view did load question type 2")
        
        
        urlQuestion += self.idlevelx!
        urlQuestion += "&langue="
        urlQuestion +=  self.idlanguex!
        urlQuestion += "&type=2"
        
        print(urlQuestion)
        
        
        
        Alamofire.request(self.urlQuestion).responseJSON{
            response in
            if response.result.value != nil
            {
                self.questions = response.result.value as! NSArray
                
                let table = self.questions[0] as! Dictionary<String,Any>
                
                let contenu = table["contenu"] as! String
                self.questionLabel.text = contenu
                let id = table["id"] as! String
                self.IdQuestion  = id
                print("this is alamo" ,self.IdQuestion)
                self.urlPropositions += self.idlevelx!
                self.urlPropositions += "&question="
                self.urlPropositions += self.IdQuestion
                self.urlPropositions += "&langue="
                self.urlPropositions += self.idlanguex!
                self.getPropositions()
                
                //get reponse
                
                self.urlReponse += self.idlevelx!
                self.urlReponse += "&question="
                self.urlReponse += self.IdQuestion
                self.urlReponse += "&idLangue="
                self.urlReponse += self.idlanguex!
                
                self.getReponse()
                print( "proposition correct view did load : ",Type2QuestionViewController.Yes)
            }
        }
        
        
        
        
        
        
        
    }
    
    
    func startCounter(){
        
        counterTime1 = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func decrementCounter()  {
        if !isOver {
            
            if self.counter <= 1{
                isOver = true
                //alert
                self.conterLabel.text = "00:00"
                counterTime1.invalidate()
            }
            self.counter -= 1
            //self.counterLabel.text = String(self.counter)
            
            let min = counter / 60
            let secs = counter % 60
            var secText = "\(secs)"
            var minText = "\(min)"
            
            
            if secs < 10 {
                secText = "0\(secs)"
            }
            if min < 10 {
                minText = "0\(min)"
            }
            self.conterLabel.text = "\(minText):\(secText)"
        }
    }
    
    func getPropositions()  {
        Alamofire.request(self.urlPropositions).responseJSON{
            response in
            print(self.urlPropositions)
            print("             ")
            print("             ")
            print("             ")
            print("             ")
            if response.result.value != nil
            {
                
                self.propsitiondetails = response.result.value as! NSArray
                //choix 1
                let table1 = self.propsitiondetails[0] as! Dictionary<String,Any>
                
                self.imgProp1 = table1["image"] as! String
                
                print("image url 1 ", self.imgProp1)
                self.choix1Img.af_setImage(withURL: URL(string:  self.imgProp1)!)
                
                //choix 2
                let table2 = self.propsitiondetails[1] as! Dictionary<String,Any>
                
                self.imgProp2 = table2["image"] as! String
                print("image url 2 ", self.imgProp2)
                self.choix2Img.af_setImage(withURL: URL(string:  self.imgProp2)!)
                
                
                //choix 3
                
                let table3 = self.propsitiondetails[2] as! Dictionary<String,Any>
                
                self.imgProp3 = table3["image"] as! String
                print("image url 3 ", self.imgProp3)
                self.choix3Img.af_setImage(withURL: URL(string:  self.imgProp3)!)
                
                //choix 4
                
                let table4 = self.propsitiondetails[3] as! Dictionary<String,Any>
                
                self.imgProp4 = table4["image"] as! String
                print("image url 4 ", self.imgProp4)
                self.choix4Img.af_setImage(withURL: URL(string:  self.imgProp4)!)
            }
        }
    }
    
    
    
    func getReponse()  {
        
        Alamofire.request(self.urlReponse).responseJSON{
            response in
            if response.result.value != nil {
                
                
                print(self.urlReponse)
                self.reponsedetails = response.result.value as! NSArray
                
                let table6 = self.reponsedetails[0] as! Dictionary<String,Any>
                
                let prop = table6["text"] as! String
                
                let Bonus = table6["bonus"] as! String
                self.monBonus = Int(Bonus)!
                print("affichage Bonus")
                print(self.monBonus)
                Type2QuestionViewController.Yes = Int(prop)!
                print("correct prop in function ????")
                print(Type2QuestionViewController.Yes)
                
            }
        }
        
    }
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let touch = touches.first {
            if touch.view == self.choix4Img { //image View property
                //img 1
                let red1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix1Img.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix2Img.borderColor = red2
                
                //img3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix3Img.borderColor = red3
                //img 4
                let red4 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix4Img.borderColor = red4
                //selected choice
                
                self.choix = 4
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
                
                
            }
            if touch.view == self.choix3Img { //image View property
                
                //img 1
                let red1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix1Img.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix2Img.borderColor = red2
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix4Img.borderColor = red4
                //img 3
                let red3 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix3Img.borderColor = red3
                //selected choice
                self.choix = 3
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
            }
            if touch.view == self.choix2Img { //image View property
                
                //img 1
                let red1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix1Img.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix2Img.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix3Img.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix4Img.borderColor = red4
                //selected choice
                
                self.choix = 2
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
            }
            
            if touch.view == self.choix1Img { //image View property
                
                //img 1
                let red1 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix1Img.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix2Img.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix3Img.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix4Img.borderColor = red4
                //selected choice
                self.choix = 1
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
            }
            
            
        }
    }
    
    //end of function touch image
    
    
    @IBAction func Validate(_ sender: Any) {
        
        print("index prop vrai ")
        print(  Type2QuestionViewController.Yes )
        
        
        print("validation ", Type2QuestionViewController.Yes)
        
        if (ViewController.nbrOfLives == 0)
        { print("you can not play you dont have lives")
            let alert = UIAlertController(title: "Sorry !!!", message: "Hey !!! you dont have Lives any more", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "toHome2", sender: IndexPath.self )
                
            } )
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert,animated: true,completion: nil)
            
        }
        else{
            
            if (!isOver){
                
                // he got more than 1 or just one [1..3]
                if self.choix ==   Type2QuestionViewController.Yes {
                    //implement reponse vrai
                    
                    counterTime1.invalidate()
                    
                    print("counteur stopped at : ")
                    print(self.conterLabel.text!)
                    
                    if self.idlanguex! == "1"
                    {
                        print("score : ", ProfileViewController.scoreFrancais)
                        
                        self.scoreFinal = self.monScoreFrancais + self.monBonus
                        self.LevelFinal = Int(idlevelx!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if self.idlanguex! == "2"
                    {
                        print("score " ,ProfileViewController.scoreAnglais)
                        
                        //update scoreUserAnglais
                        self.scoreFinal = self.monScoreAnglais + self.monBonus
                        self.LevelFinal = Int(idlevelx!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if self.idlanguex! == "3"
                        
                    {//update scoreUserGerman
                        
                        self.scoreFinal = self.monScoreGerman + self.monBonus
                        self.LevelFinal = Int(idlevelx!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                    }
                    if self.idlanguex! == "4"
                    {
                        //update scoreUserEspa
                        
                        self.scoreFinal = self.monScoreEspa + self.monBonus
                        self.LevelFinal = Int(idlevelx!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)
                        }
                        
                    }
                    ///message de félicitation
                    
                    let alert = UIAlertController(title: "Felicitations", message: "YOU SELECTED THE BEST RESPONSE ", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                        self.performSegue(withIdentifier: "ToQuestion4", sender: IndexPath.self )
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
                
                
                
                
                
            }else {
                
                print("timer is out ")
                let alert = UIAlertController(title: "Too Slow", message: "Timer is out", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                    
                } )
                
                
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)
            }
        }
    }
    
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
                
                self.nbLivesLbL.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if (ViewController.nbrOfLives == 1){
                self.nbLivesLbL.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if ViewController.nbrOfLives == 0 {
                self.nbLivesLbL.text = String(ViewController.nbrOfLives)
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
                    self.performSegue(withIdentifier: "toHome2", sender: IndexPath.self )
                    
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
        // self.nbLivesLbL.text = String(ViewController.nbrOfLives)
    }
    
    
    
    //prepare methode 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ToQuestion4"{
            
            
            if let destViewController : Question4ViewController = segue.destination as? Question4ViewController
            {
                
                destViewController.idlangue4 = idlanguex
                destViewController.idlevel4  = idlevelx
                
                
            }
        }
        
        
        
    }
    
    
    
    //getting user informations
    
    
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
                let scoreAnglais = table["scoreAng"] as! String
                self.monScoreAnglais = Int(scoreAnglais)!
                
                let scoreGerma = table["scoreGerm"] as! String
                self.monScoreGerman = Int(scoreGerma)!
                let scoreEsp = table["scoreEsp"] as! String
                self.monScoreEspa = Int(scoreEsp)!
                
                
                
                
                if self.idlanguex == "1"
                {
                    
                    self.scoreLabel.text = String(self.monScoreFrancais)
                }
                if self.idlanguex == "2"
                {
                    
                    self.scoreLabel.text = String(self.monScoreAnglais)
                    
                }
                if self.idlanguex == "3"
                {
                    
                    self.scoreLabel.text = String(self.monScoreGerman)
                }
                if self.idlanguex == "4"
                {
                    
                    self.scoreLabel.text = String(self.monScoreEspa)
                    
                }
                
                
            }
            
        }
        
    }
    
    
    
    
    
}
