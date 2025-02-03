//
//  UIStoryboard+Ext.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit
extension UIStoryboard {
    static var main: UIStoryboard {
        let bundle = Bundle.main
        return UIStoryboard(name: "Main", bundle: bundle)
    }
}
