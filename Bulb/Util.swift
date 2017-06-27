//
//  Util.swift
//  Bulb
//
//  Created by Bart van de Put on 27/06/17.
//  Copyright © 2017 Bart van de Put. All rights reserved.
//

import AVFoundation
import UIKit

// show alert message
func showAlert(alertMessage: String, view: UIViewController){
    let alertController = UIAlertController(title: "Oops!", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
    let defaultAction = UIAlertAction(title: "Sluiten", style: .default, handler: nil)
    
    alertController.addAction(defaultAction)
    view.present(alertController, animated:true, completion: nil)
}
