//
//  DetailPrefViewController.swift
//  monMiniProjet
//
//  Created by Khaled&Raoudha on 11/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class DetailPrefViewController: UIViewController {
    
    
    @IBOutlet var contenuLabel: UILabel!
    
    var contenu:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        contenuLabel.text = contenu!
        
        
    }
    
    
    
    
}
