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
        sut.loginUserWithName("düde", password: "%&34", completion: completion)
        
        XCTAssertNotNil(mockURLSession.completionHandler)
        
        guard let url = mockURLSession.url else {
            XCTFail()
            return
        }
        
        let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "awesometodos.com")
        
        XCTAssertEqual(urlComponents?.path, "/login")
        
        let allowedCharacters = NSCharacterSet(charactersInString: "/%&=?$#+-~@<>|\\*,.()[]{}^!").invertedSet
        guard let expectedUsername = "düde".stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else { fatalError() }
        
        guard let expectedPassword = "%&34".stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else { fatalError() }
        
        XCTAssertEqual(urlComponents?.percentEncodedQuery, "username=\(expectedUsername)&password=\(expectedPassword)")
    }
    
    func testLogin_CallsResumeOfDataTask() {
        
        let completion = { (error: ErrorType?) in }
        sut.loginUserWithName("dude", password: "1234", completion: completion)
        
        XCTAssertTrue(mockURLSession.dataTask.resumeGotCalled)
    }
    
    func testLogin_SetsToken() {
        
        let mockKeychainManager = MockKechainManager()
        sut.keychainManager = mockKeychainManager
        
        let completion = { (error: ErrorType?) in }
        sut.loginUserWithName("dude", password: "1234", completion: completion)
        
        let responseDict = ["token" : "1234567890"]
        let responseData = try! NSJSONSerialization.dataWithJSONObject(responseDict, options: [])
        mockURLSession.completionHandler?(responseData, nil, nil)
        
        let token = mockKeychainManager.passwordForAccount("token")
        XCTAssertEqual(token, responseDict["token"])
    }
}

extension APIClientTests {
    
    class MockURLSession: TDDToDoURLSession {
        
        typealias Handler = (NSData!, NSURLResponse!, NSError!) -> Void
        
        var completionHandler: Handler?
        var url: NSURL?
        var dataTask = MockURLSessionDataTask()
        
        func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask {
            
            self.url = url
            self.completionHandler = completionHandler
            return dataTask
        }
        
        
    }
    
    class MockURLSessionDataTask: NSURLSessionDataTask {
        var resumeGotCalled = false
        
        override func resume() {
            resumeGotCalled = true
        }
    }
    
    class MockKechainManager: KeychainAccessible {
        var passwordDict = [String: String]()
        
        func setPassword(password: String, account: String) {
            passwordDict[account] = password
        }
        
        func deletePasswordForAccount(account: String) {
            passwordDict.removeValueForKey(account)
        }
        
        func passwordForAccount(account: String) -> String? {
            return passwordDict[account]
        }
    }
}
