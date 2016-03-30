//
//  ViewController.swift
//  Initial login screen
//  WritingApp
//
//  Quang Tran & Anmol Raina
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // username and password textfields
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // IBAction function gets called on loging button
    // In the future, this app will call the Carleton Server to confirm usernam and password. Right now the app lets you login as long as the password is 123
    @IBAction func login(sender: AnyObject) {
        let user:NSString = username.text! as NSString
        let pass:NSString = password.text! as NSString
        let confirm_password = "123"
        if ( user.isEqualToString("") || pass.isEqualToString("") ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if ( !pass.isEqual(confirm_password) ) {
            
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Passwords doesn't Match"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
        self.performSegueWithIdentifier("login_success", sender: self)
        }
        
    }
    
    
    
}

