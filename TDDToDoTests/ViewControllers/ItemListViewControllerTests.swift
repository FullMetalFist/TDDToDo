//
//  ItemListViewControllerTests.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 5/17/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import XCTest
@testable import TDDToDo

class ItemListViewControllerTests: XCTestCase {
    
    var sut: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(sut.tableView?.dataSource)
        XCTAssertTrue(sut.tableView?.dataSource is ItemListDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
}
