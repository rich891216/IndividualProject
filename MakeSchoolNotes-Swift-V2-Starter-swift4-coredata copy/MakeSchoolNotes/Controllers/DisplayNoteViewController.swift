//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//
import Foundation
import UIKit

class DisplayNoteViewController: UIViewController, TransferNoteDelegate {
    var name: String = ""
    
    
    @IBOutlet weak var noteTitleNavigationItem: UINavigationItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var writingSessionTimeLabel: UILabel!
    @IBOutlet weak var timeLeftToTypeTimeLabel: UILabel!
    @IBOutlet weak var startSessionButtonTapped: UIButton!
    @IBAction func testingButton(_ sender: UIButton) {
        startTimer()
        startSessionButtonTapped.isEnabled = false
    }
    
    
    
   

    
    
    //let textDidBeginEditingNotification: NSNotification.Name
    
    
    //func controlTextDidBeginEditing(_ obj: Notification){
    //    startTimer()
    //}
    
    var message=""
    var countdownTimer: Timer!
    var totalTime = 300.0
    var repeatingTime = 5.0
    
    var note: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        //controlTextDidBeginEditing(<#T##obj: Notification##Notification#>)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
            noteTitleNavigationItem.title = note.title
        }
        else{
            contentTextView.text = ""
            contentTextView.textColor = UIColor.black
            titleTextField.text = ""
        }
        
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
      
        
        if repeatingTime > 0 && totalTime > 0 {
            if message == contentTextView.text {
                repeatingTime -= 0.1
                repeatingTime = Double(Int(repeatingTime * 10)) / 10.0
            }
            else {
                repeatingTime = 5.0
            }
            totalTime -= 0.1
        } else {
            endTimer()
            if repeatingTime <= 0 {
                performSegue(withIdentifier: "showFailedResultViewController", sender: self)
            } else if totalTime <= 0 {
                performSegue(withIdentifier: "showSuccessResultViewController", sender: self)
            }
        }
        message=contentTextView.text
        writingSessionTimeLabel.text = "Time left in writing session: \(timeFormatted(totalTime))"
        timeLeftToTypeTimeLabel.text = "Seconds left to type: \(repeatingTime)"
      
    }
    func endTimer() {
        countdownTimer.invalidate()
    }
    func timeFormatted(_ totalSeconds: Double) -> String {
        let seconds: Int = Int(totalTime) % 60
        let minutes: Int = Int (totalTime / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier{
        
            
        case "showSuccessResultViewController" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? "Untitled Document"
            note.content = contentTextView.text ?? "No Content"
            note.modificationTime = Date()
            
            guard let destination = segue.destination as? FinishedResultViewController
                else {return}
            destination.delegate = self
            destination.note = note
        case "showFailedResultViewController" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? "Untitled Document"
            note.content = contentTextView.text ?? "No Content"
            note.modificationTime = Date()
            
            guard let destination = segue.destination as? FailedResultsViewController
                else {return}
            destination.delegate = self
            destination.note = note
            
        case "cancel":
            print ("cancel bar button tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
    func getMessage () -> String {
        return message
    }
    func getTitle () -> String {
        return titleTextField.text!
    }
}


