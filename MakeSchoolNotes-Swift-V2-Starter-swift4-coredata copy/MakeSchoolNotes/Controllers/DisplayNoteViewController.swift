//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//
import Foundation
import UIKit

class DisplayNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitleNavigationItem: UINavigationItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var writingSessionLabel: UILabel!
    @IBOutlet weak var timeLeftToTypeLabel: UILabel!
    @IBOutlet weak var writingSessionTimeLabel: UILabel!
    @IBOutlet weak var timeLeftToTypeTimeLabel: UILabel!
    @IBAction func testingButton(_ sender: UIButton) {
        startTimer()
    }
    

    
    
    var message=""
    var countdownTimer: Timer!
    var totalTime = 300
    var repeatingTime = 5
    
    var note: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
            noteTitleNavigationItem.title = note.title
        }
        else{
        titleTextField.text = ""
        contentTextView.text = ""
        }
        
    }
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
        writingSessionTimeLabel.text = "\(timeFormatted(totalTime))"
        timeLeftToTypeTimeLabel.text = "\(repeatingTime)"
        
        if totalTime != 0 && repeatingTime != 0{
            if message == contentTextView.text {
                repeatingTime -= 1
            }
            else {
                repeatingTime = 5
            }
            totalTime -= 1
        } else {
            endTimer()
        }
        message=contentTextView.text
    }
    func endTimer() {
        countdownTimer.invalidate()
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalTime % 60
        let minutes: Int = (totalTime / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier{
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()
            
            CoreDataHelper.saveNote()
        case "cancel":
            print ("cancel bar button tapped")
            
        default:
            print("unexpected segue identifier")
        }
    }
}


