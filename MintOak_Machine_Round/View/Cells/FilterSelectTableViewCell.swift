//
//  FilterSelectTableViewCell.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 13/04/24.
//

import UIKit

class FilterSelectTableViewCell: UITableViewCell {

    @IBOutlet weak var checkMarkImgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(name: String, isSelected: Bool) {
        checkMarkImgView.image = isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        lblName.text = name
    }
}
