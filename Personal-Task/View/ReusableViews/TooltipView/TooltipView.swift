//
//  TooltipView.swift
//  Personal-Task
//
//  Created by Mostafa Sayed on 05/02/2025.
//

import UIKit

class TooltipView: UIView {
    
    private let label = UILabel()
    private var backgroundView: UIView?

    init(text: String) {
        super.init(frame: .zero)
        setupView(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(text: String) {
        backgroundColor = UIColor.white
        layer.cornerRadius = 8
        layer.masksToBounds = true

        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }

    func show(above view: UIView, in containerView: UIView) {
        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.alpha = 0
        containerView.addSubview(bgView)
        self.backgroundView = bgView

        // **Create a transparent cutout around the small view**
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: bgView.bounds)
        let targetFrame = view.convert(view.bounds, to: containerView)
        let circlePath = UIBezierPath(ovalIn: targetFrame.insetBy(dx: -4, dy: -4)) // Slight padding
        path.append(circlePath)
        path.usesEvenOddFillRule = true
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        bgView.layer.mask = maskLayer

        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        bgView.addGestureRecognizer(dismissTap)

        containerView.addSubview(self)
        self.alpha = 0
        self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        let tooltipWidth: CGFloat = 200
        let tooltipHeight: CGFloat = 60
        let padding: CGFloat = 8

        var tooltipX = targetFrame.midX - tooltipWidth / 2
        let tooltipY = targetFrame.minY - tooltipHeight - padding

        // **Ensure the tooltip stays within bounds**
        if tooltipX < 16 {
            tooltipX = targetFrame.minX // Align left
        }
        if tooltipX + tooltipWidth > containerView.bounds.width - 16 {
            tooltipX = targetFrame.maxX - tooltipWidth // Align right
        }

        self.frame = CGRect(x: tooltipX, y: tooltipY, width: tooltipWidth, height: tooltipHeight)

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            bgView.alpha = 1
            self.alpha = 1
            self.transform = .identity
        })
    }

    @objc private func dismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.backgroundView?.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.backgroundView?.removeFromSuperview()
        }
    }
}
