//
//  ImageTableCell.swift
//  13Assign3
//
//  Created by Igwe Onumah on 12/16/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import UIKit

class ImageTableCell: UITableViewCell {
    
    @IBOutlet weak var albumIdLabel: UILabel!
    
    @IBOutlet weak var thumbnail: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "ImageTableCell"
}
