//
//  PactTabBarController.swift
//  Pact
//
//  Created by Jake Goodman on 5/29/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class PactTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = UINavigationController(rootViewController: EventsViewController())
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondViewController =  UINavigationController(rootViewController: ActivityViewController())
        firstViewController.navigationItem.title = "Your Activity"
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let thirdViewController =  UINavigationController(rootViewController: GroupsViewController())
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 2)
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        
        viewControllers = tabBarList
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
