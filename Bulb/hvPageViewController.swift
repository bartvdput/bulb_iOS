//
//  hvPageViewController.swift
//  Bulb
//
//  Created by Bart van de Put on 05/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import UIKit
import Firebase

class hvPageViewController: UIViewController {
    
    //MARK: outlets
    @IBOutlet weak var agendaButton: UIImageView!
    
    //MARK: constants
    let group = "HV"
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Firebase Database reference
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "agendaHVSegue") {
            let destView = segue.destination as! agendaViewController
            destView.group = "HV"
        } else if (segue.identifier == "teamHVSegue") {
            let destView2 = segue.destination as! TeamViewController
            destView2.group = "HV"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
