//
//  FilterTypeTableViewCell.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 13/04/24.
//

import UIKit

class FilterTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSelectTitle: UILabel!
    @IBOutlet weak var lblSelectValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(type: FilterTypes) {
        lblSelectTitle.text = type.displayText
        lblSelectValue.text = "\(type.getValue())"
    }
}
