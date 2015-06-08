//
//  ShowDetailsController.swift
//  WritingApp
//
//  Created by Quang Tran Dang on 31.05.15.
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit

class ShowDetailsController: UIViewController {

    var appointmentDetails = [String]()
    let formFields = dataFile().returnFormFields()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tableView: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentDetails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = ("\(formFields[indexPath.row]): \(self.appointmentDetails[indexPath.row])")
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
