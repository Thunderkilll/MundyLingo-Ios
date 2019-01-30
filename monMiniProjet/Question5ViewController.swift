//
//  Question5ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 20/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
class Question5ViewController: UIViewController {
    var player : AVPlayer?
    var questions : NSArray = []
    var idlevel5 : String?
    var idlangue5 : String?
    var IdQuestion : String = ""
    var choix:Int = 0
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
    var URLImageproposition1 : String = ""
    var URLVoixQuestion : String = ""
    var URLImageproposition2 : String = ""
    var URLImageproposition3 : String = ""
    var URLImageproposition4 : String = ""
    var urlPropositions = ViewController.Ip + "miniProjetWebService/selectProposition.php?level="
    var urlQuestion = ViewController.Ip + "miniProjetWebService/selectQuestion.php?level="
    var urlReponse = ViewController.Ip + "miniProjetWebService/selectReponsedeQuestion.php?level="
    var propsitiondetails : NSArray = []
    
    
    @IBOutlet weak var MyScore: UILabel!
    
    @IBOutlet weak var MyCompteur: UILabelX!
    
    @IBOutlet weak var MyLive: UILabelX!
    
    @IBOutlet weak var MyQuestion: UILabelX!
    
    @IBOutlet weak var PropImg1: UIImageViewX!
    
    @IBOutlet weak var PropImg2: UIImageViewX!
    @IBOutlet weak var PropImg3: UIImageViewX!
    
    @IBOutlet weak var PropImg4: UIImageViewX!
    
    @IBAction func ListenMyQuestionAction(_ sender: Any) {
        player?.pause()
        loadRadio(radioURL: self.URLVoixQuestion)
        print(self.URLVoixQuestion)

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        counter = counterStartValue
        self.MyCompteur.text = "00:00"
        startCounter()
        print("counter in q 2 " ,counter)
        self.MyLive.text = String(ViewController.nbrOfLives)
        // lives = ViewController.nbrOfLives
        getUserData()
        urlQuestion += self.idlevel5!
        urlQuestion += "&langue="
        urlQuestion +=  self.idlangue5!
        urlQuestion += "&type=5"
        
        print(urlQuestion)
        
        Alamofire.request(self.urlQuestion).responseJSON{
            response in
            //            print(response.result.value!)
            if response.result.value != nil
            {
                self.questions = response.result.value as! NSArray
                
                let table = self.questions[0] as! Dictionary<String,Any>
                
                let contenu = table["contenu"] as! String
                print( " ***mon question** ", contenu)
                self.MyQuestion.text = contenu
                let id = table["id"] as! String
                self.IdQuestion  = id
                
    
             
                self.URLVoixQuestion = table["vocal"] as! String
            print("voix url Question ", self.URLVoixQuestion)
                
                print("this is alamo proposition" ,self.IdQuestion)
                self.urlPropositions += self.idlevel5!
                self.urlPropositions += "&question="
                self.urlPropositions += self.IdQuestion
                self.urlPropositions += "&langue="
                self.urlPropositions += self.idlangue5!
                self.getPropositions()
                
                //get reponse
                
                self.urlReponse += self.idlevel5!
                self.urlReponse += "&question="
                self.urlReponse += self.IdQuestion
                self.urlReponse += "&idLangue="
                self.urlReponse += self.idlangue5!
                
                self.getReponse()
                
                // print( "proposition correct view did load : ",Type2QuestionViewController.Yes)
            }
        }

        
        
        
        
    }
    
    func getPropositions()  {
        Alamofire.request(self.urlPropositions).responseJSON{
            response in
            print(self.urlPropositions)
        
            if response.result.value != nil
            {
                
                self.propsitiondetails = response.result.value as! NSArray
                //choix 1
                let table1 = self.propsitiondetails[0] as! Dictionary<String,Any>
           
                let imageProposition = table1["image"] as! String
                print("image urlProposition ", imageProposition)
                self.PropImg1.af_setImage(withURL: URL(string:  imageProposition)!)
                
                
                //choix 2
                let table2 = self.propsitiondetails[1] as! Dictionary<String,Any>
                
                let imageProposition2 = table2["image"] as! String
                print("image urlProposition ", imageProposition2)
                self.PropImg2.af_setImage(withURL: URL(string:  imageProposition2)!)
                
                //choix 3
                
                let table3 = self.propsitiondetails[2] as! Dictionary<String,Any>
                
              
                  let imageProposition3 = table3["image"] as! String
                print("image url 3 ", imageProposition3)
                self.PropImg3.af_setImage(withURL: URL(string:  imageProposition3)!)
                
                //choix 4
                
                let table4 = self.propsitiondetails[3] as! Dictionary<String,Any>
                let imageProposition4 = table4["image"] as! String
                print("image url 3 ", imageProposition4)
                self.PropImg4.af_setImage(withURL: URL(string:  imageProposition4)!)
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
                Question5ViewController.Yes = Int(prop)!
                print("correct prop in function ????")
                print(Question5ViewController.Yes)
                
            }
        }
    }
    
    
    
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let touch = touches.first {
            if touch.view == self.PropImg1 { //image View property
                //img 1
                let red1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg4.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg2.borderColor = red2
                
                //img3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg3.borderColor = red3
                //img 4
                let red4 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.PropImg1.borderColor = red4
                //selected choice
                
               self.choix = 1
                print(self.choix)
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
                
                
            }
            if touch.view == self.PropImg2 { //image View property
                
                //img 1
                let red1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg4.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.PropImg2.borderColor = red2
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg3.borderColor = red4
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg1.borderColor = red3
                //selected choice
              self.choix = 2
                print(self.choix)
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
            }
            if touch.view == self.PropImg3 { //image View property
                
                //img 1
                let red1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg1.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.PropImg3.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg4.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg2.borderColor = red4
                //selected choice
                
               self.choix = 3
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
                print(self.choix)
            }
            
            if touch.view == self.PropImg4 { //image View property
                
                //img 1
                let red1 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.PropImg4.borderColor = red1
                
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg2.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg3.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.PropImg1.borderColor = red4
                //selected choice
               self.choix = 4
                print(self.choix)
                //self.delegate?.didClickOnCellImageView(indexPath: self.cellIndexPath!)
            }
            
            
        }
    }

    
    func getUserData()  {
        //this function will return user info from database because i can't wait the user untill he go to check ihis profile first sio we can store the informations
        var url =  ViewController.Ip + "miniProjetWebService/selectUser.php?email="
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
                
                
                
                
                if self.idlangue5 == "1"
                {
                    
                    self.MyScore.text = String(self.monScoreFrancais)
                }
                if self.idlangue5 == "2"
                {
                    
                    self.MyScore.text = String(self.monScoreAnglais)
                    
                }
                if self.idlangue5 == "3"
                {
                    
                    self.MyScore.text = String(self.monScoreGerman)
                }
                if self.idlangue5 == "4"
                {
                    
                    self.MyScore.text = String(self.monScoreEspa)
                    
                }
                
                
            }
            
        }
        
    }
    

    
    
    
    @IBAction func valider(_ sender: Any) {
       
        player?.pause()
        if (ViewController.nbrOfLives == 0)
        { print("you can not play you dont have lives")
            let alert = UIAlertController(title: "Sorry !!!", message: "Hey !!! you dont have Lives any more", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "toHome4", sender: IndexPath.self )
                
            } )
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert,animated: true,completion: nil)
            
        }else {
            //nbr de vie diiferent a 0
            if (!isOver){
               ///compteur not 0
               if (Question5ViewController.Yes == self.choix)
               { print("goooood jobbbb ")
                    
                    print("it is the right response")
                
                    self.MyLive.text = String(ViewController.nbrOfLives)
                    
                    
                    if self.idlangue5! == "1"
                    {
                        print("score : ", ProfileViewController.scoreFrancais)
                        
                        self.scoreFinal = self.monScoreFrancais + self.monBonus
                        self.LevelFinal = Int(idlevel5!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                        Alamofire.request( ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                       
                    }
                    if self.idlangue5! == "2"
                    {
                        print("score " ,ProfileViewController.scoreAnglais)
                        
                        //update scoreUserAnglais
                        self.scoreFinal = self.monScoreAnglais + self.monBonus
                        self.LevelFinal = Int(idlevel5!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                        Alamofire.request( ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                    }
                    if self.idlangue5! == "3"
                        
                    {//update scoreUserGerman
                        
                        self.scoreFinal = self.monScoreGerman + self.monBonus
                        self.LevelFinal = Int(idlevel5!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                        Alamofire.request( ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                    
                    }
                    if self.idlangue5! == "4"
                    {
                        //update scoreUserEspa
                        
                        self.scoreFinal = self.monScoreEspa + self.monBonus
                        self.LevelFinal = Int(idlevel5!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                        Alamofire.request( ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)
                        }
                        
                    }
                    ///message de félicitation
                    
                    let alert = UIAlertController(title: "Felicitations", message: "YOU SELECTED THE BEST RESPONSE ", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                        self.performSegue(withIdentifier: "ToQuestion3", sender: IndexPath.self )
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
    func startCounter(){
        
        counterTime1 = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
        
    }
    
    
    
    @objc func decrementCounter()  {
        if !isOver {
            
            if self.counter <= 1{
                isOver = true
                //alert
                self.MyCompteur.text = "00:00"
                counterTime1.invalidate()
            }
            self.counter -= 1
            self.MyCompteur.text = String(self.counter)
            
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
            self.MyCompteur.text = "\(minText):\(secText)"
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
                
                self.MyLive.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if (ViewController.nbrOfLives == 1){
                self.MyLive.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if ViewController.nbrOfLives == 0 {
                self.MyLive.text = String(ViewController.nbrOfLives)
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
                    self.performSegue(withIdentifier: "toHome4", sender: IndexPath.self )
                    
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
        self.MyLive.text = String(ViewController.nbrOfLives)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       
       
            if segue.identifier == "ToQuestion3"{
                if let destViewController : Type3QuestionViewController = segue.destination as? Type3QuestionViewController
                {
                    
                    destViewController.id_langue = self.idlangue5
                    destViewController.lvlId = self.idlevel5
                    //performSegue(withIdentifier: "ToQuestion3", sender: IndexPath.self )
                }
                
            }
        }
 
    

    
}
