//
//  ViewController.swift
//  Instagram
//
//  Created by Jay on 2022/10/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var registerButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerButton.layer.borderColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.5).cgColor
        registerButton.layer.borderWidth = 2
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }


}

