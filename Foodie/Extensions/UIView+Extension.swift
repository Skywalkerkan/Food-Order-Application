//
//  UIView+Extension.swift
//  Foodie
//
//  Created by Erkan on 18.02.2023.
//

import UIKit


extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get {return cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
