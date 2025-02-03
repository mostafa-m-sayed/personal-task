//
//  UIView+Ext.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 30/01/2025.
//
import UIKit

extension UIView {
    
    //Make the view circle
    func makeCircular() {
        self.layer.cornerRadius = min(self.bounds.width, self.bounds.height) / 2
        self.layer.masksToBounds = true
    }

    //Load view from nib
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
