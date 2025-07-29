import UIKit
import SwiftUI

final class FloatingTabButton: UIButton {

    private let pulseLayer = CAShapeLayer()

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    // MARK: Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupPulseEffect()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupPulseEffect()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        pulseLayer.frame = bounds
        pulseLayer.path = UIBezierPath(ovalIn: bounds).cgPath
    }

    // MARK: Private methods

    private func setupButton() {
        layer.cornerRadius = 30
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        updateAppearance()
    }

    private func updateAppearance() {
        backgroundColor = isSelected ? UIColor(Color.purple700) : UIColor(Color.pureWhite)
        tintColor = isSelected ? UIColor(Color.pureWhite) : UIColor(Color.purple700)

        layer.shadowColor = UIColor(Color.purple700).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.borderColor = UIColor(Color.purple700).cgColor

        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        setImage(UIImage(systemName: "questionmark", withConfiguration: config), for: .normal)
    }

    private func setupPulseEffect() {
        pulseLayer.frame = bounds
        pulseLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        pulseLayer.fillColor = UIColor(Color.purple700).withAlphaComponent(0.3).cgColor
        pulseLayer.opacity = 0
        layer.insertSublayer(pulseLayer, at: 0)
    }

    // MARK: Handlers

    @objc private func touchDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }

        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.8
        pulseAnimation.fromValue = 0.8
        pulseAnimation.toValue = 1.2
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulseAnimation.autoreverses = false
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(pulseAnimation, forKey: "pulse")

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = 0.8
        opacityAnimation.fromValue = 0.8
        opacityAnimation.toValue = 0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.autoreverses = false
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(opacityAnimation, forKey: "opacity")
    }

    @objc private func touchUp() {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseOut) {
            self.transform = .identity
        }

        pulseLayer.removeAllAnimations()
    }

}
