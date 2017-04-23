//
//  Message.swift
//  NotSoCleverBot
//
//  Created by Shane Nelson on 4/22/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation
import SwiftyJSON

class Message
{
    var output: String
    
    var isCleverBotMessage = false
    
    
    init(message: String)
    {
        self.output = message
    }
    
    init(json: JSON)
    {
        self.isCleverBotMessage = true
        /* self.output = json["output"]["input"]["value"].stringValue */
        self.output = json["clever_output"].stringValue
    }
}
