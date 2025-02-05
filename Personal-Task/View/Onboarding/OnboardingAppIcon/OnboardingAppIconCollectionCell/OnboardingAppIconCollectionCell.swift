//
//  OnboardingAppIconCollectionCell.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 03/02/2025.
//

import UIKit

final class OnboardingAppIconCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var appImage: UIImageView!
    @IBOutlet private weak var checkImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    private func configureUI() {
        self.contentView.layer.cornerRadius = 12
        appImage.layer.cornerRadius = 12
        checkImage.layer.cornerRadius = 7.5
        checkImage.isHidden = true
        self.contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    func configure(with appIcon: AppIconItem) {
        appImage.image = UIImage(named: appIcon.imageTitle)
        self.contentView.layer.borderWidth = appIcon.selected ? 1 : 0
        checkImage.isHidden = !appIcon.selected
    }
}
