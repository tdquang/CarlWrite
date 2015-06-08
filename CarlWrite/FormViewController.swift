//
//  FormViewController.swift
//  WrittingApp
//
//  Created by mobiledev on 5/31/15.
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    
    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var instructor: UITextField!
    @IBOutlet weak var topic: UITextField!
    @IBOutlet weak var paperType: UITextField!
    @IBOutlet weak var currentState: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var classYear: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var copyForProf: UITextField!
    @IBOutlet weak var firstVisit: UITextField!

    @IBOutlet weak var goalsTable: UITableView!
    @IBOutlet weak var visitSourceTable: UITableView!
    
    
    let paperTypeArray = dataFile().returnPaperType()
    let classYearArray = dataFile().returnClassYear()
    let dueDateArray = dataFile().returnDueDate()
    let majorArray = dataFile().returnMajor()
    let yesNoArray = dataFile().returnYesNo()
    let lengthArray = dataFile().returnPaperLengths()
    let currentStateArray = dataFile().returnListOfStates()
    let goalsTableArray = dataFile().returnGoalsForVisit()
    let visitSourceTableArray = dataFile().returnVisitSource()

    let textCellIdentifier1 = "TextCell1"
    let textCellIdentifier2 = "TextCell2"
    
    var dateToDisplay = ""
    var selectedRow = [Int]()
    var holdDataArray = [String]()
    var visitSource = ""
    @IBOutlet weak var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        scrollView.contentSize = CGSize(width: 1000, height: 10000)
        self.goalsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.goalsTable.scrollEnabled = false
        self.visitSourceTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        classYear.text = classYearArray[0]
        major.text = majorArray[0]
        copyForProf.text = yesNoArray[1]
        firstVisit.text = yesNoArray[1]
        dueDate.text = dueDateArray[0]
        currentState.text = currentStateArray[0]
        paperType.text = paperTypeArray[0]

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "submitForm" {
            dataFile().addAppointment([dateToDisplay, course.text, instructor.text, topic.text, paperType.text, currentState.text, classYear.text, major.text, firstVisit.text, copyForProf.text])
        }
        print(dataFile().listOfAppointments.count)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == goalsTable){
            return goalsTableArray.count
        }
        else {
            return visitSourceTableArray.count
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        if(tableView == goalsTable){
            let cell = self.goalsTable.dequeueReusableCellWithIdentifier(textCellIdentifier1, forIndexPath: indexPath) as! UITableViewCell
            let row = indexPath.row
            cell.textLabel?.text = goalsTableArray[row]
            if (contains(self.selectedRow, row)){
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            return cell
        }
        else {
            let cell = self.visitSourceTable.dequeueReusableCellWithIdentifier(textCellIdentifier2, forIndexPath: indexPath) as! UITableViewCell
            let row = indexPath.row
            cell.textLabel?.text = visitSourceTableArray[row]
            return cell
        }
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(tableView == goalsTable){
            goalsTable.deselectRowAtIndexPath(indexPath, animated: true)
            let row = indexPath.row
            holdDataArray.append(goalsTableArray[row])
            println(goalsTableArray[row])
            if (contains(self.selectedRow, row)){
                for var index = 0; index < self.selectedRow.count; ++index{
                    if (self.selectedRow[index] == row){
                        self.selectedRow.removeAtIndex(index)
                    }
                }
            }
            else{
                self.selectedRow.append(row)
            }
            print(self.selectedRow)
            tableView.reloadData()
        }
        else if(tableView == visitSourceTable){
            visitSourceTable.deselectRowAtIndexPath(indexPath, animated: true)
            let row = indexPath.row
            visitSource = visitSourceTableArray[row]
            println(visitSourceTableArray[row])
        }
    }

    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func paperStatePicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Paper State", rows: currentStateArray, initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = dataFile().returnListOfStates()[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func paperTypePicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Paper Type", rows: paperTypeArray, initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = dataFile().returnPaperType()[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }

    @IBAction func paperDueDatePicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Due Date", rows: dueDateArray, initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = self.dueDateArray[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func classYearPicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Class Year", rows: classYearArray, initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = self.classYearArray[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func majorPicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Your Major", rows: majorArray, initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = self.majorArray[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func firstVisitPicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("First Visit?", rows: ["Yes", "No"], initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = ["Yes", "No"][value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func copyForProfPicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Send a Copy?", rows: ["Yes", "No"], initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = ["Yes", "No"][value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
}
