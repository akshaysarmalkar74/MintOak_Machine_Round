//
//  CompanyCollectionViewCell.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var bgView: UIView!
      
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(name: String?, isSelected: Bool) {
        lblCompanyName.text = name
        bgView.backgroundColor = isSelected ? UIColor.accentColor1 : .clear
        lblCompanyName.textColor = isSelected ? .white : .black
    }
    
}
