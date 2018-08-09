//
//  FinishedResultViewController.swift
//  MakeSchoolNotes
//
//  Created by Richard Wang on 7/30/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit

class FinishedResultViewController : UIViewController {
    var delegate: TransferNoteDelegate?
    var note : Note?
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {

        CoreDataHelper.saveNote()
    }
    @IBAction func discardButtonTapped(_ sender: UIButton) {
        
        CoreDataHelper.delete(note: note!)
    }
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //animation to congradulate user
    
   
    
    
}
