//
//  ActivityTableHeaderView.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class ActivityTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
        setupUI()
    }
    
    func setupUI() {
        hourLabel.layer.cornerRadius = hourLabel.frame.width / 2.0
        hourLabel.layer.masksToBounds = true
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2.0
        profileImageView.layer.masksToBounds = true
    }
}
