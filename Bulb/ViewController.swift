//
//  ViewController.swift
//  Bulb
//
//  Created by Bart van de Put on 07/10/16.
//  Copyright © 2016 Bart van de Put. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var bulbLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.toggleFlash))
        bulbLogo.isUserInteractionEnabled = true
        bulbLogo.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleFlash() {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        if (device != nil) {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureTorchMode.on) {
                    device?.torchMode = AVCaptureTorchMode.off
                    // change bulb image to OFF
                    bulbLogo.image = #imageLiteral(resourceName: "bulb_icon")
                } else {
                    do {
                        try device?.setTorchModeOnWithLevel(1.0)
                        //change bulb image to ON
                        bulbLogo.image = #imageLiteral(resourceName: "bulb_on")
                    } catch {
                        print(error)
                    }
                }
                device?.unlockForConfiguration()
            } catch {
                print (error)
            }
        } else { print ("No device found!") }
    }
}

