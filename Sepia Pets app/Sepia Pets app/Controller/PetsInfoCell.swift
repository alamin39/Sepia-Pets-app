//
//  PetsInfoCell.swift
//  Sepia Pets app
//
//  Created by Al-Amin on 30/11/22.
//

import UIKit

class PetsInfoCell: UITableViewCell {
    
    @IBOutlet weak var petsImage: UIImageView!
    @IBOutlet weak var petsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
