//
//  CourPrefsViewCellViewController.swift
//  monMiniProjet
//
//  Created by Khaled&Raoudha on 11/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import CoreData

class CourPrefsViewCellViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource {
    
    var ArrayTable : [NSManagedObject] = []
    
    
    
    @IBOutlet var tableView: UITableView!
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cour", for: indexPath)
        
        _ = cell.viewWithTag(0)
        let level = cell.viewWithTag(1) as!  UILabel
        let type = cell.viewWithTag(2) as!  UILabel
        
        
        let entity = ArrayTable[indexPath.row]
        level.text = entity.value(forKey: "level") as? String
        type.text =  entity.value(forKey: "type") as? String
        
        return cell ;
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "sharedInfo", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! NSIndexPath
        let index = indexPath.row
        
        if segue.identifier == "sharedInfo"{
            
            if let destinationViewController =  segue.destination as? DetailPrefViewController{
                let entity = ArrayTable[index]
                let contenuX = entity.value(forKey: "contenu") as? String
                destinationViewController.contenu  = contenuX
                
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 tableView.reloadData()
      fetchData()
         }
    

    func fetchData()  {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
       let persistentContainer = appDelegate.persistentContainer
       let context = persistentContainer.viewContext
       let request = NSFetchRequest<NSManagedObject>(entityName: "Cour")
       
        
        do{
            ArrayTable = try context.fetch(request)
            tableView.reloadData()
        }catch {
            print("erreur in affichage")
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let coursedelete =  ArrayTable[indexPath.row]
            context.delete(coursedelete)
            
            do{
                try context.save()
                ArrayTable.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                 tableView.reloadData()
            }catch{
                print("Error")
            }
            
            
            
        }
    }

}
