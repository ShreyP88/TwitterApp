//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Shreyas Pant on 10/6/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetsArray = [NSDictionary]()
    var numTweets: Int!
    
    let myRefreshControl = UIRefreshControl()
   
    @IBAction func logoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    
    func loadMoreTweets() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numTweets += 10
        let myParams = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            //self.tweetsArray.removeAll()
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    @objc func loadTweets() {
        numTweets = 20
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetsArray.removeAll()
            for tweet in tweets {
                self.tweetsArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Could not retrieve tweets")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetsArray.count {
            loadMoreTweets()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as!
            TweetCell
        let user = tweetsArray[indexPath.row]["user"] as! NSDictionary

        
        
        cell.tweetContent.text = tweetsArray[indexPath.row]["text"] as! String
        cell.username.text = user["name"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profilePic.image = UIImage(data: imageData)
        }
        
        return cell
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetsArray.count
    }
}
