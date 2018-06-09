//
//  MenuDrawerViewController.swift
//  Pact
//
//  Created by Jake Goodman on 6/3/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class MenuDrawerViewController: UIViewController {
    
    var tableView = UITableView()
    private var generalRows: [GeneralRowType] = [.logout]
    
    private enum RowType {
        case profile
        case general
    }
    
    private enum GeneralRowType: String {
        case logout = "Logout"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//
//        tableView.dataSource = self
//        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//extension MenuDrawerViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1
//        }
//        return generalRows.count
//    }
//
//}
