//
//  EndLevelViewController.swift
//  monMiniProjet
//
//  Created by Khaled&Raoudha on 21/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class EndLevelViewController: UIViewController {

    var idlevel3 : String?
    var idlangue3 : String?
    var LevelFinal : Int = 0
    var scoreFinal : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if idlangue3! == "1"
        {
            print("score francais : ",Type3QuestionViewController.ScoreQ5)
            print("level francais: ", Type3QuestionViewController.LevelQ5)
            ViewController.nbrOfLives = 3
            if LevelFinal == 7
            { LevelFinal = 7}
            else {
            LevelFinal = Type3QuestionViewController.LevelQ5 + 1
                scoreFinal = ViewController.scoreFF}
            let paramatres = ["email" :ViewController.monEmail,"scoreF" : scoreFinal,"levelFr":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUser.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
            
            
        }
        if self.idlangue3! == "2"
        { ViewController.nbrOfLives = 3
            print("score Anglais : ",Type3QuestionViewController.ScoreQ5)
            print("level Anglais: ", Type3QuestionViewController.LevelQ5)
          
            if LevelFinal == 7
            { LevelFinal = 7}
            else {
                LevelFinal = Type3QuestionViewController.LevelQ5 + 1
                scoreFinal = ViewController.scoreFF}
            //update scoreUserAnglais
            
            let paramatres = ["email" :ViewController.monEmail,"scoreAng" : scoreFinal,"levelAng":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserAng.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
        }
        if self.idlangue3! == "3"
            
        {//update scoreUserGerman
            
        
            print("score Germ : ",Type3QuestionViewController.ScoreQ5)
            print("level Germ: ", Type3QuestionViewController.LevelQ5)
            ViewController.nbrOfLives = 3
            if LevelFinal == 7
            { LevelFinal = 7}
            else {
                LevelFinal = Type3QuestionViewController.LevelQ5 + 1
                scoreFinal = ViewController.scoreFF}
            
            let paramatres = ["email" :ViewController.monEmail,"scoreGerm" : scoreFinal,"levelGer":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserGerm.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)}
            
            // performSegue(withIdentifier: "versQuestio2", sender: IndexPath.self )
        }
        if self.idlangue3! == "4"
        {
            //update scoreUserEspa
            print("score Espa : ",Type3QuestionViewController.ScoreQ5)
            print("level Espa: ", Type3QuestionViewController.LevelQ5)
            ViewController.nbrOfLives = 3
            if LevelFinal == 7
            { LevelFinal = 7}
            else {
                LevelFinal = Type3QuestionViewController.LevelQ5 + 1
                scoreFinal = ViewController.scoreFF}
            
            let paramatres = ["email" :ViewController.monEmail,"scoreEsp" : scoreFinal,"levelEsp":LevelFinal ] as [String : Any]
            Alamofire.request(ViewController.Ip + "miniProjetWebService/updateUserEsp.php", method: .post , parameters: paramatres).responseString { repsonse in
                print(repsonse)
            }
            
        }
        
        
    }
  

}
