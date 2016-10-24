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

class APIClient {
    
    lazy var session: TDDToDoURLSession = NSURLSession.sharedSession()
    
    func loginUserWithName(username: String, password: String, completion: (ErrorType?) -> Void) {
        
        guard let url = NSURL(string: "https://awesometodos.com") else { fatalError() }
        session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
        }
    }
}

extension NSURLSession: TDDToDoURLSession { }
