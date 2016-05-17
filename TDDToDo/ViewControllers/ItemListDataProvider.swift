//
//  ItemListDataProvider.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 5/17/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
