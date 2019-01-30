//
//  mainTableViewCell.swift
//  monMiniProjet
//
//  Created by ESPRIT on 30/11/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    
    

    @IBOutlet weak var collectionview1: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension mainTableViewCell
{
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate & UICollectionViewDataSource>
    (_ dataSourceDelegate: D ,forRow row:Int){
        collectionview1.delegate = dataSourceDelegate
        collectionview1.dataSource = dataSourceDelegate
        collectionview1.reloadData()
        
    }
}
