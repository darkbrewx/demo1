//
//  ViewController.swift
//  demo
//
//  Created by HWB on 2022/5/24.
//

import UIKit
import SQLite


class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var database: Connection!
    
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let firstName = Expression<String?>("firstName")
    let lastName = Expression<String?>("lastName")
    let email = Expression<String?>("email")
    let password = Expression<String?>("password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        // create usertable
        createTable()
    }
    
    func createTable(){
        
        let createTable = self.usersTable.create{ (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.firstName)
            table.column(self.lastName)
            table.column(self.email, unique: true)
            table.column(self.password)
        }
        
        do {
            // create table
            try self.database.run(createTable)
        }catch {
            // table already exsited
            print(error)
        }
        
    }
    
    
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

    @IBAction func signUpTapped(_ sender: Any) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    }
}

