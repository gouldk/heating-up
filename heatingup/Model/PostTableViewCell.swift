//
//  PostTableViewCell.swift
//  heatingup
//
//  Created by Kyle on 1/5/19.
//  Copyright © 2019 Kyle. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var upvotes: UILabel!
    @IBOutlet weak var descriptor: UILabel!
    
    // imageDescriptor, ...
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
