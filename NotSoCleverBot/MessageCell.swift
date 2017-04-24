//
//  MessageCell.swift
//  NotSoCleverBot
//
//  Created by Shane Nelson on 4/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
  @IBOutlet weak var outputLabel: InsetLabel!
  
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

//http://stackoverflow.com/questions/32239457/how-do-you-add-inset-to-uilabel-ios-swift
class InsetLabel: UILabel {
  let topInset = CGFloat(8)
  let bottomInset = CGFloat(8)
  let leftInset = CGFloat(16)
  let rightInset = CGFloat(16)
  
  override func drawText(in rect: CGRect) {
    let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override public var intrinsicContentSize: CGSize {
    var intrinsicSuperViewContentSize = super.intrinsicContentSize
    intrinsicSuperViewContentSize.height += topInset + bottomInset
    intrinsicSuperViewContentSize.width += leftInset + rightInset
    return intrinsicSuperViewContentSize
  }
}
