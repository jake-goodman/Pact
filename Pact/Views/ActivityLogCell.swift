//
//  ActivityLogCell.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class ActivityLogCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupCell()
    }
    
    private func setupCell() {
        selectionStyle = .none
    }
    
}
