//
//  KeychainAccessible.swift
//  TDDToDo
//
//  Created by Michael Vilabrera on 11/25/16.
//  Copyright © 2016 Michael Vilabrera. All rights reserved.
//

import Foundation

protocol KeychainAccessible {
    func setPassword(password: String, account: String)
    func deletePasswordForAccount(account: String)
    func passwordForAccount(account: String) -> String?
}
