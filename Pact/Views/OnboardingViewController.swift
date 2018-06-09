//
//  OnboardingViewController.swift
//  Pact
//
//  Created by Jake Goodman on 5/28/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var textFieldStack: UIStackView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    fileprivate enum ScreenState {
        case landing, loading, login, signup
    }
    
    fileprivate var state: ScreenState = .landing
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = APIController.shared.currentUser {
            updateState(.loading)
            APIController.shared.retrieveParticipant(forUser: currentUser.uid) { (participant, error) in
                if let participant = participant {
                    APIController.shared.currentParticipant = participant
                    self.segueToDashboard()
                } else {
                    self.updateState(.landing)
                }
            }
        } else {
            updateState(.landing)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func updateState(_ state: ScreenState) {
        view.endEditing(true)
        self.state = state
        switch state {
        case .landing:
            self.spinner.stopAnimating()
            UIView.animate(withDuration: 0.33) {
                self.titleLabel.alpha = 1.0
                self.buttonStack.alpha = 1.0
                self.textFieldStack.alpha = 0
                self.blurView.alpha = 0
            }
        case .loading:
            self.spinner.startAnimating()
            UIView.animate(withDuration: 0.33) {
                self.titleLabel.alpha = 1.0
                self.buttonStack.alpha = 0
                self.textFieldStack.alpha = 0
                self.blurView.alpha = 0
            }
        case .login:
            self.spinner.stopAnimating()
            self.nameTextField.isHidden = true
            UIView.animate(withDuration: 0.33) {
                self.titleLabel.alpha = 1.0
                self.buttonStack.alpha = 0
                self.textFieldStack.alpha = 1.0
                self.blurView.alpha = 1.0
            }
        case .signup:
            self.spinner.stopAnimating()
            self.nameTextField.isHidden = false
            UIView.animate(withDuration: 0.33) {
                self.titleLabel.alpha = 1.0
                self.buttonStack.alpha = 0
                self.textFieldStack.alpha = 1.0
                self.blurView.alpha = 1.0
            }
        }
    }
    
    @IBAction func didTapSignup(_ sender: Any) {
        updateState(.signup)
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        updateState(.login)
    }
    
    @IBAction func didTapGo(_ sender: Any) {
        guard let email = emailTextField.text, let password = passTextField.text else { return }
        if state == .login {
            updateState(.loading)
            APIController.shared.signIn(withEmail: email, password: password) { (user, error) in
                //TODO: Create Participant Object
                if let error = error {
                    self.updateState(.login)
                    AppUtility.presentSimpleAlert(on: self,
                                                  title: "Error",
                                                  message: error.localizedDescription,
                                                  buttonTitle: "Dismiss")
                }
                else if let user = user {
                    APIController.shared.retrieveParticipant(forUser: user.uid) { (participant, error) in
                        self.segueToDashboard()
                    }
                }
            }
        }
        else if state == .signup {
            updateState(.loading)
            APIController.shared.createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.updateState(.signup)
                    AppUtility.presentSimpleAlert(on: self,
                                                  title: "Error",
                                                  message: error.localizedDescription,
                                                  buttonTitle: "Dismiss")
                }
                else if let user = user {
                    APIController.shared.createParticipant(forUser: user.uid, withName: self.nameTextField.text!) { (participant, error) in
                        self.segueToDashboard()
                    }
                }
            }
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
        updateState(.landing)
    }
    
    func segueToDashboard() {
//        let centralController = CentralViewController()
        let tabBarViewController = PactTabBarController()
        self.present(tabBarViewController, animated: true, completion: nil)
    }
    
}
