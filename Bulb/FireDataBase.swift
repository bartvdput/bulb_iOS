//
//  FireDataBase.swift
//  Bulb
//
//  Created by Bart van de Put on 07/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import Foundation
import Firebase

class FireDataBase {
    
    let ref: FIRDatabaseReference!
    let selection: String
    
    init(selection: String) {
        self.selection = selection
        ref = FIRDatabase.database().reference(withPath: selection)
        
        if (selection == "avondenHV" || selection == "avondenXL") {
            getAvonden(selection: selection)
        }
        if (selection == "teamHV" || selection == "teamXL") {
            getTeam(selection: selection)
        }
    }
    
    // get avonden from Firebase Database
    func getAvonden(selection: String) {
        ref.observe(FIRDataEventType.value, with: { (snapshot) in
            print(snapshot.value)
        })
    }
    
    // get team from Firebase Database
    func getTeam(selection: String) {
    
    }
    
    
}
