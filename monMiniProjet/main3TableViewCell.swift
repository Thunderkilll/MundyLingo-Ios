//
//  main3TableViewCell.swift
//  monMiniProjet
//
//  Created by ESPRIT on 01/12/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit

class main3TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionview3: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension main3TableViewCell
{
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate & UICollectionViewDataSource>
        (_ dataSourceDelegate: D ,forRow row:Int){
        collectionview3.delegate = dataSourceDelegate
        collectionview3.dataSource = dataSourceDelegate
        collectionview3.reloadData()
        
    }
}
