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
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var typeSegmentedController: UISegmentedControl!
    @IBOutlet weak var dateButton: UIButton!
    
    weak var delegate: AddLogViewControllerDelegate?
    var log: ActivityLog? {
        didSet {
            timeValue = log?.numHours ?? 5.0
            logDate = log?.dateLogged
        }
    }
    var timeValue:Float = 5.0
    var logDate: Date? = Date()
    var mode: Mode = .create
    
    enum Mode {
        case create, update
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCancel(_:)))
//        view.addGestureRecognizer(backgroundTapGesture)
        view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        
        contentView.isUserInteractionEnabled = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let log = log {
            timeValue = log.numHours
            logDate = log.datePerformed
            submitButton.setTitle("Update", for: .normal)
            
        }
        timeLabel.text = "\(timeValue)h"
        timeSlider.value = timeValue
        updateDateString()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDateString() {
        if let date = logDate {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d YYYY") // set template after setting locale
            let dateString = dateFormatter.string(from: date)
            dateButton.setTitle(dateString, for: .normal)
        }
        else {
            dateButton.setTitle("No Date Set", for: .normal)
        }

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
    
    @IBAction func didTapDate(_ sender: Any) {
        let alert = UIAlertController(style: .actionSheet, title: "Select date")
        alert.addDatePicker(mode: .date, date: logDate) { date in
            // action with selected date
            self.logDate = date
            self.updateDateString()
        }
        alert.addAction(title: "OK", style: .cancel)
        alert.addAction(title: "Ignore Date", style: .destructive,  handler: {alert in
            self.logDate = nil
            self.updateDateString()
        })
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        guard let participant = APIController.shared.currentParticipant else { return }
        
        let description = (typeSegmentedController.selectedSegmentIndex == 0) ? "\(participant.name) participated in Activity" : "\(participant.name) donated to Cause"
        APIController.shared.createActivityLog(forUser: participant.id, numHours: timeValue, description: description, date: logDate) { (log, error) in
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
