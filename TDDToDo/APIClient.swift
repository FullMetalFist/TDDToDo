//
//  APIClient.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 10/23/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import Foundation

protocol TDDToDoURLSession {
    func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

enum WebserviceError: ErrorType {
    case DataEmptyError
    case ResponseError
}
class APIClient {
    
    lazy var session: TDDToDoURLSession = NSURLSession.sharedSession()
    var keychainManager: KeychainAccessible?
    
    
    func loginUserWithName(username: String, password: String, completion: (ErrorType?) -> Void) {
        
        let allowedCharacters = NSCharacterSet(charactersInString: "/%&=?$#+-~@<>|\\*,.()[]{}^!").invertedSet
        guard let encodedUsername = username.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
            fatalError()
        }
        guard let encodedPassword = password.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
            fatalError()
        }
        guard let url = NSURL(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else { fatalError() }
        
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            // ...
            if error != nil {
                completion(WebserviceError.ResponseError)
                return
            }
            
            if let theData = data {
                do {
                    let resposneDict = try NSJSONSerialization.JSONObjectWithData(theData, options: [])
                    let token = resposneDict["token"] as! String
                    self.keychainManager?.setPassword(token, account: "token")
                } catch {
                    completion(error)
                }
            } else {
                completion(WebserviceError.DataEmptyError)
            }
        }
        
        task.resume()
    }
}

extension NSURLSession: TDDToDoURLSession { }
