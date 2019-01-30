//
//  Type3QuestionViewController.swift
//  monMiniProjet
//
//  Created by Khaled&Raoudha on 20/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Type3QuestionViewController: UIViewController {


    
    var urlPropositions = ViewController.Ip + "miniProjetWebService/selectProposition.php?level="
    var urlQuestion = ViewController.Ip + "miniProjetWebService/selectQuestion.php?level="
    var urlReponse = ViewController.Ip + "miniProjetWebService/selectReponsedeQuestion.php?level="
    var IdQuestion : String = ""
    var lvlId: String?
    var id_langue: String?
    var questions : NSArray = []
    var Userdetails : NSArray = []
    var reponsedetails : NSArray = []
    var propsitiondetails : NSArray = []
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
    var counterStartValue = 60
    var isOver = false
    var choix:Int = 0
    static var Yes:Int = 0
    static var ScoreQ5: Int = 0
    static var LevelQ5: Int = 0
    //outlets
    
    
    @IBOutlet weak var conteurLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabelX!
    @IBOutlet weak var questionImg: UIImageViewX!
    @IBOutlet weak var choix1: UILabelX!
    @IBOutlet weak var choix2: UILabelX!
    @IBOutlet weak var choix3: UILabelX!
    @IBOutlet weak var choix4: UILabelX!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = counterStartValue
        
        conteurLabel.text = "00:00"
       
        livesLabel.text = String(ViewController.nbrOfLives)
        //start the count down
        
        startCounter()
        //get user score and informations
        getUserData()
        //image View property
        urlQuestion += self.lvlId!
        urlQuestion += "&langue="
        urlQuestion +=  self.id_langue!
        urlQuestion += "&type=6"
        
        //get the question
        Alamofire.request(self.urlQuestion).responseJSON{
            response in
            if response.result.value != nil
            {
            
                self.questions = response.result.value as! NSArray
                
                let table = self.questions[0] as! Dictionary<String,Any>
                
                let contenu = table["contenu"] as! String
                
                let img = table["image"] as! String
                
                self.questionLabel.text = contenu
                
                self.questionImg.af_setImage(withURL: URL(string: img)!)
                let id = table["id"] as! String
                self.IdQuestion  = id
                print("this is alamo" ,self.IdQuestion)
                self.urlPropositions += self.lvlId!
                self.urlPropositions += "&question="
                self.urlPropositions += self.IdQuestion
                self.urlPropositions += "&langue="
                self.urlPropositions += self.id_langue!
                self.getPropositions()
                
                //get reponse
                
                self.urlReponse += self.lvlId!
                self.urlReponse += "&question="
                self.urlReponse += self.IdQuestion
                self.urlReponse += "&idLangue="
                self.urlReponse += self.id_langue!
                
                self.getReponse()
               
            }
        }
        
       
    }
    

   
    
    //user information
    
    func getUserData()  {
        //this function will return user info from database because i can't wait the user untill he go to check ihis profile first sio we can store the informations
        var url = ViewController.Ip + "miniProjetWebService/selectUser.php?email="
        url += ViewController.monEmail
        
        
        Alamofire.request(url).responseJSON{
            response in
            
            
            if response.result.value != nil
            {
         
                self.Userdetails = response.result.value as! NSArray
                
                let table = self.Userdetails[0] as! Dictionary<String,Any>
                
                
                let scoreFrancais = table["scoreF"] as! String
                self.monScoreFrancais = Int(scoreFrancais)!
                let scoreAnglais = table["scoreAng"] as! String
                self.monScoreAnglais = Int(scoreAnglais)!
                self.scoreLabel.text = String(self.monScoreAnglais)
                let scoreGerma = table["scoreGerm"] as! String
                self.monScoreGerman = Int(scoreGerma)!
                let scoreEsp = table["scoreEsp"] as! String
                self.monScoreEspa = Int(scoreEsp)!
                
                
 
                print("this id langue :  \(self.id_langue!)")
                if self.id_langue == "1"
                {
                    print("le score du fr dans q3\(self.monScoreFrancais)")
                    
                    
                }
                if self.id_langue == "2"
                {
                    
                    self.scoreLabel.text = String(self.monScoreAnglais)
                    
                }
                if self.id_langue == "3"
                {
                    
                    self.scoreLabel.text = String(self.monScoreGerman)
                }
                if self.id_langue == "4"
                {
                    
                    self.scoreLabel.text = String(self.monScoreEspa)
                    
                }
 
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    //timer
    
    func startCounter(){
        
        counterTime1 = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func decrementCounter()  {
        if !isOver {
            
            if self.counter <= 1{
                isOver = true
                //alert
             //   self.counterLabel.text = "00:00"
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
          self.conteurLabel.text = "\(minText):\(secText)"
        }
    }
    
    
    //text selected
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
 
        if let touch = touches.first {
            if touch.view == self.choix1{ //image View property
           
                print("Label 1 selected ")
                
                let red1 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix1.borderColor = red1
        
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix2.borderColor = red2
          
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix3.borderColor = red3
            
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix4.borderColor = red4
       
                self.choix = 1
                
           }
            if touch.view == self.choix2{ //image View property
                
                print("Label 2 selected ")
                
                let red1 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix2.borderColor = red1
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix1.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix3.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix4.borderColor = red4
                //selected choice
                self.choix = 2
            }
            
            if touch.view == self.choix3{ //image View property

                print("Label 3 selected ")
                let red1 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix3.borderColor = red1
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix2.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix1.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix4.borderColor = red4
                //selected choice
                self.choix = 3
            }
            
            if touch.view == self.choix4{ //image View property
                  print("Label 4 selected ")
                let red1 = UIColor(red: 000.0/255.0, green: 255.0/255.0, blue: 230.0/255.0, alpha: 1.0)
                self.choix4.borderColor = red1
                //img 2
                let red2 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix3.borderColor = red2
                //img 3
                let red3 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix2.borderColor = red3
                //img 4
                let red4 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                self.choix1.borderColor = red4
                //selected choice
                self.choix = 4
            }
            
         
            
        }

    }
    
    
    
    //TODO: get propositions and the question and the correct answer
    
    
    //propositions
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
                
                self.choix1.text = table1["contenu"] as? String
                
                 //choix 2
                let table2 = self.propsitiondetails[1] as! Dictionary<String,Any>
                
                self.choix2.text = table2["contenu"] as? String
                
                //choix 3
                
                let table3 = self.propsitiondetails[2] as! Dictionary<String,Any>
                
                self.choix3.text = table3["contenu"] as? String
                
                //choix 4
                
                let table4 = self.propsitiondetails[3] as! Dictionary<String,Any>
                
                self.choix4.text = table4["contenu"] as? String
                
            }
        }
        //end proposition
    }
    
    
    
    //get reponse
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
                Type3QuestionViewController.Yes = Int(prop)!
                print("correct prop in function ????")
                print(Type3QuestionViewController.Yes)
                
            }
        }
        //end reponse
    }
    
    
    @IBAction func Valider(_ sender: Any) {
        
     
        
 
        
        if (ViewController.nbrOfLives == 0)
        { print("you can not play you dont have lives")
            let alert = UIAlertController(title: "Sorry !!!", message: "Hey !!! you dont have Lives any more", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "toFinish", sender: IndexPath.self )
                
            } )
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert,animated: true,completion: nil)
            
        }
        else{
            
            if (!isOver){
                
                // he got more than 1 or just one [1..3]
                if self.choix ==   Type3QuestionViewController.Yes {
                    //implement reponse vrai
                    counterTime1.invalidate()
                
                    print("counteur stopped at : ")
                    print(conteurLabel.text!)
                    
                    
                    if self.id_langue! == "1"
                    {
                        print("score : ", ProfileViewController.scoreFrancais)
                        
                        self.scoreFinal = self.monScoreFrancais + self.monBonus
                        self.LevelFinal = Int(id_langue!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                       
                    }
                    if self.id_langue! == "2"
                    {
                        print("score " ,ProfileViewController.scoreAnglais)
                        
                        //update scoreUserAnglais
                        self.scoreFinal = self.monScoreAnglais + self.monBonus
                        self.LevelFinal = Int(id_langue!)!
                        let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
            
                    }
                    if self.id_langue! == "3"
                        
                    {//update scoreUserGerman
                        
                        self.scoreFinal = self.monScoreGerman + self.monBonus
                        self.LevelFinal = Int(id_langue!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)}
                        
                        
                    }
                    if self.id_langue! == "4"
                    {
                        //update scoreUserEspa
                        
                        self.scoreFinal = self.monScoreEspa + self.monBonus
                        self.LevelFinal = Int(id_langue!)!
                        
                        let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
                        Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                            print(repsonse)
                        }
                        
                    }
                    Type3QuestionViewController.ScoreQ5 = self.scoreFinal
                    print ( "secore final de Question 5 est ",Type3QuestionViewController.ScoreQ5)
                    
                    Type3QuestionViewController.LevelQ5 = self.LevelFinal
                    print ( "level final de Question 5 est ",Type3QuestionViewController.LevelQ5)
                    ViewController.scoreFF += self.scoreFinal
                    ///message de félicitation
                    
                    let alert = UIAlertController(title: "Felicitations", message: "YOU SELECTED THE BEST RESPONSE ", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .default , handler: {(action:UIAlertAction!) in
                        self.performSegue(withIdentifier: "toFinish", sender: IndexPath.self )
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
    
    
    
    
    func SenarioLives(){
        
        if(ViewController.nbrOfLives > 3)
        {
            ViewController.nbrOfLives = 3
            
        }
        
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
                    print("ajout du 2nd vie",ViewController.nbrOfLives)
                    //  self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                }
            }
            if ( ViewController.nbrOfLives == 2)
            {
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3600)
                {
                    ViewController.nbrOfLives += 1
                    print("ajout du 3rd vie",ViewController.nbrOfLives)
                    //   self.LabelNbrOfLives.text = String(ViewController.nbrOfLives)
                }
            }
        }
        // self.nbLivesLbL.text = String(ViewController.nbrOfLives)
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
                
                self.livesLabel.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if (ViewController.nbrOfLives == 1){
                self.livesLabel.text = String(ViewController.nbrOfLives)
                print("senario livessss apres 1 faux")
                self.SenarioLives()
            }
            if ViewController.nbrOfLives == 0 {
                self.livesLabel .text = String(ViewController.nbrOfLives)
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
                    self.performSegue(withIdentifier: "toHome6", sender: IndexPath.self )
                    
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
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toFinish"{
            if let destViewController : EndLevelViewController = segue.destination as? EndLevelViewController
            {
                
                destViewController.idlangue3 = self.id_langue
                destViewController.idlevel3 = self.lvlId
             
            }
            
        }
    }
}
