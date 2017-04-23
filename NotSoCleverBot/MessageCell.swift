//
//  MessageCell.swift
//  NotSoCleverBot
//
//  Created by Shane Nelson on 4/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  @IBOutlet weak var outputLabel: UILabel!
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    outputLabel.layer.cornerRadius = 8
    outputLabel.layer.masksToBounds = true
    outputLabel.numberOfLines = 0
    outputLabel.lineBreakMode = .byWordWrapping
  }
}

class UserMessageCell: MessageCell { }
class BotMessageCell: MessageCell { }
