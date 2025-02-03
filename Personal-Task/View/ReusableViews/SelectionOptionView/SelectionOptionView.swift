//
//  SelectionOptionView.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 30/01/2025.
//

import UIKit

class SelectionOptionViewDataModel {
    internal init(title: String, isSelected: Bool, didTap: ((Bool) -> ())? = nil) {
        self.title = title
        self.isSelected = isSelected
        self.didTap = didTap
    }
    
    let title: String
    var isSelected: Bool
    var didTap: ((_ isSelected: Bool) -> ())?
}
enum SelectionType {
    case singleSelection
    case multipleSelection
}

final class SelectionOptionView: UIView {
    
    @IBOutlet private weak var checkView: UIView!
    @IBOutlet private weak var tickImage: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkContainerView: UIView!
    
    var isSelected: Bool = false
    var selectionTheme: SelectionOptionTheme?
    private var themeBackgroundColor = ""
    private var view: UIView!

    private var didTap: ((_ isSelected: Bool) -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        addGestures()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        addGestures()
    }

    func loadViewFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SelectionOptionView", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        self.addSubview(self.view)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func configureView(with dataModel: SelectionOptionViewDataModel, selectionTheme: SelectionOptionTheme) {
        self.titleLabel.text = dataModel.title
        self.didTap = dataModel.didTap
        self.themeBackgroundColor = selectionTheme.themeBackgroundColor
        setupUI(selectionTheme)
        setSelectionStatus(as: dataModel.isSelected, for: selectionTheme.selectionType)
    }

    func setSelectionStatus(as isSelected: Bool, for selectionType: SelectionType) {
        self.isSelected = isSelected
        if isSelected {
            if selectionType == .singleSelection {
                tickImage.isHidden = true
                checkView.isHidden = false
                checkContainerView.backgroundColor = UIColor(named: "app-light-gray")
                checkView.backgroundColor = UIColor(named: themeBackgroundColor)
            } else {
                tickImage.isHidden = false
                checkView.isHidden = true
                checkContainerView.backgroundColor = UIColor(named: "app-mint")
                
            }
            containerView.layer.borderColor = UIColor.white.cgColor
            titleLabel.textColor = UIColor.white
        } else {
            containerView.layer.borderColor = UIColor(named: "app-light-gray")?.cgColor
            titleLabel.textColor = UIColor(named: "app-light-gray")
            
            checkContainerView.backgroundColor = UIColor(named: themeBackgroundColor)

            tickImage.isHidden = true
            checkView.isHidden = true
        }
    }

    private func setupUI(_ selectionTheme: SelectionOptionTheme) {

        titleLabel.textColor = UIColor(named: "app-light-gray")
        
        containerView.layer.cornerRadius = selectionTheme.containerCornerRadius
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(named: "app-light-gray")?.cgColor
        
        checkContainerView.makeCircular()
        checkContainerView.backgroundColor = UIColor(named: selectionTheme.themeBackgroundColor)
        checkContainerView.layer.borderWidth = 1
        checkContainerView.layer.borderColor = UIColor(named: "app-light-gray")?.cgColor
        
        checkView.makeCircular()
        checkView.backgroundColor = UIColor(named: selectionTheme.themeBackgroundColor)
        tickImage.tintColor = UIColor(named: selectionTheme.themeBackgroundColor)
        
        containerView.setNeedsLayout()
        containerView.layoutIfNeeded()
        containerView.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DispatchQueue.main.async {
            self.checkContainerView.makeCircular()
            self.checkView.makeCircular()
        }
    }

    private func addGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapItem))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func didTapItem() {
        didTap?(isSelected)
    }
    
}
