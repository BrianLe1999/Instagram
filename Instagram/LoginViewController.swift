//
//  LoginViewController.swift
//  Instagram
//
//  Created by 01659826174 01659826174 on 3/20/22.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if isUsernameOrPasswordEmpty() {
            displayEmptyTextFieldError()
            return
        }
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if let error = error {
                self.displaySignInError(error: error)
            } else {
                print("User \(String(describing: user?.username)) is signed in!")
                self.performSegue(withIdentifier: "loginSeque", sender: nil)
            }
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if isUsernameOrPasswordEmpty() {
            displayEmptyTextFieldError()
            return
        }
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackground { isSuccess, error in
            if let error = error {
                self.displaySignUpError(error: error)
            } else {
                print("User \(String(describing: user.username)) is registered!")
                self.performSegue(withIdentifier: "loginSeque", sender: nil)
            }
        }
    }
            
    private func isUsernameOrPasswordEmpty() -> Bool {
        return usernameField.text!.isEmpty || passwordField.text!.isEmpty
    }
    
    private func displaySignUpError(error: Error) {
        let title = "Sign up error"
        let message = "Oops! Something went wrong when signing up: \(error.localizedDescription)"
        displayMessage(title: title, message: message)
    }
    
    private func displaySignInError(error: Error) {
        let title = "Sign in error"
        let message = "Oops! Something went wrong when signing in: \(error.localizedDescription)"
        displayMessage(title: title, message: message)
    }
    
    private func displayEmptyTextFieldError() {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        displayMessage(title: title, message: message)
    }
    
    
    private func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
            

}
