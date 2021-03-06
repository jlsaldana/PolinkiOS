//
//  SignUpVC.swift
//  Polink
//
//  Created by Jose Saldana on 01/02/2020.
//  Copyright © 2020 Jose Saldana. All rights reserved.
//

import UIKit
import FirebaseAuth
import PopupDialog

// Delegate pattern to inform of selection to initial view
protocol RegisterDelegate {
	func didTapToRegister()
}

class SignUpVC: UIViewController, UITextFieldDelegate {
	@IBOutlet weak var signupButton: UIButton!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	@IBOutlet var fields: [UITextField]!
	
	// delegate of class SignUpVC
	var registerDelegate: RegisterDelegate!
	
	var username: String?
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// The text field should report back to our view controller
		passwordField.delegate = self
		emailField.delegate = self
		
		// Set the button corners to be rounded according to the buttons height.
		signupButton.layer.cornerRadius = signupButton.frame.height / 5
		for field in fields {
			field.layer.borderWidth = 1
			field.layer.masksToBounds = true
			field.layer.borderColor = UIColor.gray.cgColor
			field.layer.cornerRadius = field.frame.height / 5
		}
		
	}
	@IBAction func signupButtonPressed(_ sender: Any?) {
		passwordField.endEditing(true)
		if let email = emailField.text, let password = passwordField.text {
			checkSecurityConditions(email: email, password: password)
			
			Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
				// In case of an error present a popup to inform the user of the failed attempt to register
				if let e = error {
					let popup = PopupDialog(title: K.Popup.signUpError, message: "\(e.localizedDescription)", buttonAlignment: .vertical, transitionStyle: .fadeIn, tapGestureDismissal: true, panGestureDismissal: true, hideStatusBar: false, completion: nil)
					
					_ = popup.viewController as! PopupDialogDefaultViewController
					
					// Format the popup
					let dialogAppearance = PopupDialogDefaultView.appearance()
					dialogAppearance.titleFont = .boldSystemFont(ofSize: 14)
					let overlayAppearance = PopupDialogOverlayView.appearance()
					overlayAppearance.color = .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
					overlayAppearance.blurEnabled = true
					overlayAppearance.blurRadius = 25
					overlayAppearance.opacity = 0.3
					
					// Present the formatted popup
					self.present(popup, animated: true, completion: nil)
					
				} else {
					// Register name to user and go to Registration steps
					self.createSpinnerView()
					Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
						self.registerDelegate.didTapToRegister()
						self.dismiss(animated: true, completion: nil)
					}
				}
			}
		}
	}
	
	func checkSecurityConditions(email: String, password: String){
		// Verify that the email is a valid email
		
		// Verify the password meet minimum security standards
		
	}
	
	func createSpinnerView() {
		let child = SpinnerViewController()
		
		// add the spinner view controller
		addChild(child)
		child.view.frame = view.frame
		view.addSubview(child.view)
		child.didMove(toParent: self)
		
		// wait two seconds to simulate some work happening
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
			// then remove the spinner view controller
			child.willMove(toParent: nil)
			child.view.removeFromSuperview()
			child.removeFromParent()
		}
	}
	
	// What happens when the user presses return on the keyboard
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailField {
			passwordField.becomeFirstResponder()
			return true
		} else {
			textField.endEditing(true)
			return true
		}
	}
	
	// Validation for what the user typed
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return true
	}
	
	// If the text field ends editing clear password field
	func textFieldDidEndEditing(_ textField: UITextField) {
		//Use what the user typed to call the signup process
		if textField == passwordField {
			resignFirstResponder()
		}
	}
}
