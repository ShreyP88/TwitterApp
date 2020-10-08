//
//  TweetCell.swift
//  Twitter
//
//  Created by Shreyas Pant on 10/7/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
