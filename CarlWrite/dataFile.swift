//
//  dataFile.swift
//  This file contains all the information from the writing center that the app uses. 
//  WrittingApp
//
//  Quang Tran & Anmol Raina
//  Copyright (c) 2015 Quang Tran. All rights reserved.
//



import UIKit

class dataFile {
    // The code below allows changing this file
    class var sharedInstance: dataFile {
        struct Static {
            static var instance: dataFile?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = dataFile()
        }
        
        return Static.instance!
    }
    
    // Harcoded date. In the future these variables will use the GET command to get data from the Carleton Server
    var listOfAppointments = [[String]]()
    var tutorArray = ["Any Tutor", "Anna", "Dave", "Jeff", "Michael", "Sam"]
    var formFields = ["Date", "Course", "Instructor", "Topic", "Type", "State", "Due Date", "Class year", "Major", "First Visit?", "Copy for Prof?"]
    var paperLengthArray = ["1-2", "3-5", "6-10","11-20","20+"]
    var currentStateArray = ["Brainstorming", "First Draft", "Second Draft", "Final Draft"]
    var paperTypeArray = ["Essay", "Comps", "Resume", "Portfolio", "Application", "Other"]
    var dueDateArray = ["Today", "Tomorrow", "2 days", "3-5 days", "A week", "1 week+"]
    var goalsForVisit = ["Clarity", "Thesis/Flow", "Organization", "Citation", "Brainstorming", "Integrating evidence/support", "Learning how to proofread"]
    var classYearArray = ["2016", "2017", "2018", "2019"]
    var majorArray = ["English", "History", "Philosophy", "Economics", "Computer Science"]
    var yesNoArray = ["Yes", "No"]
    var visitSourceArray = ["Does not apply", "From an instructor", "From orientation", "From an advertisement", "From a student", "Other"]
    var tutorDays = [[1,2,3,4,5,6], [2,4,5], [1,4,6], [2,3], [1,3,5], [1,2,5,6]]
    
    func returnTutorDays(tutorName: String) -> [Int]{
        for var index = 0; index < tutorArray.count; ++index{
            if tutorArray[index] == tutorName{
                return tutorDays[index]
            }
        }
        return []
    }
    
    func returnAppointmentTimes(_: CVCalendarDayView) -> [String]{
        return ["9:00", "9:20", "10:00", "10:20", "11:00", "11:20", "12:00"]
    }
    func returnListOfTutors() -> [String]{
        return tutorArray
    }
    func returnPaperLengths() -> [String]{
        return paperLengthArray
    }
    func returnListOfStates() -> [String]{
        return currentStateArray
    }
    func returnPaperType() -> [String]{
        return paperTypeArray
    }
    func returnDueDate() -> [String]{
        return dueDateArray
    }
    func returnGoalsForVisit() -> [String]{
        return goalsForVisit
    }
    func returnClassYear() -> [String]{
        return classYearArray
    }
    func returnMajor() -> [String]{
        return majorArray
    }
    func returnYesNo() -> [String]{
        return yesNoArray
    }
    func returnVisitSource() -> [String]{
        return visitSourceArray
    }
    func returnFormFields() -> [String]{
        return formFields
    }

    func addAppointment(appointmentDetails: [String]){
        listOfAppointments.append(appointmentDetails)
    }

}
