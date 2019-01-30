//
//  cour2ViewController.swift
//  monMiniProjet
//
//  Created by ESPRIT on 05/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import CoreData
class cour2ViewController: UIViewController {
    
    var titre:String = "conjugaison : level= "
    
    @IBOutlet weak var textConj: UITextView!
    var lvlId1: String?
    var id_cour1 : String?
    var id_langue1: String?
    var ortograph: String?
    var conjug : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titre += lvlId1!
        self.titre += " cours"
        self.titre += self.id_langue1!
        print("titre" ,titre)
        textConj.text = conjug
        
    }
    
    
    
    @IBAction func InsertToData(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistantContainer = appDelegate.persistentContainer
        
        let context = persistantContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cour")
        request.predicate = NSPredicate(format: "titre == %@",  self.titre)
        
        
        
        do {
            let resultArray = try context.fetch(request)
            if resultArray.count == 0 {
                let CourDesc = NSEntityDescription.entity(forEntityName: "Cour", in: context)
                
                let newCour = NSManagedObject (entity: CourDesc!, insertInto: context)
                
                
                
                newCour.setValue(lvlId1! , forKey: "level")
                newCour.setValue(titre , forKey: "titre")
                newCour.setValue("Conjugaison", forKey: "type")
                newCour.setValue(conjug!, forKey: "contenu")
                
                do {
                    try context.save()
                    print ("Course Saved")
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
    
    
    
    @IBAction func goToOrthographe(_ sender: Any) {
        performSegue(withIdentifier: "goToOrtho", sender: IndexPath.self )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destination_viewcontroller = segue.destination as? cour3ViewController
        
        destination_viewcontroller?.lvlId2 = self.lvlId1
        destination_viewcontroller?.id_cour2 = self.id_cour1
        destination_viewcontroller?.id_langue2 = self.id_langue1
        destination_viewcontroller?.ortograph2 = self.ortograph
        
    }
    
    
    
    
}
