//
//  TweetsViewController.swift
//  mjTwittr
//
//  Created by michelle johnson on 9/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate {
    
    var refreshControl: UIRefreshControl!
    var tweets: [Tweet]?
    var lastId: NSNumber?
    var lastTapLoc: Int?
    
    @IBAction func replyToTweet(sender: AnyObject) {
        self.performSegueWithIdentifier("composeTweet", sender: self)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "mjTwittr"
        
        JTProgressHUD.show()
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)

        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.lastId = self.tweets?[0].id
            
            self.tableView.reloadData()
        })
        
        JTProgressHUD.hide()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        TwitterClient.sharedInstance.onRefresh(self.lastId!, params: nil) { (tweets, error) -> () in
            if let tweetsarr = tweets as [Tweet]? {
                for tweet in tweetsarr {
                    self.tweets?.insert(tweet, atIndex: 0)
                }
            }
            self.lastId = self.tweets?[0].id
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        
        cell.tweet = tweets?[indexPath.row]
        
        cell.avatarImageView.userInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "avatarImageTapped:")
        tapGestureRecognizer.numberOfTapsRequired = 1
        cell.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
    
    func avatarImageTapped(sender: UITapGestureRecognizer) {
        print("hello there brethren")
        let touch = sender.locationInView(tableView)
        if let indexPath = tableView.indexPathForRowAtPoint(touch) {
            lastTapLoc = indexPath.row
            print("TESTING TOUCH LOCATION: \(indexPath.row)")
        }
        performSegueWithIdentifier("ProfileViewSegue", sender: sender)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let s = sender as? UITableViewCell {
            let cell = s
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets![indexPath.row]
            
            let tweetDetailsViewController = segue.destinationViewController as! TweetDetailsViewController
            
            tweetDetailsViewController.tweet = tweet
        } else if let s = sender as? UITapGestureRecognizer {
//            let cell = s
//            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets![lastTapLoc!]
            
            let profileViewController = segue.destinationViewController as! ProfileViewController
            
            profileViewController.user = tweet.user
            
            
        } else {
            let newTweetViewController = segue.destinationViewController as! NewTweetViewController
            newTweetViewController.delegate = self
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    func newTweetViewController(newTweetViewController: NewTweetViewController, didCreateTweet tweet: Tweet!) {
        self.tweets?.insert(tweet, atIndex: 0)
        self.tableView.reloadData()
    }

    func layoutSubviews() {
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSizeMake(0, 0.5)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = shadowPath.CGPath
    }

}
