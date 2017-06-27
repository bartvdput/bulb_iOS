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
    
    var currentDate: NSDate!
    var today: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get current date
        self.currentDate = NSDate()
        
        // disregard time
        self.today = NSCalendar.current.startOfDay(for: currentDate as Date)
        
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
                
                self.avonden = newAvonden
                self.tableView.reloadData()
                self.nextBulb()
            } else {
                showAlert(alertMessage: self.alertMessage, view: self)
            }
        })
    }
    
    func nextBulb() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        for (index, avond) in avonden.enumerated() {
            let avondDate = dateFormatter.date(from: avond.datum)
            if (today.compare(avondDate!) == ComparisonResult.orderedSame || today.compare(avondDate!) == ComparisonResult.orderedAscending) {
                // scroll to first bulb event
                let indexPath = IndexPath(row: index, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
                
                /* change upcoming event background color
                let upcomingCell = tableView.cellForRow(at: indexPath)
                upcomingCell?.backgroundColor = UIColor.lightGray
                */
                
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avonden.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if(indexPath.row == 11 && indexPath.section == 0) {
            self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
            cell.backgroundColor = UIColor.lightGray
        }
        cell.textLabel?.text = String(describing: avonden[indexPath.row])
        
        return cell
    }
}
