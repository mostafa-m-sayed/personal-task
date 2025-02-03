//
//  SubmitButton.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 02/02/2025.
//

import UIKit

final class SubmitButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            let buttonTintColor = self.tintColor
            self.alpha = isEnabled ? 1 : 0.5
            self.isUserInteractionEnabled = isEnabled
            self.tintColor = buttonTintColor?.withAlphaComponent(isEnabled ? 1 : 0.5)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 25
        self.clipsToBounds = false

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
    }

    
}
