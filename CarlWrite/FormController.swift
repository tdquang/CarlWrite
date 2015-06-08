//
//  FormController.swift
//  WrittingApp
//
//  Created by Quang Tran Dang on 24.05.15.
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit

class FormController: UIViewController, UIPickerViewDelegate {

    var count = 0
    var dateToDisplay = ""
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var instructorField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var paperType: UITextField!
    @IBOutlet weak var currentState: UITextField!
    @IBOutlet weak var paperLength: UITextField!
        
    let lengthArray = dataFile().returnPaperLengths()
    let currentStateArray = dataFile().returnListOfStates()
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        paperLength.text = dataFile().returnPaperLengths()[0]
        currentState.text = dataFile().returnListOfStates()[0]
        paperType.text = dataFile().returnPaperType()[0]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "submitForm" {
            if let destinationVC = segue.destinationViewController as? AppointmentListController{
                destinationVC.appointments.append([dateToDisplay, instructorField.text, typeField.text, paperType.text, currentState.text, paperLength.text])
            }
        }
        println(dateToDisplay)
    }
    
    @IBAction func paperLengthPicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Paper Length", rows: dataFile().returnPaperLengths(), initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = dataFile().returnPaperLengths()[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func paperStatePicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Paper State", rows: dataFile().returnListOfStates(), initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = dataFile().returnListOfStates()[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func paperTypePicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Choose Paper Type", rows: dataFile().returnPaperType(), initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = dataFile().returnPaperType()[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    

    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    

    
    
    func writeValueBack(value: String) {
        currentState.text = value
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
    }
    
    
    //Ppup view code ends
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

}
