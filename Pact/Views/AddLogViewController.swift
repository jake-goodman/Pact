//
//  AddLogViewController.swift
//  Pact
//
//  Created by Jake Goodman on 5/31/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

protocol AddLogViewControllerDelegate: class {
    func addLogViewController(_ viewController: AddLogViewController, didSubmit log: ActivityLog)
}

class AddLogViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var typeSegmentedController: UISegmentedControl!
    
    weak var delegate: AddLogViewControllerDelegate?
    var timeValue:Float = 5.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCancel(_:)))
        view.addGestureRecognizer(backgroundTapGesture)
        view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction @objc func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didSlideTimeSlider(_ sender: Any) {
        timeValue = round(timeSlider.value * 2.0)/2.0
        timeLabel.text = "\(timeValue)h"
        submitButton.isEnabled = timeValue > 0
        submitButton.backgroundColor = submitButton.isEnabled ? .pactBlue : .lightGray
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        guard let participant = APIController.shared.currentParticipant else { return }
        
        let description = (typeSegmentedController.selectedSegmentIndex == 0) ? "\(participant.name) participated in Activity" : "\(participant.name) donated to Cause"
        APIController.shared.createActivityLog(forUser: participant.id, numHours: timeValue, description: description) { (log, error) in
            if error != nil {
                AppUtility.presentSimpleAlert(on: self,
                                              title: "Error",
                                              message: "Failed to submit log",
                                              buttonTitle: "Dismiss")
            }
            else if let log = log {
                self.delegate?.addLogViewController(self, didSubmit: log)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
