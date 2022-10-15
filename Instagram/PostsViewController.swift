//
//  PostsViewController.swift
//  Instagram
//
//  Created by Jay on 2022/10/15.
//

import UIKit
import Parse
class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var refreshControl: UIRefreshControl!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    @objc func onRefresh() {
        loadPosts()
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        let post  = posts[indexPath.row]
        let user = post["author"] as! PFUser
        cell.author.text = user.username
        cell.postText.text = post["caption"] as! String
            let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.postImage.af_setImage(withURL:url)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tablView.delegate = self
        tablView.dataSource = self
        // Do any additional setup after loading the view.
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tablView.insertSubview(refreshControl, at: 0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPosts()
    }
    func loadPosts(){
        let query = PFQuery(className: "posts")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground{
            (posts,error) in
            if posts != nil{
                self.posts = posts!
                self.tablView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    @IBOutlet weak var tablView: UITableView!
    var posts = [PFObject]()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
