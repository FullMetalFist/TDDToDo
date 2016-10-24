//
//  APIClientTests.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 10/23/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import XCTest
@testable import TDDToDo

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession = MockURLSession()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = APIClient()
        
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin_MakesRequestWithUsernameAndPassword() {
                
        let completion = { (error: ErrorType?) in }
        sut.loginUserWithName("dude", password: "1234", completion: completion)
        
        XCTAssertNotNil(mockURLSession.completionHandler)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
    }
}

extension APIClientTests {
    
    class MockURLSession: TDDToDoURLSession {
        
        typealias Handler = (NSData!, NSURLResponse!, NSError!) -> Void
        
        var completionHandler: Handler?
        var url: NSURL?
        
        func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
            
            self.url = url
            self.completionHandler = completionHandler
            return NSURLSession.sharedSession().dataTaskWithURL(url)
        }
    }
}
