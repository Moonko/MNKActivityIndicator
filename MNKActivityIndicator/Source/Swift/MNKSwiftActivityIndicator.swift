import UIKit

final class MNKSwiftActivityIndicator: UIView {

    private let petalLayer = CAShapeLayer()
    private let replicatorLayer = CAReplicatorLayer()

    override var intrinsicContentSize: CGSize {
        let sideLength = Constants.petalSize.height * 4
        return CGSize(width: sideLength, height: sideLength)
    }

    private(set) var isAnimating: Bool = false {
        didSet {
           updateHiddenState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        setupLayers()
        updateHiddenState()
    }

    private func setupLayers() {
        petalLayer.opacity = 0.0
        petalLayer.fillColor = UIColor.gray.cgColor

        replicatorLayer.instanceCount = Constants.petalCount
        let angle = (2.0 * .pi) / CGFloat(Constants.petalCount)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorLayer.instanceDelay = Constants.animationDuration / Double(Constants.petalCount)

        replicatorLayer.addSublayer(petalLayer)
        layer.addSublayer(replicatorLayer)
    }

    func startAnimating() {
        isAnimating = true

        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = Constants.animationDuration
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.repeatCount = .infinity
        petalLayer.add(animation, forKey: nil)
    }

    func stopAnimating() {
        isAnimating = false

        petalLayer.removeAllAnimations()
    }

    private func updateHiddenState() {
        isHidden = !isAnimating
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        replicatorLayer.frame = bounds
        let petalFrame = CGRect(
            origin: CGPoint(
                x: replicatorLayer.bounds.width / 2 - Constants.petalSize.width / 2,
                y: replicatorLayer.bounds.height / 2 - Constants.petalSize.height * 2
            ),
            size: Constants.petalSize
        )
        petalLayer.frame = petalFrame
        petalLayer.path = UIBezierPath(
            roundedRect: petalLayer.bounds,
            cornerRadius: 1
        ).cgPath
    }
}

private extension MNKSwiftActivityIndicator {

    enum Constants {

        static let animationDuration: CFTimeInterval = 1.0

        static let petalCount = 12
        static let petalSize = CGSize(width: 3, height: 9)
        static let petalCornerRadius: CGFloat = 1
    }
}
