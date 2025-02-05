//
//  ScoreView.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 05/02/2025.
//

import UIKit
protocol ScorePopupViewDelegate: AnyObject {
    func didDismiss()
}
final class ScorePopupView: UIView {
    
    private let titleLabel = UILabel()
    private let scoreLabel = UILabel()
    
    weak var delegate: ScorePopupViewDelegate?

    init(score: String) {
        super.init(frame: .zero)
        setupView(score: score)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(score: String) {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.layer.cornerRadius = 16
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 6
        
        setupLabels(with: score)

        let stackVIew = UIStackView(arrangedSubviews: [titleLabel, scoreLabel])
        stackVIew.axis = .vertical
        addSubview(stackVIew)
        stackVIew.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackVIew.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackVIew.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    private func setupLabels(with score: String) {
        titleLabel.text = "Your score is"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        scoreLabel.text = score
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 24)
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
    }
    
    func show(in view: UIView) {
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.widthAnchor.constraint(equalToConstant: 200),
            self.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Animation: Scale & Fade In
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.transform = .identity
        }) { _ in
            // Auto-dismiss after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss()
            }
        }
    }
    
    private func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { [weak self]_ in
            self?.removeFromSuperview()
            self?.delegate?.didDismiss()
        }
    }
}
