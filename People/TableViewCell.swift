//
//  TableViewCell.swift
//  Berkeley ABA App
//
//  Created by Timothy Hsu on 6/24/16.
//  Copyright © 2016 Timothy Hsu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
