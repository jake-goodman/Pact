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
        super.viewDidLoad()
        title = "Your Activity"
        
        tableView.register(UINib(nibName: "ActivityLogCell", bundle: nil), forCellReuseIdentifier: "LogCell")
        tableView.register(UINib(nibName: "ActivityTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLog))
        self.navigationItem.rightBarButtonItem = rightButton
        
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.activityIndicator.stopAnimating()
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    @objc func addLog() {
        let log = ActivityLog(id: "a", numHours: 2, description: "Logged 2 hours.")
        logs.append(log)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(logs.count, 1)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ActivityTableHeaderView else {
            return nil
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? ActivityTableHeaderView {
            headerView.setupUI()
        }
    }
    
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
        cell.hourLabel.text = "\(log.numHours)h"
        cell.descriptionLabel.text = log.description
        return cell
    }
    
}
