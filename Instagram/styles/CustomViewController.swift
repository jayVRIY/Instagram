//
//  CustomViewController.swift
//  Instagram
//
//  Created by Jay on 2022/10/14.
//

import UIKit
@IBDesignable
class CustomViewController : UIView{
    @IBInspectable var cornerRadius:CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
   
}
