//
//  Avond.swift
//  Bulb
//
//  Created by Bart van de Put on 07/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import Foundation
import Firebase

struct Avond : CustomStringConvertible {
    
    let beschrijving: String
    let datum: String
    let starttijd: String
    let titel: String
    
    var description: String {
        return "\(datum) | \(titel)"
    }
    
    init(snapshot: FIRDataSnapshot) {
        let data = snapshot.value as! [String: AnyObject]
        beschrijving = data["beschrijving"] as! String
        datum = data["datum"] as! String
        starttijd = data["starttijd"] as! String
        titel = data["titel"] as! String
    }
    
}
