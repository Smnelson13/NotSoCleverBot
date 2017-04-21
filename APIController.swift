//
//  APIController.swift
//  NotSoCleverBot
//
//  Created by Shane Nelson on 4/21/17.
//  Copyright © 2017 Shane Nelson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//url = https://www.cleverbot.com/getreply.
// APIKEy = CC1t66KSrQR3NgU4Uw--3hWcx_w
// https://www.cleverbot.com/getreply?key=CC1t66KSrQR3NgU4Uw--3hWcx_w

//For example, you can call:
//http://www.cleverbot.com/getreply?key=YOURAPIKEY&input=Hello&cs=76nxdxIJ02AAA&callback=ProcessReply

protocol APIControllerDelegate
{
    func apiController(ac: APIController, didReceive reply: String)
}

class APIController
{
    var csID: String?
    var delegate: APIControllerDelegate
    
    init(delegate: APIControllerDelegate)
    {
        self.delegate = delegate
    }
    
    func getReply(input: String) {
        let baseURL = "https://www.cleverbot.com/getreply"
        var parameters: [String: Any] = [
            "key" : "CC1t66KSrQR3NgU4Uw--3hWcx_w",
            "input" : input
        ]
        
        if let id = csID
        {
            parameters["cs"] = id
        }
        
        let request = Alamofire.request(baseURL, method: .get, parameters: parameters)
        
        request.responseJSON { response in
            debugPrint(response)
            if let value = response.value
            {
                let json = JSON(value)
                self.csID = json["cs"].stringValue
                
                print(json.dictionaryObject!)
            }
        }
    }
}


/*


protocol APIControllerProtocol
{
    func didRecieve(_ results: [String: Any])
}

class APIController
{
    private static let APIKey = "CC1t66KSrQR3NgU4Uw--3hWcx_w"
    var delegate: APIControllerProtocol?
    
    init(delegate: APIControllerProtocol)
    {
        self.delegate = delegate
    }
    
    func talkToCleverBot(coordinate: CLLocationCoordinate2D)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let url = URL(string: "https://api.darksky.net/forecast/c3d8d4c9641dfcf8bda6a087e1f55f8b/\(coordinate.latitude),\(coordinate.longitude)")!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
            
            print("Task completed")
            if let error = error
            {
                print(error.localizedDescription)
            }
            else
            {
                if let dictionary = self.parseJSON(data!)
                {
                    if let results = dictionary["currently"] as? [String: Any]
                    {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        self.delegate?.didRecieve(results)
                    }
                }
            }
        })
        
        task.resume()
    }
    
    
    func parseJSON(_ data: Data) -> [String: Any]?
    {
        do
        {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let dictionary = json as? [String: Any]
            {
                return dictionary
            }
            else
            {
                return nil
            }
        }
        catch
        {
            print(error)
            return nil
        }
    }
}

*/
