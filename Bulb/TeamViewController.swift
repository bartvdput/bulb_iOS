//
//  TeamViewController.swift
//  Bulb
//
//  Created by Bart van de Put on 08/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import UIKit
import Firebase

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: constants
    let cellIdentifier = "CellIdentifierTeam"
    let alertMessage = "Team kon niet worden geladen, heb je een internetverbinding?"
    
    //MARK: variables
    var team: [Teamlid] = []
    var ref: FIRDatabaseReference!
    var group: String = ""
    var cellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (group == "HV") {
            ref = FIRDatabase.database().reference(withPath: "teamledenHV")
        } else if (group == "XL") {
            ref = FIRDatabase.database().reference(withPath: "teamledenXL")
        }
        
        getFirebaseData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //get data from Firebase Database
    func getFirebaseData() {
        var newTeam: [Teamlid] = []
        ref.observe(FIRDataEventType.value, with: { (snapshot) in
            if (snapshot.childrenCount > 0) {
                for child in snapshot.children {
                    let teamlid = Teamlid(snapshot: child as! FIRDataSnapshot)
                    newTeam.append(teamlid)
                }
                
                //reload tableview
                self.team = newTeam
                self.tableView.reloadData()
            } else {
                self.showAlert()
            }            
        })
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
        return team.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = String(describing: team[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellIndex = indexPath.row
        performSegue(withIdentifier: "teamlidSegue", sender: self)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "teamlidSegue") {
            let destView = segue.destination as! TeamlidViewController
            destView.teamlid = team[cellIndex]
        }
    }
    
}
