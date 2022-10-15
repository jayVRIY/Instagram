//
//  ViewController.swift
//  Instagram
//
//  Created by Jay on 2022/10/13.
//

import UIKit
import Parse
class LoginViewController: UIViewController {
    
    @IBOutlet weak var registerUsername: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    //This is for the keyboard to GO AWAYY !! when user clicks anywhere on the view
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    //This is for the keyboard to GO AWAYY !! when user clicks "Return" key  on the keyboard
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        user.username = registerUsername.text;
        user.password = registerPassword.text
        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let userName = LoginUsername.text!
        let password = LoginPassword.text!
        PFUser.logInWithUsername(inBackground: userName, password: password){
            (user,error) in
            if user != nil{
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }else{
                print(error?.localizedDescription)
            }
        }
    }
}

