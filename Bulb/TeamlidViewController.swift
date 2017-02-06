//
//  TeamlidViewController.swift
//  Bulb
//
//  Created by Bart van de Put on 09/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import UIKit
import Firebase

class TeamlidViewController: UIViewController {
    
    @IBOutlet weak var naamLabel: UILabel!
    @IBOutlet weak var telefoonLabel: UITextView!
    @IBOutlet weak var emailLabel: UITextView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var teamlid: Teamlid = Teamlid()
    
    let storage = FIRStorage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set text
        let name = String(describing: teamlid)
        naamLabel.text = name
        telefoonLabel.text = teamlid.telefoonnummer
        emailLabel.text = teamlid.email
        
        //add padding to textviews
        telefoonLabel.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        emailLabel.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        let storageRef = storage.reference(forURL: "gs://bulb-a98b7.appspot.com")
        let url = nameToURL(name: name)
        let imageRef = storageRef.child(url)
        
        imageRef.data(withMaxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Error
                print(error)
            } else {
                let image: UIImage! = UIImage(data: data!)
                self.profilePicture.image = image
            }
        }
        

    }
    
    func nameToURL(name: String) -> String {
        let stringArray =  name.characters.split{$0 == " "}.map(String.init)
        return (stringArray[0] + ".jpg").lowercased()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
