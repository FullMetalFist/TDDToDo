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
    @IBOutlet var dataProvider: protocol<UITableViewDataSource, UITableViewDelegate, ItemManagerSettable>!
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider.itemManager = itemManager
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showDetails(_:)), name: "ItemSelectedNotification", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func addItem(sender: UIBarButtonItem) {
        if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("InputViewController") as? InputViewController {
            nextViewController.itemManager = self.itemManager
            presentViewController(nextViewController, animated: true, completion: nil)
        }
    }
    
    func showDetails(sender: NSNotification) {
        guard let index = sender.userInfo?["index"] as? Int else { fatalError() }
        
        if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as? DetailViewController {
            
            nextViewController.itemInfo = (itemManager, index)
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
