//
//  Question4ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 20/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation

class Question4ViewController: UIViewController {
var player : AVPlayer?
var questions : NSArray = []
    var idlevel4 : String?
    var idlangue4 : String?
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
    
    var counter = 0
    var counterTime1 = Timer()
    var counterStartValue = 80
    var isOver = false
     static var Yes: Int = 0
   static var verif : Int = 0
    var URLproposition1 : String = ""
     var URLproposition2 : String = ""
     var URLproposition3 : String = ""
     var URLproposition4 : String = ""
    var urlPropositions = ViewController.Ip + "miniProjetWebService/selectProposition.php?level="
    var urlQuestion = ViewController.Ip + "miniProjetWebService/selectQuestion.php?level="
    var urlReponse = ViewController.Ip + "miniProjetWebService/selectReponsedeQuestion.php?level="
    var propsitiondetails : NSArray = []
    
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var MyCoumpteur: UILabelX!
    
    @IBOutlet weak var myLives: UILabelX!
    @IBOutlet weak var textQuestionLabel: UILabelX!
    
    @IBOutlet weak var ImageQuestionLabel: UIImageViewX!
    
    
    @IBOutlet weak var Voix3Label: UIButtonX!
    @IBOutlet weak var Voix1Label: UIButtonX!
    
    @IBOutlet weak var Voix4Label: UIButtonX!
    @IBOutlet weak var Voix2Label: UIButtonX!
    

    @IBAction func Voix1Action(_ sender: Any) {
        print("touche1    selectionee")
        Question4ViewController.verif = 1
        print(Question4ViewController.verif)
        player?.pause()
       loadRadio(radioURL: self.URLproposition1)
        print(self.URLproposition1)

    }
    
    @IBAction func Voix2Action(_ sender: Any) {
         print("touche2    selectionee")
        Question4ViewController.verif = 2
        print(Question4ViewController.verif)
         player?.pause()
        loadRadio(radioURL: self.URLproposition2)
        print(self.URLproposition2)
    }
    
    @IBAction func Voix3Action(_ sender: Any) {
         print("touche 3  selectionee")
        Question4ViewController.verif = 3
        print(Question4ViewController.verif)
        player?.pause()
        loadRadio(radioURL: self.URLproposition3)
    }
    
    @IBAction func Voix4Action(_ sender: Any) {
         print("touche 4  selectionee")
        Question4ViewController.verif = 4
        print(Question4ViewController.verif)
        player?.pause()
        loadRadio(radioURL: self.URLproposition4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = counterStartValue
        self.MyCoumpteur.text = "00:00"
        startCounter()
        print("counter in q 2 " ,counter)
        self.myLives.text = String(ViewController.nbrOfLives)
       // lives = ViewController.nbrOfLives
        getUserData()
        urlQuestion += self.idlevel4!
        urlQuestion += "&langue="
        urlQuestion +=  self.idlangue4!
        urlQuestion += "&type=4"
        
        print(urlQuestion)
        
        Alamofire.request(self.urlQuestion).responseJSON{
            response in
//            print(response.result.value!)
            if response.result.value != nil
            {
                self.questions = response.result.value as! NSArray
                
                let table = self.questions[0] as! Dictionary<String,Any>
                
                let contenu = table["contenu"] as! String
                print( " ***mon quqestion** ", contenu)
               self.textQuestionLabel.text = contenu
                let id = table["id"] as! String
                self.IdQuestion  = id
                let imageQuestionn = table["image"] as! String
                print("image url de question ", imageQuestionn)
                self.ImageQuestionLabel.af_setImage(withURL: URL(string:  imageQuestionn)!)
                
                print("this is alamo proposition" ,self.IdQuestion)
                self.urlPropositions += self.idlevel4!
                self.urlPropositions += "&question="
                self.urlPropositions += self.IdQuestion
                self.urlPropositions += "&langue="
                self.urlPropositions += self.idlangue4!
                self.getPropositions()
                
                //get reponse
                
                self.urlReponse += self.idlevel4!
                self.urlReponse += "&question="
                self.urlReponse += self.IdQuestion
                self.urlReponse += "&idLangue="
                self.urlReponse += self.idlangue4!
                
                self.getReponse()
        
               // print( "proposition correct view did load : ",Type2QuestionViewController.Yes)
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
               self.MyCoumpteur.text = "00:00"
                counterTime1.invalidate()
            }
            self.counter -= 1
            self.MyCoumpteur.text = String(self.counter)
            
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
        self.MyCoumpteur.text = "\(minText):\(secText)"
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
                
               self.URLproposition1 = table1["voix"] as! String
                
            print("voix url 1 ", self.URLproposition1)
            
                
                //choix 2
                let table2 = self.propsitiondetails[1] as! Dictionary<String,Any>
                
                  self.URLproposition2 = table2["voix"] as! String
                
                 print("voix url 2 ", self.URLproposition2)
                
                
                //choix 3
                
                let table3 = self.propsitiondetails[2] as! Dictionary<String,Any>
                
                  self.URLproposition3 = table3["voix"] as! String
                
                  print("voix url 3 ", self.URLproposition3)
                
                //choix 4
                
                let table4 = self.propsitiondetails[3] as! Dictionary<String,Any>
                
                self.URLproposition4 = table4["voix"] as! String
                
              print("voix url 4 ", self.URLproposition4)
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
                Question4ViewController.Yes = Int(prop)!
                print("correct prop in function ????")
                print(Question4ViewController.Yes)
                
            }
        }
    }
        
        

    
    
    func loadRadio(radioURL: String)  {
        guard let url = URL.init(string: radioURL) else { print ("NO  No No !!!")
            return
        }
         let playerItem = AVPlayerItem(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    
       
        
       
    }

    @IBAction func Valider(_ sender: Any) {
        
        
        player?.pause()
        print("verif ==",Question4ViewController.verif)
           print("bonne reponse ==",Question4ViewController.Yes)
        
        if (ViewController.nbrOfLives == 0)
        { print("you can not play you dont have lives")
            let alert = UIAlertController(title: "Sorry !!!", message: "Hey !!! you dont have Lives any more", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "toHome3", sender: IndexPath.self )
                
            } )
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert,animated: true,completion: nil)
            
        }else {
            ///nbr de vie != 0
              if (!isOver){
                //si compteur pas terminé
        if (Question4ViewController.verif == Question4ViewController.Yes)
        {
              print("it is the right response")
                //implement reponse vrai
                self.myLives.text = String(ViewController.nbrOfLives)
                
                
                if self.idlangue4! == "1"
                {
                    print("score : ", ProfileViewController.scoreFrancais)
                    
                    self.scoreFinal = self.monScoreFrancais + self.monBonus
                    self.LevelFinal = Int(idlevel4!)!
                    let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                    Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                        print(repsonse)}
                    
                    // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                }
                if self.idlangue4! == "2"
                {
                    print("score " ,ProfileViewController.scoreAnglais)
                    
                    //update scoreUserAnglais
                    self.scoreFinal = self.monScoreAnglais + self.monBonus
                    self.LevelFinal = Int(idlevel4!)!
                    let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                    Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                        print(repsonse)}
                    
                    // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                }
                if self.idlangue4! == "3"
                    
                {//update scoreUserGerman
                    
                    self.scoreFinal = self.monScoreGerman + self.monBonus
                    self.LevelFinal = Int(idlevel4!)!
                    
                    let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                    Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                        print(repsonse)}
                    
                    // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
                }
                if self.idlangue4! == "4"
                {
                    //update scoreUserEspa
                    
                    self.scoreFinal = self.monScoreEspa + self.monBonus
                    self.LevelFinal = Int(idlevel4!)!
                    
                    let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                    Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                        print(repsonse)
                    }
                    
                }
                ///message de félicitation
                
                let alert = UIAlertController(title: "Felicitations", message: "YOU SELECTED THE BEST RESPONSE ", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                    self.performSegue(withIdentifier: "ToQuestion5", sender: IndexPath.self )
                } )
                alert.addAction(action)
                
                self.present(alert,animated: true,completion: nil)
                
        
          
            
            
            
            
            
        }else  {
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
                
                self.myLives.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if (ViewController.nbrOfLives == 1){
                self.myLives.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if ViewController.nbrOfLives == 0 {
                self.myLives.text = String(ViewController.nbrOfLives)
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
                    self.performSegue(withIdentifier: "toHome3", sender: IndexPath.self )
                    
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
        self.myLives.text = String(ViewController.nbrOfLives)
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
                let scoreAnglais = table["scoreAng"] as! String
                self.monScoreAnglais = Int(scoreAnglais)!
                
                let scoreGerma = table["scoreGerm"] as! String
                self.monScoreGerman = Int(scoreGerma)!
                let scoreEsp = table["scoreEsp"] as! String
                self.monScoreEspa = Int(scoreEsp)!
                
                
                
                
                if self.idlangue4 == "1"
                {
                    
                    self.myScore.text = String(self.monScoreFrancais)
                }
                if self.idlangue4 == "2"
                {
                    
                    self.myScore.text = String(self.monScoreAnglais)
                    
                }
                if self.idlangue4 == "3"
                {
                    
                    self.myScore.text = String(self.monScoreGerman)
                }
                if self.idlangue4 == "4"
                {
                    
                    self.myScore.text = String(self.monScoreEspa)
                    
                }
                
                
            }
            
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*     let destination_viewcontroller = segue.destination as? Cours1ViewController
         
         destination_viewcontroller?.lvlId = self.idlevelx
         
         destination_viewcontroller?.id_langue = self.idlanguex
         */
        
        if segue.identifier == "ToQuestion5"{
            
            
            if let destViewController : Question5ViewController = segue.destination as? Question5ViewController
            {
                
                destViewController.idlangue5 = idlangue4
                destViewController.idlevel5  = idlevel4
                
                
            }
        }
    }
}
