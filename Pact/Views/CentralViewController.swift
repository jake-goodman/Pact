//
//  CentralViewController.swift
//  Pact
//
//  Created by Jake Goodman on 6/2/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class CentralViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet var navigationButtons: [UIButton]!
    @IBOutlet weak var progressView: UIView!
    
    let navigationTabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerView()
        progressView.displayAsCircle()
        progressView.showBorder(width: 4, color: UIColor.pactBlueDark.cgColor)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupContainerView() {
        self.addChildViewController(navigationTabBarController)
        self.containerView.addSubview(navigationTabBarController.view)
        navigationTabBarController.didMove(toParentViewController: self)
        
        navigationTabBarController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        navigationTabBarController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        navigationTabBarController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        navigationTabBarController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        navigationTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
        
        navigationTabBarController.tabBar.isHidden = true
        navigationTabBarController.viewControllers = [EventsViewController(), ActivityViewController(), GroupsViewController() ]
        navigationTabBarController.selectedIndex = 1
    }
    
    @IBAction func didTapNavigationButton(_ sender: Any) {
        if let button = sender as? UIButton,
            let index = self.navigationButtons.index(of: button) {
            navigationTabBarController.selectedIndex = index
        }
    }
}
