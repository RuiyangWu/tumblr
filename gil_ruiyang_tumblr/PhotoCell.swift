//
//  PhotoCell.swift
//  gil_ruiyang_tumblr
//
//  Created by ruiyang_wu on 8/3/16.
//  Copyright © 2016 ruiyang_wu. All rights reserved.
//

import UIKit

import AFNetworking

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
