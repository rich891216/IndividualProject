//
//  FailedResultsViewController.swift
//  MakeSchoolNotes
//
//  Created by Richard Wang on 7/30/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class FailedResultsViewController : UIViewController {
    
    
    
    
    
    var delegate: TransferNoteDelegate?
    var note : Note?
    @IBAction func failedSaveButton(_ sender: UIButton) {
       
        CoreDataHelper.saveNote()
    }
    @IBAction func failedDiscardButton(_ sender: UIButton) {
        CoreDataHelper.delete(note: note!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
