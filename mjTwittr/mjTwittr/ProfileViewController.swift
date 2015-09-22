//
//  ProfileViewController.swift
//  mjTwittr
//
//  Created by michelle johnson on 9/20/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileAvatarImageView: UIImageView!
    
    @IBOutlet weak var profileUserNameLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var headerProfileImageView: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    
    var user: User?
    var followersArr: [Int]?
    var following: [Int]?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = user?.name
//        TwitterClient.sharedInstance.getFollowersCount(user!.screenname!, userid: user!.userId!, completion: { (ids, error) -> () in
//            self.followersArr = ids
//            print("NUMBER OF FOLOWERS! \(ids?.count)")
//        })
        // Do any add
        
        userHandleLabel.text = user!.screenname
        profileUserNameLabel.text = user!.name
        headerProfileImageView.setImageWithURL(NSURL(string: user!.headerImgUrl!))
        
        profileAvatarImageView.setImageWithURL(NSURL(string: user!.profileImgUrl!))
        
        profileAvatarImageView.layer.cornerRadius = 3
        profileAvatarImageView.clipsToBounds = true
        profileAvatarImageView.layer.borderWidth = 3.0;
        profileAvatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileAvatarImageView.layer.cornerRadius = 3
        //followersCountLabel.text = String(followersArr!.count)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func followersCount(username: String, userid: Int) {
        
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
