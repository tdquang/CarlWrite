//
//  ViewController.swift
//  WritingApp
//
//  Created by Quang Tran Dang on 07.05.15.
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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

    
    
    @IBAction func login(sender: AnyObject) {
        var user:NSString = username.text as NSString
        var pass:NSString = password.text as NSString
        var confirm_password = "123"
        if ( user.isEqualToString("") || pass.isEqualToString("") ) {
            
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if ( !pass.isEqual(confirm_password) ) {
            
            var alertView:UIAlertView = UIAlertView()
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

