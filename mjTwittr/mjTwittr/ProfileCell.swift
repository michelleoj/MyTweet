//
//  ProfileCell.swift
//  mjTwittr
//
//  Created by michelle johnson on 9/21/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

   
    var user: User! {
        didSet {
            if user != nil {
//                userHandleLabel.text = user.screenname
//                userName.text = user.name
//                headerImageView.setImageWithURL(NSURL(string: user.headerImgUrl!))
//                profileAvatarImageView.setImageWithURL(NSURL(string: user.profileImgUrl!))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
 
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
