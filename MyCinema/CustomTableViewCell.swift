//
//  CustomTableViewCell.swift
//  MyCinema
//
//  Created by Илья Маркелов on 22/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit
import Cosmos

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfCinema: UIImageView! {
        didSet {
            imageOfCinema?.layer.cornerRadius = imageOfCinema.frame.size.height / 2
            imageOfCinema?.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLocationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cosmosView: CosmosView! {
        didSet {
            cosmosView.settings.updateOnTouch = false
        }
    }
    
}
