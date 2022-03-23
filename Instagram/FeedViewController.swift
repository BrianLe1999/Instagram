//
//  FeedViewController.swift
//  Instagram
//
//  Created by 01659826174 01659826174 on 3/22/22.
//

import UIKit
import Parse
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var posts = [PFObject]()
    private var numPosts = 20
    let myRefreshControl = UIRefreshControl()

    @IBOutlet weak var postTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTableView.dataSource = self
        self.postTableView.delegate = self

        // Do any additional setup after loading the view.
        self.postTableView.separatorColor = UIColor.clear
        myRefreshControl.addTarget(self, action: #selector(loadPosts), for: .valueChanged)
        postTableView.refreshControl = myRefreshControl
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPosts()
    }
    
    @objc private func loadPosts() {
        print("load posts")
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = numPosts
        query.findObjectsInBackground { posts, error in
            if posts != nil {
                self.posts = posts!
                self.postTableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    private func loadMorePosts() {
        print("load more posts")
        numPosts += 20
        loadPosts()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as? String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        cell.photoImageVIew.af.setImage(withURL: url!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count {
            loadMorePosts()
        }
    }

}
