//
//  Database.swift
//  demo
//
//  Created by HWB on 2022/5/24.
//

import Foundation
import SQLite3
import UIKit

class Database {
    init(){
    do {
        let db = try Connection("path/to/db.sqlite3")

        let users = Table("users")
    } catch {
        print(error)
    }
    }
}
