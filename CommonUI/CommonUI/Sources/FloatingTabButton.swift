import UIKit
import SwiftUI

public final class FloatingTabButton: UIButton {

    private let pulseLayer = CAShapeLayer()

    public override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    // MARK: Life Cycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupPulseEffect()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupPulseEffect()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        pulseLayer.frame = bounds
        pulseLayer.path = UIBezierPath(ovalIn: bounds).cgPath
    }

    // MARK: Private methods

    private func setupButton() {
        layer.cornerRadius = Metrics.cornerRadius
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        updateAppearance()
    }

    private func updateAppearance() {
        backgroundColor = isSelected ? UIColor(.purple700) : UIColor(.pureWhite)
        tintColor = isSelected ? UIColor(.pureWhite) : UIColor(.purple700)

        layer.shadowColor = UIColor(.purple700).cgColor
        layer.shadowOffset = CGSize(width: Shadow.width, height: Shadow.height)
        layer.shadowRadius = Shadow.radius
        layer.shadowOpacity = Shadow.opacity
        layer.borderColor = UIColor(.purple700).cgColor
        layer.borderWidth = 0
        
        let config = UIImage.SymbolConfiguration(pointSize: Symbol.pointSize, weight: Symbol.weight)
        setImage(UIImage(systemName: Symbol.name, withConfiguration: config), for: .normal)
    }

    private func setupPulseEffect() {
        pulseLayer.frame = bounds
        pulseLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        pulseLayer.fillColor = UIColor(.purple700).withAlphaComponent(Pulse.fillAlpha).cgColor
        pulseLayer.opacity = 0
        layer.insertSublayer(pulseLayer, at: 0)
    }

    public override var intrinsicContentSize: CGSize {
        CGSize(width: Metrics.size, height: Metrics.size)
    }

    // MARK: Handlers

    @objc private func touchDown() {
        UIView.animate(withDuration: Interaction.touchDownDuration) {
            self.transform = CGAffineTransform(scaleX: Interaction.touchDownScale, y: Interaction.touchDownScale)
        }

        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = Pulse.duration
        pulseAnimation.fromValue = Pulse.scaleFrom
        pulseAnimation.toValue = Pulse.scaleTo
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulseAnimation.autoreverses = false
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(pulseAnimation, forKey: "pulse")

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.duration = Opacity.duration
        opacityAnimation.fromValue = Opacity.scaleFrom
        opacityAnimation.toValue = Opacity.scaleTo
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        opacityAnimation.autoreverses = false
        opacityAnimation.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(opacityAnimation, forKey: "opacity")
    }

    @objc private func touchUp() {
        UIView.animate(withDuration: Interaction.touchUpDuration,
                       delay: 0,
                       usingSpringWithDamping: Interaction.touchUpSpringDamping,
                       initialSpringVelocity: Interaction.touchUpSpringVelocity,
                       options: .curveEaseOut) {
            self.transform = .identity
        }

        pulseLayer.removeAllAnimations()
    }

}

private extension FloatingTabButton {
    enum Metrics {
        static let size: CGFloat = 60
        static let cornerRadius: CGFloat = 30
    }
    
    enum Shadow {
        static let width: CGFloat = 0
        static let height: CGFloat = 5
        static let radius: CGFloat = 10
        static let opacity: Float = 0.3
    }
    
    enum Symbol {
        static let name: String = "questionmark"
        static let pointSize: CGFloat = 18
        static let weight: UIImage.SymbolWeight = .bold
    }
    
    enum Pulse {
        static let fillAlpha: CGFloat = 0.3
        static let duration: CFTimeInterval = 0.8
        static let scaleFrom: CGFloat = 0.8
        static let scaleTo: CGFloat = 1.2
    }
    
    enum Opacity {
        static let duration: CFTimeInterval = 0.8
        static let scaleFrom: CGFloat = 0.8
        static let scaleTo: CGFloat = 0
    }
    
    enum Interaction {
        static let touchDownDuration: TimeInterval = 0.1
        static let touchDownScale: CGFloat = 0.9
    
        static let touchUpDuration: TimeInterval = 0.2
        static let touchUpSpringDamping: CGFloat = 0.5
        static let touchUpSpringVelocity: CGFloat = 0.5
    }
}
