import UIKit

class MainController: UITableViewController {
    
    var posts = [PostData]()
    var jsonData: Subreddit?
    let linkURLString = "https://www.reddit.com/r/hiphopheads.json"
    let semaphore = DispatchSemaphore(value: 0)
    
    // Grabs untouched JSON data directly from reddit
    public func fetchPostData() -> Subreddit? {
        guard let linkURL = URL(string: linkURLString) else { return nil }
        URLSession.shared.dataTask(with: linkURL) { (data, response, error) in
            guard let fetchedJSON = data else { return }
            
            let decodedJSON = try! JSONDecoder.init().decode(Subreddit.self, from: fetchedJSON)
            self.jsonData = decodedJSON
            print(self.jsonData!.data?.children[1].data?.author ?? "oops")
            self.semaphore.signal()
            }.resume()
        _ = self.semaphore.wait(timeout: DispatchTime.distantFuture)
        return jsonData
    }
    
    
    // Parses Subreddit struct to only relay valid tracks.
    private func loadPostData() {
        let postArray = self.fetchPostData()!.data!.children
        for post in postArray {
            if (post.data?.title?.lowercased().hasPrefix("[fresh]"))! {
                posts.append(post.data!)
            }
        }
    }
    
    @IBAction func refreshPosts(_ sender: Any) {
        posts.removeAll()
        self.loadPostData()
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        loadPostData()
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshPosts(_:)), for: .valueChanged)
        self.refreshControl = refreshControl

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PostTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostTableViewCell else {
            fatalError("Dequeued cell not correct type. (CE)")
        }
        
        let post = posts[indexPath.row]
        cell.postTitle.text = post.title
        cell.upvotes.text = post.ups!.description
        if (Int(post.ups!.description)! > 500) {
            cell.descriptor.text = "HOT"
        }
        else { cell.descriptor.text = "MEDIUM" }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
