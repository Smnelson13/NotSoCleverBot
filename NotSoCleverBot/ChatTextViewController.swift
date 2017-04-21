//
//  ChatTextViewController.swift
//  NotSoCleverBot
//
//  Created by Shane Nelson on 4/21/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import UIKit
import SlackTextViewController

class ChatTextViewController: SLKTextViewController
{
    var api: APIController!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        api = APIController(delegate: self)
        api.getReply(input: "hello")
    }
}

extension ChatTextViewController: APIControllerDelegate
{
    func apiController(ac: APIController, didReceive reply: String)
    {
        print(reply)
    }
}
