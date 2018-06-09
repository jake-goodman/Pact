//
//  ActivityViewController.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var logs: [ActivityLog] = []
    
    override func viewDidLoad() {
        guard let participant = APIController.shared.currentParticipant else { return }
        super.viewDidLoad()
        title = "Your Activity"
        
        tableView.register(UINib(nibName: "ActivityLogCell", bundle: nil), forCellReuseIdentifier: "LogCell")
        tableView.register(UINib(nibName: "ProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "ProgressCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.contentInset.top = 20
        
        let menuButton: UIBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(openMenu))
        self.navigationItem.leftBarButtonItem = menuButton
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLog))
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        
        activityIndicator.startAnimating()
        APIController.shared.retrieveActivityLogs(forUser: participant.id) { (logs, error) in
            self.activityIndicator.stopAnimating()
            if let error = error {
                
            }
            else {
                self.logs = logs.sorted(by: { (lhs, rhs) in
                    return lhs.datePerformed ?? lhs.dateLogged < rhs.datePerformed ?? rhs.dateLogged
                })
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func addLog() {
        showAddLogViewController(mode: .create)
    }
    
    func updateLog(log: ActivityLog) {
        showAddLogViewController(mode: .update, log: log)
    }
    
    func showAddLogViewController(mode: AddLogViewController.Mode, log: ActivityLog? = nil) {
        let addLogViewController = AddLogViewController()
        addLogViewController.log = log
        addLogViewController.delegate = self
        addLogViewController.modalPresentationStyle = .overCurrentContext
        addLogViewController.modalTransitionStyle = .crossDissolve
        addLogViewController.mode = mode
        self.definesPresentationContext = true
        self.tabBarController?.present(addLogViewController, animated: true, completion: nil)
    }
    
    @objc func openMenu() {
        print("Open")
    }
    
    @IBAction func didTapAddLog(_ sender: Any) {
        let addLogViewController = AddLogViewController()
        addLogViewController.delegate = self
        addLogViewController.modalPresentationStyle = .overCurrentContext
        addLogViewController.modalTransitionStyle = .crossDissolve
        self.definesPresentationContext = true
        self.tabBarController?.present(addLogViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ActivityViewController: AddLogViewControllerDelegate {
    func addLogViewController(_ viewController: AddLogViewController, didSubmit log: ActivityLog) {
        self.logs.append(log)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return max(logs.count, 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0,  let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressCell", for: indexPath) as? ProgressTableViewCell {
            let numHours = logs.reduce(0, {$0 + $1.numHours})
            let numHoursString = numHours.isInteger ? "\(numHours.asInteger())h" : "\(numHours)h"
            cell.hourLabel.text = numHoursString
            cell.layoutIfNeeded()
            cell.setupUI()
            return cell
        }
            
        else if logs.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
            cell.textLabel?.text = "No logs to show."
            cell.textLabel?.textAlignment = .center
            cell.selectionStyle = .none
            return cell
        } 
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath) as? ActivityLogCell else { return UITableViewCell() }
        
        let log = logs[indexPath.row]
        let numHoursString = log.numHours.isInteger ? "\(log.numHours.asInteger())h" : "\(log.numHours)h"
        
        cell.hourLabel.text = numHoursString
        cell.dateLabel.text = log.datePerformed?.monthDayString ?? log.dateLogged.monthDayString
        cell.descriptionLabel.text = log.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ActivityLogCell else { return }
        cell.layoutIfNeeded()
        cell.hourLabel.displayAsCircle()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let log = logs[indexPath.row]
        updateLog(log: log)
    }
}
