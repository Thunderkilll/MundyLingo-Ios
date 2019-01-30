//
//  LanguageSelectViewController.swift
//  DragonKiller
//
//  Created by ESPRIT on 02/11/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class LanguageSelectViewController: UIViewController,UICollectionViewDataSource {
    
    var image = ["unkown"]
    
    var previousMovie:Int?
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
     return nil 
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    

}
