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
        tableView.register(UINib(nibName: "ActivityTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLog))
        self.navigationItem.rightBarButtonItem = rightButton
        
        
        activityIndicator.startAnimating()
        APIController.shared.retrieveActivityLogs(forUser: participant.id) { (logs, error) in
            self.activityIndicator.stopAnimating()
            if let error = error {
                
            }
            else {
                self.logs = logs
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func addLog() {
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(logs.count, 1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 180
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ActivityTableHeaderView else {
//            return nil
//        }
//        return headerView
//    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? ActivityTableHeaderView {
//            headerView.setupUI()
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if logs.count == 0 {
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
        cell.descriptionLabel.text = log.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ActivityLogCell else { return }
        cell.layoutIfNeeded()
        cell.hourLabel.displayAsCircle()
    }
    
}
