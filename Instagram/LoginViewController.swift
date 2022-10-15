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
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let user = PFUser()
        user.username = registerUsername.text;
        user.password = registerPassword.text
        user.signUpInBackground { success, error in
            if success {
                self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
    }
}

