//
//  CommentCell.swift
//  Instagram
//
//  Created by 01659826174 01659826174 on 3/31/22.
//

import UIKit

class CommentCell: UITableViewCell {


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}