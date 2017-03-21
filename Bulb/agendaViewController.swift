//
//  agendaViewController.swift
//  Bulb
//
//  Created by Bart van de Put on 07/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import UIKit
import Firebase

class agendaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: constants
    let cellIdentifier = "CellIdentifier"
    let alertMessage = "Agenda kon niet worden geladen, heb je een internetverbinding?"
    
    //MARK: variables
    var avonden: [Avond] = []
    var ref: FIRDatabaseReference!
    var group: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (group == "HV") {
            ref = FIRDatabase.database().reference(withPath: "avondenHV")
        } else if (group == "XL") {
            ref = FIRDatabase.database().reference(withPath: "avondenXL")
        }
        
        getFirebaseData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //get data from Firebase Database
    func getFirebaseData() {
        var newAvonden: [Avond] = []
        ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if (snapshot.childrenCount > 0){
                for child in snapshot.children {
                    let avond = Avond(snapshot: child as! FIRDataSnapshot)
                    newAvonden.append(avond)
                }
                
                //reload tableview
                self.avonden = newAvonden
                self.tableView.reloadData()
                self.nextBulb()
            } else {
                self.showAlert()
            }
        })
    }
    
    func nextBulb() {
        // get current date
        let currentDate = NSDate()
        print("CURRENTDATE", currentDate)
        
        // disregard time
        let today = NSCalendar.current.startOfDay(for: currentDate as Date)
        print("TODAY", today)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        for (index,avond) in avonden.enumerated() {
            let avondDate = dateFormatter.date(from: avond.datum)
            if (today.compare(avondDate!) == ComparisonResult.orderedSame || today.compare(avondDate!) == ComparisonResult.orderedAscending) {
                // scroll to first bulb event
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
                break
            }
        }
    }
    
    // show alert message
    func showAlert(){
        let alertController = UIAlertController(title: "Oops!", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "Sluiten", style: .default, handler: nil)
        
        let retryHandler = { (action:UIAlertAction!) -> Void in
            self.getFirebaseData()
        }
        
        let retryAction = UIAlertAction(title: "Probeer opnieuw", style: .default, handler: retryHandler)
        
        alertController.addAction(defaultAction)
        alertController.addAction(retryAction)
        
        present(alertController, animated:true, completion: nil)
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avonden.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = String(describing: avonden[indexPath.row])
        
        return cell
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
