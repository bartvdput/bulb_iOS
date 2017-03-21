//
//  xlPageViewController.swift
//  Bulb
//
//  Created by Bart van de Put on 05/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import UIKit

class xlPageViewController: UIViewController {
    
    @IBOutlet weak var agendaButton: UIImageView!
    
    let group = "XL"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "agendaXLSegue") {
            let destView = segue.destination as! agendaViewController
            destView.group = "XL"
        } else if (segue.identifier == "teamXLSegue") {
            let destView2 = segue.destination as! TeamViewController
            destView2.group = "XL"
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
