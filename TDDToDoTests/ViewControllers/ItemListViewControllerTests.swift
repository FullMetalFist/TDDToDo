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
    
    func testItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as? UIViewController, sut)
    }
    
    func testAddItem_PresentsAddItemViewController() {
        
        XCTAssertNil(sut.presentedViewController)
        
        guard let addButton = sut.navigationItem.rightBarButtonItem else {
            XCTFail()
            return
        }
        UIApplication.sharedApplication().keyWindow?.rootViewController = sut
        sut.performSelector(addButton.action, withObject: addButton)
        
        presentInputViewController(sut.presentedViewController!)
//        XCTAssertNotNil(sut.presentedViewController)
//        XCTAssertTrue(sut.presentedViewController is InputViewController)
        
        let inputViewController = sut.presentedViewController as! InputViewController
        XCTAssertNotNil(inputViewController.titleTextField)
    }
    
    func testItemListVC_SharesItemManagerWithInputVC() {
        
        XCTAssertNil(sut.presentedViewController)
        
        guard let addButton = sut.navigationItem.rightBarButtonItem else {
            XCTFail()
            return
        }
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = sut
        
        sut.performSelector(addButton.action, withObject: addButton)
        presentInputViewController(sut.presentedViewController!)
//        XCTAssertNotNil(sut.presentedViewController)
//        XCTAssertTrue(sut.presentedViewController is InputViewController)
        
        let inputViewController = sut.presentedViewController as! InputViewController
        
        guard let inputItemManager = inputViewController.itemManager else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(sut.itemManager === inputItemManager)
    }
    
    func presentInputViewController(viewController: UIViewController) {
        XCTAssertNotNil(viewController)
        XCTAssertTrue(viewController is InputViewController)
    }
}
