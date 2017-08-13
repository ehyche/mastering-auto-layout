import UIKit

public class EHAdjustableContainerView : UIView {

    // MARK: - Public properties

    public let containerView = UIView(frame: .zero)

    // MARK: - Private properties

    private let internalContainerView = UIView(frame: .zero)
    private let containerSizeInfoView = EHContainerSizeInfoView(frame: .zero)
    private var containerViewWidthConstraint = NSLayoutConstraint()
    private var containerViewHeightConstraint = NSLayoutConstraint()

    // MARK: - Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView methods

    override public func layoutSubviews() {
        super.layoutSubviews()

        containerSizeInfoView.maxContainerViewSize = internalContainerView.frame.size
    }


    // MARK: - Private methods

    func setupView() {
        backgroundColor = UIColor.white

        internalContainerView.translatesAutoresizingMaskIntoConstraints = false
        internalContainerView.backgroundColor = UIColor.white
        internalContainerView.layer.borderColor = UIColor.black.cgColor
        internalContainerView.layer.borderWidth = 2.0
        addSubview(internalContainerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.lightGray
        internalContainerView.addSubview(containerView)

        containerView.centerXAnchor.constraint(equalTo: internalContainerView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: internalContainerView.centerYAnchor).isActive = true

        containerViewWidthConstraint = containerView.widthAnchor.constraint(equalToConstant: 256.0)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: 256.0)
        containerViewWidthConstraint.isActive = true
        containerViewHeightConstraint.isActive = true

        containerSizeInfoView.translatesAutoresizingMaskIntoConstraints = false
        containerSizeInfoView.backgroundColor = UIColor.white
        addSubview(containerSizeInfoView)

        internalContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        trailingAnchor.constraint(equalTo: internalContainerView.trailingAnchor, constant: 10.0).isActive = true
        internalContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true

        containerSizeInfoView.topAnchor.constraint(equalTo: internalContainerView.bottomAnchor, constant: 10.0).isActive = true

        containerSizeInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        trailingAnchor.constraint(equalTo: containerSizeInfoView.trailingAnchor, constant: 10.0).isActive = true
        bottomAnchor.constraint(equalTo: containerSizeInfoView.bottomAnchor, constant: 10.0).isActive = true

        containerSizeInfoView.containerViewSizeChanged = { [weak self] (size) in
            self?.containerViewWidthConstraint.constant = size.width
            self?.containerViewHeightConstraint.constant = size.height
        }
    }

}

