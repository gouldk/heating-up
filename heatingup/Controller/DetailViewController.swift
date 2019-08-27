//
//  DetailViewController.swift
//  heatingup
//
//  Created by Kyle Gould on 8/26/19.
//  Copyright © 2019 Kyle. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contentProvider:String = ""
    var link:String = ""
    var pTitle:String = ""
    var postDate:String = ""
    
    
    @IBOutlet weak var hoursFromPost: UILabel!
    @IBOutlet weak var provider: UILabel!
    @IBOutlet weak var songLink: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: pTitle))
        postTitle.text = pTitle
        hoursFromPost.text = postDate
        provider.text = contentProvider
        songLink.text = link
        
    }
    
    
}

