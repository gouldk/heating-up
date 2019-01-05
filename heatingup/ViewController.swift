//
//  ViewController.swift
//  heatingup
//
//  Created by Kyle on 12/28/18.
//  Copyright © 2018 Kyle. All rights reserved.
//

// https://www.reddit.com/r/hiphopheads.json
// https://stackoverflow.com/questions/32950874/wait-for-download-task-to-finish-in-nsurlsession
// 

import UIKit

class ViewController: UIViewController {
    
    var jsonData: Subreddit?
    let linkURLString = "https://www.reddit.com/r/hiphopheads.json"
    let semaphore = DispatchSemaphore(value: 0)
    
    @IBAction func refresh(_ sender: UIButton) {
        _ = print(self.fetchPostData())
    }
    func fetchPostData() -> Subreddit? {
        guard let linkURL = URL(string: linkURLString) else { return nil }
        URLSession.shared.dataTask(with: linkURL) { (data, response, error) in
            guard let fetchedJSON = data else { return }
            
            let decodedJSON = try! JSONDecoder.init().decode(Subreddit.self, from: fetchedJSON)
            self.jsonData = decodedJSON
//            print(self.jsonData!.data?.children[1].data?.author ?? "oops")
            self.semaphore.signal()
            }.resume()
        _ = self.semaphore.wait(timeout: DispatchTime.distantFuture)
        return jsonData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.fetchPostData()!.data?.children.count ?? "Parsing failed!")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}

