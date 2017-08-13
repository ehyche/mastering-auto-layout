import UIKit

public typealias EHContainerViewSizeChangedBlock = (CGSize) -> Void

public class EHContainerSizeInfoView: UIView {

    // MARK: - Public properties
    public let minContainerViewSize = CGSize(width: 40.0, height: 40.0)
    public var maxContainerViewSize = CGSize(width: 256.0, height: 256.0) {
        didSet {
            if maxContainerViewSize != oldValue {
                updateWidth()
                updateHeight()
            }
        }
    }
    public var containerViewSize = CGSize(width: 256.0, height: 128.0) {
        didSet {
            if containerViewSize != oldValue {
                containerViewSizeChanged?(containerViewSize)
            }
        }
    }
    public var containerViewSizeChanged: EHContainerViewSizeChangedBlock?

    // MARK: - Private properties
    private let widthSlider = UISlider(frame: .zero)
    private let heightSlider = UISlider(frame: .zero)
    private let widthLabel = UILabel(frame: .zero)
    private let heightLabel = UILabel(frame: .zero)
    private let verticalStackView = UIStackView(frame: .zero)
    private let widthStackView = UIStackView(frame: .zero)
    private let heightStackView = UIStackView(frame: .zero)

    // MARK: - Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setupViews() {

        // Set up the width horizontal stack view
        widthStackView.translatesAutoresizingMaskIntoConstraints = false
        widthStackView.axis = .horizontal
        widthStackView.distribution = .fill
        widthStackView.alignment = .center
        widthStackView.spacing = 10.0

        widthSlider.translatesAutoresizingMaskIntoConstraints = false
        widthSlider.minimumValue = 0.0
        widthSlider.maximumValue = 1.0
        widthSlider.value = 1.0
        widthSlider.isContinuous = true
        widthSlider.addTarget(self, action: #selector(widthSliderChanged(slider:)), for: .valueChanged)

        widthStackView.addArrangedSubview(widthSlider)

        widthLabel.translatesAutoresizingMaskIntoConstraints = false
        widthLabel.font = UIFont.systemFont(ofSize: 16.0)
        widthLabel.textAlignment = .right
        widthLabel.textColor = UIColor.black
        widthLabel.text = "\(Int(computedWidth()))"

        widthStackView.addArrangedSubview(widthLabel)

        // Set up the height horizontal stack view
        heightStackView.translatesAutoresizingMaskIntoConstraints = false
        heightStackView.axis = .horizontal
        heightStackView.distribution = .fill
        heightStackView.alignment = .center
        heightStackView.spacing = 10.0

        heightSlider.translatesAutoresizingMaskIntoConstraints = false
        heightSlider.minimumValue = 0.0
        heightSlider.maximumValue = 1.0
        heightSlider.value = 1.0
        heightSlider.isContinuous = true
        heightSlider.addTarget(self, action: #selector(heightSliderChanged(slider:)), for: .valueChanged)

        heightStackView.addArrangedSubview(heightSlider)

        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.font = UIFont.systemFont(ofSize: 16.0)
        heightLabel.textAlignment = .right
        heightLabel.textColor = UIColor.black
        heightLabel.text = "\(Int(computedHeight()))"

        heightStackView.addArrangedSubview(heightLabel)

        // Now set up the vertical stack view

        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 10.0

        verticalStackView.addArrangedSubview(widthStackView)
        verticalStackView.addArrangedSubview(heightStackView)

        addSubview(verticalStackView)

        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }

    @objc private func widthSliderChanged(slider: UISlider) {
        updateWidth()
    }

    @objc private func heightSliderChanged(slider: UISlider) {
        updateHeight()
    }

    private func computedWidth() -> CGFloat {
        return (maxContainerViewSize.width - minContainerViewSize.width) * CGFloat(widthSlider.value) + minContainerViewSize.width
    }

    private func computedHeight() -> CGFloat {
        return (maxContainerViewSize.height - minContainerViewSize.height) * CGFloat(heightSlider.value) + minContainerViewSize.height
    }

    private func updateWidth() {
        let width = computedWidth()
        widthLabel.text = "\(Int(width))"
        containerViewSize = CGSize(width: width, height: containerViewSize.height)
    }

    private func updateHeight() {
        let height = computedHeight()
        heightLabel.text = "\(Int(height))"
        containerViewSize = CGSize(width: containerViewSize.width, height: height)
    }
}
