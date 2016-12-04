//
//  ItemListViewController.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 5/17/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    let itemManager = ItemManager()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate>!
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
    
    @IBAction func addItem(sender: UIBarButtonItem) {
        if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("InputViewController") as? InputViewController {
            nextViewController.itemManager = self.itemManager
            presentViewController(nextViewController, animated: true, completion: nil)
        }
    }
}
