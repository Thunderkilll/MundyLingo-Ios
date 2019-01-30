//
//  Cours1ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 29/11/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class Cours1ViewController: UIViewController {
    var url = ViewController.Ip + "miniProjetWebService/selectCour.php?idLevel="
    var leveldetails : NSArray = []
    var lvlId: String?
    var id_cour : String?
    var id_langue: String?
    var conjugaison :String?
    var ortographe :String?
    
    var titre:String = "grammaire : level= "
    var grammar: String = ""
    
    @IBOutlet weak var titlelbl: UILabelX!
    
    
    @IBOutlet weak var courseTxT: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        url += lvlId ?? ""
        url += "&langue="
        url += id_langue ?? ""
        
        print("this is id langue",id_langue!)
        titlelbl.text =   "Cours Level : "+lvlId!
        
        
        //Web service
        Alamofire.request(url).responseJSON{
            response in
            
            
            if response.result.value != nil
            {
                self.leveldetails = response.result.value as! NSArray
                
                let table = self.leveldetails[0] as! Dictionary<String,Any>
                
                let yourmom = response.result.value
                print(yourmom!)
                let gram = table["grammaire"] as! String
                let conjug = table["conjugaison"] as! String
                let ortho = table["orthographe"] as! String
                let text = "Grammaire : \n"+gram
                
                self.courseTxT.text = text
                self.conjugaison = conjug
                self.ortographe = ortho
                self.grammar = text
                
                
            }
            
        }
        
        
        //        Alamofire.request(url1).responseJSON{
        //            response in
        //
        //            print(response.result.value)
        //            if let resultatJson2 = response.result.value
        //            {
        //                let responseObject = response.result.value
        //             print(responseObject!)
        //            }
        //
        //        }
        
    }
    
    
    
    
    @IBAction func sendToConjugaison(_ sender: Any) {
        
        performSegue(withIdentifier: "versCour2", sender: IndexPath.self )
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destination_viewcontroller = segue.destination as? cour2ViewController
        
        destination_viewcontroller?.lvlId1 = self.lvlId
        destination_viewcontroller?.id_cour1 = self.id_cour
        destination_viewcontroller?.id_langue1 = self.id_langue
        destination_viewcontroller?.conjug = self.conjugaison
        destination_viewcontroller?.ortograph = self.ortographe
        
    }
    
    
    @IBAction func saveCour(_ sender: Any) {
        
        print(self.titre)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        
        let context = persistantContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cour")
        request.predicate = NSPredicate(format: "titre == %@",self.titre  )
        
        
        
        do {
            let resultArray = try context.fetch(request)
            if resultArray.count == 0 {
                let CourDesc = NSEntityDescription.entity(forEntityName: "Cour", in: context)
                
                let newCour = NSManagedObject (entity: CourDesc!, insertInto: context)
                
                
                
                newCour.setValue(lvlId! , forKey: "level")
                newCour.setValue(titre , forKey: "titre")
                newCour.setValue("grammaire", forKey: "type")
                newCour.setValue(self.grammar, forKey: "contenu")
                
                do {
                    try context.save()
                    print ("Course Saved")
                    //  let alert = UIAlertController(title: "Duplication", message: "le film existe", preferredStyle: .alert)
                    // self.present(alert,animated: true,completion: nil)
                    let alert = UIAlertController(title: "Saved", message: "go check your favourite courses", preferredStyle: .alert)
                    let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true,completion: nil)
                } catch {
                    print("Error !")
                }
            }else{
                let alert = UIAlertController(title: "Duplication", message: "this course existe", preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
            }
        } catch {
            print("error")
        }
        
        
        
        
    }
}







