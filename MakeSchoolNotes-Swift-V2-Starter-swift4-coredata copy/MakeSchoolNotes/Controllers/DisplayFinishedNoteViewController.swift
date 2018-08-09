//
//  DisplayFinishedNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Richard Wang on 8/3/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class DisplayFinishedNoteViewController : UIViewController{
    @IBOutlet weak var myNoteLabel: UINavigationItem!
    @IBOutlet weak var myNoteContent: UITextView!
    
    var note : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        

        if let note = note {
            myNoteLabel.title = note.title
            myNoteContent.text = note.content
            
        } else {
            myNoteLabel.title = "Untitled Document"
            myNoteContent.text = "No content"
        }
        
    }
    
    
    
}
