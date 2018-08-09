//
//  TransferNoteDelegate.swift
//  MakeSchoolNotes
//
//  Created by Richard Wang on 8/2/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation

protocol TransferNoteDelegate {
    var message: String {get set}
    var name: String {get set}
    func getMessage () -> String
    func getTitle () -> String
    
    
}
