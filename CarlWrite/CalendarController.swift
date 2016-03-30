//
//  CalendarController.swift
//  Contorller responsible for the calendar
//  NOTE: we couldn't implement the feature where changign tutor in the textfield would also change the dates circled in blue. 
//  The reason is that the library we used for the calendar currently does not support that function for 8.3. 
//  Therefore, changing the tutor in the text field does not do anything at the moment.
//  WritingApp
//
//  Quang Tran & Anmol Raina
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//

import UIKit


class CalendarController: UIViewController, UIPickerViewDelegate {
    // MARK: - Properties

    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tutorField: UITextField!

    //Getting list of tutors
    let tutor = dataFile().returnListOfTutors()


    var shouldShowDaysOut = false
    var animationFinished = true
    var dateString = ""
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        tutorField.text = tutor[0]
        
        monthLabel.text = CVDate(date: NSDate()).globalDescription
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    // prepareForSegue function that passes the date to the form controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showForm" {
            if let destinationVC = segue.destinationViewController as? FormViewController{
                destinationVC.dateToDisplay = self.dateString
            }
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    // Functions to create a pop-up picker
    @IBAction func itemPicker(sender: UITextField) {
        ActionSheetStringPicker.showPickerWithTitle("Pick a Tutor", rows: tutor, initialSelection: 1, doneBlock: {
            picker, value, index in
            sender.text = self.tutor[value]
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    func timePicker(dayView: CVCalendarDayView) {
        ActionSheetStringPicker.showPickerWithTitle("Pick a Time Slot", rows: dataFile().returnAppointmentTimes(dayView), initialSelection: 1, doneBlock: {
            picker, value, index in
            self.dateString = "\(dayView.date.commonDescription), \(dataFile().returnAppointmentTimes(dayView)[value])"
            self.performSegueWithIdentifier("showForm", sender: nil)
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: dayView)
    }

    

}

// MARK: - CVCalendarViewDelegate

extension CalendarController: CVCalendarViewDelegate
{
    // Bellow is the code to create blue circles given particular days
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = .blueColor()
        
        let newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    // Right now the controller circles random dates
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        let workingDays = dataFile().returnTutorDays(tutorField.text!)
        if (Int(arc4random_uniform(5)) == 1)
        {
            return true
        }
        return false
    }
}


extension CalendarController {
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    // This function gets called when a user clicks on a date. Creates a picker, and then if the user chooses a date, go to a next controller
    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        timePicker(dayView)
    }
    
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity
                
                }) { _ in
                    
                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
}
// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarController: CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}

// MARK: - CVCalendarMenuViewDelegate

extension CalendarController: CVCalendarMenuViewDelegate {
    // firstWeekday() has been already implemented.
}

// MARK: - IB Actions

extension CalendarController {
    
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
        calendarView.commitCalendarViewUpdate()
    }
    
}

// MARK: - Convenience API Demo

extension CalendarController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        let calendar = NSCalendar.currentCalendar()
        let calendarManager = calendarView.manager
        let components = Manager.componentsForDate(NSDate()) // from today
        
        components.month += offset
        
        let resultDate = calendar.dateFromComponents(components)!
        
        self.calendarView.toggleViewWithDate(resultDate)
    }
}