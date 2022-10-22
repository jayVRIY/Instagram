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
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count+1
    }
    @objc func onRefresh() {
        loadPosts(with: 20)
        
    }
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene =  UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}
        delegate.window?.rootViewController = loginViewController
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1 == posts.count{
            loadPosts(with: posts.count+20)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post  = posts[indexPath.row]
        let comments = (post["comments"] as? [PFObject]) ?? []
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
      
        let user = post["author"] as! PFUser
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        cell.postImage.af_setImage(withURL:url)
        
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell" ) as! CommentTableViewCell
            let comment = comments[indexPath.row-1]
            cell.commentLabel.text = comment["text"] as! String
            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username
             return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let comment = PFObject(className: "Comments");
        comment["text"] = "this is a comment"
        comment["post"] = post
        comment["author"]=PFUser.current()!
        post.add(comment,forKey: "comments");
        post.saveInBackground{
            (success,error) in
            if(success){
                print("post success")
            }else{
                print(error?.localizedDescription)
            }
        }
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
        loadPosts(with: 20)
    }
    func loadPosts(with limit :Int){
        let query = PFQuery(className: "posts")
        query.includeKeys(["author","comments","comments.author"])
        query.limit = limit
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
