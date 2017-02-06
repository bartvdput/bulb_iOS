//
//  Teamlid.swift
//  Bulb
//
//  Created by Bart van de Put on 08/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import Foundation
import Firebase

struct Teamlid : CustomStringConvertible {
    
    let voornaam: String
    let achternaam: String
    let email: String
    let telefoonnummer: String
    let plaatje: String
    
    var description: String {
        return "\(voornaam) \(achternaam)"
    }
    
    init(voornaam: String, achternaam: String, email: String, telefoonnummer: String, plaatje: String) {
        self.voornaam = voornaam
        self.achternaam = achternaam
        self.email = email
        self.telefoonnummer = telefoonnummer
        self.plaatje = plaatje
    }
    
    init(){
        self.voornaam = "test"
        self.achternaam = "test"
        self.email = "test"
        self.telefoonnummer = "test"
        self.plaatje = "test"
    }
    
    init(snapshot: FIRDataSnapshot) {
        let data = snapshot.value as! [String: AnyObject]
        voornaam = data["voornaam"] as! String
        achternaam = data["achternaam"] as! String
        email = data["email"] as! String
        telefoonnummer = data["telefoonnummer"] as! String
        plaatje = data["plaatje"] as! String
    }
    
    /*
     func toAnyObject() -> Any {
     return [
     "beschrijving": beschrijving,
     "datum": datum,
     "starttijd": starttijd,
     "titel": titel
     ]
     }
     */
    
}

