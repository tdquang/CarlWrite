//
//  ShowDetailsController.swift
//  This view contains information specific to an appointment.
//  WritingApp
//
//  Quang Tran
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit

class ShowDetailsController: UIViewController {
    let sharedData = dataFile.sharedInstance
    var appointmentDetails = [String]()
    let formFields = dataFile().returnFormFields()
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Deleting an appointment from the list if the user decides to cancel it
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "cancel" {
            for var index = 0; index < sharedData.listOfAppointments.count; ++index {
                if (sharedData.listOfAppointments[index] == appointmentDetails){
                    sharedData.listOfAppointments.removeAtIndex(index)
                }
            }
        }
    }
    
    // Below are the functions for tableview
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointmentDetails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
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
