//
//  ItemCellTests.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 8/14/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import XCTest
@testable import TDDToDo



class ItemCellTests: XCTestCase {
    
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    
    let fakeDataSource = FakeDataSource()
    var controller: ItemListViewController!
    let toDoItem = ToDoItem(title: "First", itemDescription: "Home", timestamp: 1456150025, location: Location(name: "Home")
    )
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        
        
        tableView = controller.tableView
        tableView.dataSource = fakeDataSource
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSUT_HasNameLabel() {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testSUT_HasLocationLabel() {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testSUT_HasDateLabel() {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testConfigWithItem_SetsTitle() {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        cell.configCellWithItem(ToDoItem(title: "First"))
        XCTAssertEqual(cell.titleLabel!.text, "First")
    }
    
    func testConfigWithItem_SetsLabelTexts() {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        cell.configCellWithItem(ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home")))
        XCTAssertEqual(cell.titleLabel?.text, "First")
        XCTAssertEqual(cell.locationLabel?.text, "Home")
        XCTAssertEqual(cell.dateLabel?.text, "02/22/2016")
    }
    
    func testTitle_ForCheckedTasks_IsStrokeThrough() {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: NSIndexPath(forRow: 0, inSection: 0)) as! ItemCell
        cell.configCellWithItem(toDoItem, checked: true)
        
        let attributedString = NSAttributedString(string: "First", attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func  tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}