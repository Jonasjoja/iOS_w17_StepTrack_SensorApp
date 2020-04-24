//
//  ViewController.swift
//  healthApp
//
//  Created by admin on 24/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var stepCount: UILabel!
    
    @IBOutlet weak var distanceCount: UILabel!
    
    @IBOutlet weak var paceCount: UILabel!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    let pedometer = CMPedometer() //Pedometer for detection
    
    var isStarted = false //Bool to keep track of state
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stepCount.text = "Steps: 0"
        distanceCount.text = "Distance: 0"
        paceCount.text = "Pace: 0"
        
        startStopButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        startStopButton.setTitle("Start your tracking!", for: .normal) //Initial text
       
       
    }
    

    @IBAction func trackingButtonPressed(_ sender: UIButton) {
        if isStarted{
            startStopButton.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            startStopButton.setTitle("Start your tracking!", for: .normal)
            isStarted = false
            pedometer.stopUpdates()
        } else {
            startStopButton.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            startStopButton.setTitle("Stop your tracking!", for: .normal)
            
            isStarted = true
            
            pedometer.startUpdates(from: Date()) { (data, error) in
                DispatchQueue.main.async {
                    self.stepCount.text = "Steps: \(data?.numberOfSteps ?? 0.0)"
                    self.distanceCount.text = "Distance \(data?.distance?.intValue ?? 0) m"
                    self.paceCount.text = "Pace: \(((data?.currentPace?.doubleValue ?? 0.0) * 3.6).rounded()) km/t"
                }
            }
            
        }
        
    }
    
}

