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
        firstViewController.tabBarItem = UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "calendar").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "calendar-selected").withRenderingMode(.alwaysOriginal))
        
        
        let secondViewController =  UINavigationController(rootViewController: ActivityViewController())
        firstViewController.navigationItem.title = "Your Activity"
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let thirdViewController =  UINavigationController(rootViewController: GroupsViewController())
        thirdViewController.tabBarItem = UITabBarItem(title: "Groups", image:  #imageLiteral(resourceName: "groups").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "groups-selected").withRenderingMode(.alwaysOriginal))

        let tabBarList = [firstViewController, secondViewController, thirdViewController]
        
        viewControllers = tabBarList
        selectedIndex = 1
        
        tabBar.tintColor = UIColor(red:0.48, green:0.15, blue:0.08, alpha:1.0)
        // Do any additional setup after loading the view.
        
        setupProgressTab()
    }

    func setupProgressTab() {
        let progressView = SemiCirleView()
        
        let tabBarItemCount = CGFloat(self.tabBar.items?.count ?? 0)
        let barItemWidth = view.bounds.width / (tabBarItemCount) + 30
        let xOffset = (view.bounds.width / 2.0) - (barItemWidth / 2.0)
        let yOffset = view.bounds.height - (barItemWidth / 2.0)
        progressView.frame = CGRect(x: xOffset, y: yOffset, width: barItemWidth, height: barItemWidth/2)
        self.view.addSubview(progressView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProgressView))
        progressView.addGestureRecognizer(tapGesture)
        progressView.isUserInteractionEnabled = true
    }
    
    
    @objc
    func didTapProgressView() {
        selectedIndex = 1
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
