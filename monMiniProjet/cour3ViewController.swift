//
//  cour3ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 05/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import CoreData
class cour3ViewController: UIViewController {
    var lvlId2: String?
    var id_cour2 : String?
    var id_langue2: String?
    var ortograph2: String?
      var titre:String = "orthographe : level= "
    @IBOutlet weak var ortographe: UITextView!
    

    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titre += lvlId2!
        self.titre += " cours"
        self.titre += self.id_langue2!
        print("titre" ,titre)
        ortographe.text = ortograph2
    }

    @IBAction func GoToQuestion1(_ sender: Any) {
        performSegue(withIdentifier: "startQuestion", sender: IndexPath.self )

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destination_viewcontroller = segue.destination as? Question1ViewController
        
        destination_viewcontroller?.lvlId3 = self.lvlId2
        destination_viewcontroller?.id_cour3 = self.id_cour2
        destination_viewcontroller?.id_langue3 = self.id_langue2
        
    }
   
    @IBAction func InsertData(_ sender: Any) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        
        let context = persistantContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cour")
        request.predicate = NSPredicate(format: "titre == %@", self.titre)
        
        
        
        do {
            let resultArray = try context.fetch(request)
            if resultArray.count == 0 {
                let CourDesc = NSEntityDescription.entity(forEntityName: "Cour", in: context)
                
                let newCour = NSManagedObject (entity: CourDesc!, insertInto: context)
                
                
                
                newCour.setValue(lvlId2! , forKey: "level")
                newCour.setValue(titre , forKey: "titre")
                newCour.setValue("Orthographe", forKey: "type")
                newCour.setValue(ortograph2! , forKey: "contenu")
                
                do {
                    try context.save()
                    print ("Course Saved")
                    //                let alert = UIAlertController(title: "Duplication", message: "le film existe", preferredStyle: .alert)
                    // self.present(alert,animated: true,completion: nil)
                    
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
