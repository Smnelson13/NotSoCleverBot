//
//  ChatTextViewController.swift
//  NotSoCleverBot
//
//  Created by Shane Nelson on 4/21/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SlackTextViewController
import SwiftyJSON

class ChatTextViewController: SLKTextViewController
{
  var api: APIController!
  var messages = [Message]()
  
  var kBotMessageCellIdentifier = "BotMessageCell"
  var kUserMessageCellIdentifier = "UserMessageCell"
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    api = APIController(delegate: self)
    
    tableView?.rowHeight = UITableViewAutomaticDimension
    tableView?.estimatedRowHeight = 80
    
    tableView?.separatorStyle = .none
    tableView?.tableFooterView = UIView()
    tableView?.tableHeaderView = UIView()

    for identifier in [kBotMessageCellIdentifier, kUserMessageCellIdentifier] {
      let nib = UINib(nibName: identifier, bundle: nil)
      tableView?.register(nib, forCellReuseIdentifier: identifier)
    }
  }
  
  override func didPressRightButton(_ sender: Any?)
  {
    if let messageString = textView.text, messageString != ""
    {
      sendMessage(string: messageString)
      textView.text = ""
    }
  }

  override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle
  {
    return .plain
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return messages.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let message = messages[indexPath.row]
    
    if message.isCleverBotMessage
    {
      let cell = tableView.dequeueReusableCell(withIdentifier: kBotMessageCellIdentifier) as! BotMessageCell
      cell.transform = tableView.transform
      cell.outputLabel.text = message.output
      return cell
    }
    else
    {
      let cell = tableView.dequeueReusableCell(withIdentifier: kUserMessageCellIdentifier) as! UserMessageCell
      cell.transform = tableView.transform
      cell.outputLabel.text = message.output
      return cell
    }
  }
  
  func sendMessage(string: String)
  {
    let message = Message(message: string)
    
    messages.insert(message, at: 0)
    tableView?.reloadData()
    
    api.getReply(input: string)
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    return UITableViewAutomaticDimension
  }
  
}


extension ChatTextViewController: APIControllerDelegate
{
  func apiController(ac: APIController, didReceive json: JSON)
  {
    print(json.dictionaryObject!)
    
    let message = Message(json: json)
    messages.insert(message, at: 0)
    tableView?.reloadData()
  }
}
