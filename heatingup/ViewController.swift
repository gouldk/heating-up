//
//  ViewController.swift
//  heatingup
//
//  Created by Kyle on 12/28/18.
//  Copyright © 2018 Kyle. All rights reserved.
//

// https://www.reddit.com/r/hiphopheads.json

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TEST")
        let linkURLString = "https://www.reddit.com/r/hiphopheads.json"
        guard let linkURL = URL(string: linkURLString) else { return }
        
        URLSession.shared.dataTask(with: linkURL) { (data, response, error) in
            guard let data = data else { return }
//            let dataAsString = String(data: data, encoding: .utf8)
//
            print("Made it here")
            
            let decodedJSON = try! JSONDecoder.init().decode(Subreddit.self, from: data)
            print(decodedJSON.data?.children ?? "oops")
            
//            do {
//                let decodedJSON = try
//                    JSONDecoder.init().decode(Subreddit.self, from: data);
//                print(decodedJSON.data?.children ?? "oops")
//            } catch let _ as NSError {}
        }.resume()
        
        print("END TEST")
        // Do any additional setup after loading the view, typically from a nib.
    }
}

