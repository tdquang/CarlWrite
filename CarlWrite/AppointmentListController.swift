//
//  AppointmentListController.swift
//  WritingApp
//
//  Created by Quang Tran Dang on 08.05.15.
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit

class AppointmentListController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButton: UIButton!

    @IBOutlet weak var tableView: UITableView!
    
    let appointments = dataFile().listOfAppointments
    var detailsToShow = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        addButton.layer.cornerRadius = 3
        addButton.layer.borderWidth = 1
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        for item in appointments{
            println(item[0])
        }
    }

        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointments.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = self.appointments[indexPath.row][0]
        cell.contentView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        detailsToShow = appointments[indexPath.row]
        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.clearColor()
        self.performSegueWithIdentifier("showDetails", sender: nil)
        selectedCell.backgroundColor = UIColor.clearColor()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            if let destinationVC = segue.destinationViewController as? ShowDetailsController{
                destinationVC.appointmentDetails = detailsToShow
            }
        }
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
