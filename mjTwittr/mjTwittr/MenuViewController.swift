//
//  MenuViewController.swift
//  mjTwittr
//
//  Created by michelle johnson on 9/20/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var currentUserDescriptionLabel: UILabel!
    @IBOutlet weak var currentUserHandleLabel: UILabel!
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    

    
    private var mentionsNavigationController: UIViewController!
    //the tweets timeline
    private var twitterNavigationController: UIViewController!
    private var profileViewController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        currentUserImageView.setImageWithURL(NSURL(string: User.currentUser!.profileImgUrl!));
        
        currentUserHandleLabel.text = User.currentUser!.name
        
        currentUserDescriptionLabel.text = User.currentUser!.dictionary["description"] as? String
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        twitterNavigationController = storyboard.instantiateViewControllerWithIdentifier("TwitterNavigationController")
        mentionsNavigationController = storyboard.instantiateViewControllerWithIdentifier("MentionsNavigationController")
        profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileView")
        
        
        viewControllers.append(twitterNavigationController)
        viewControllers.append(mentionsNavigationController)
        viewControllers.append(profileViewController)
        
        hamburgerViewController?.contentViewController = twitterNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        let titles = ["Timeline", "Profile", "Mentions"]
        cell.menuTitleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        hamburgerViewController?.contentViewController = viewControllers[indexPath.row]
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
