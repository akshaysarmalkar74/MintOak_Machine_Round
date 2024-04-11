//
//  MIDTableViewCell.swift
//  MintOak_Machine_Round
//
//  Created by Akshay Sarmalkar on 11/04/24.
//

import UIKit

class MIDTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var lblMIDValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

// MARK: Helper Methods

extension MIDTableViewCell {
    func configureData(midValue: String?) {
        lblMIDValue.text = midValue
    }
}
