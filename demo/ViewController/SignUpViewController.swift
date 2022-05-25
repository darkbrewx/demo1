//
//  SignUpViewController.swift
//  demo
//
//  Created by HWB on 2022/5/24.
//

import UIKit
import SQLite

class SignUpViewController: UIViewController ,UITextFieldDelegate {
    
    var database: Connection!
    
    let usersTable = Table("users")
    let id = Expression<Int>("id")
    let firstName = Expression<String?>("firstName")
    let lastName = Expression<String?>("lastName")
    let email = Expression<String?>("email")
    let password = Expression<String?>("password")


    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // Variable to store the location of the SQLite DB
//    var dbUrl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        
        configureTextFields()
        setUpElements()
    }
    
    private func configureTextFields(){
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    @IBAction func SignUpTapped(_ sender: Any) {
        signUpUser()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func setUpElements() {
    
        // Hide the error label
        errorLabel.alpha = 0
    
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)

    }
    
    func signUpUser(){
        
        guard let firstName: String = firstNameTextField.text.self, !firstName.isEmpty
                ,let lastName: String = lastNameTextField.text.self, !lastName.isEmpty
                ,let email: String = emailTextField.text.self, !email.isEmpty
                ,let password: String = passwordTextField.text.self, !password.isEmpty
        else {
            let alert = UIAlertController(title: "can not be empty", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "Submit", style: .default)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        print(firstName)
        
        let insertUser = self.usersTable.insert(
            self.firstName <- firstName
            ,self.lastName <- lastName
            ,self.email <- email
            ,self.password <- password
        )
        print(insertUser)
        
        print(firstName)
        do{
            try self.database.run(insertUser)
        } catch {
            print(error)
        }
        
        do{
            let users = try self.database.prepare(self.usersTable)
            for user in users{
                print("firstname:\(user[self.email])")
            }
        } catch {
            print(error)
        }
        
    }
}

