//
//  EHStackViewContentViewController.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 8/4/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

typealias EHStackContentCancelBlock = () -> Void
typealias EHStackContentUpdateBlock = ([UIView]) -> Void
typealias EHStackContentAnimationBlock = () -> Void


class EHStackViewContentViewController: UIViewController {

    // MARK: - Public properties

    var cancelBlock: EHStackContentCancelBlock?
    var updateBlock: EHStackContentUpdateBlock?

    // MARK: - Public methods

    class func defaultArrangedSubviews() -> [UIView] {
        return [imageView(withImageContent: .steveLarge),
                imageView(withImageContent: .timMedium),
                imageView(withImageContent: .gilSmall)]
    }

    class func update(arrangedSubviews subviews: [UIView], inStackView stackView: UIStackView, animated: Bool, duration: TimeInterval) {
        let animationBlock: EHStackContentAnimationBlock = {
            let views = stackView.arrangedSubviews
            for view in views {
                view.removeFromSuperview()
            }
            for subview in subviews {
                stackView.addArrangedSubview(subview)
            }
        }
        if animated {
            UIView.animate(withDuration: duration,
                           animations: animationBlock,
                           completion: nil)
        } else {
            animationBlock()
        }
    }

    // MARK: - Private properties

    private var arrangedSubviews: [UIView]
    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)

    private enum RowContent: Int {
        case arrangedSubviewsHeader
        case addContentHeader
        case addContentLabelSmall
        case addContentLabelMedium
        case addContentLabelLarge
        case addContentImageSteveSmall
        case addContentImageSteveMedium
        case addContentImageSteveLarge
        case addContentImageTimSmall
        case addContentImageTimMedium
        case addContentImageTimLarge
        case addContentImageGilSmall
        case addContentImageGilMedium
        case addContentImageGilLarge
    }

    private enum ImageContent: Int {
        case steveLarge
        case steveMedium
        case steveSmall
        case timLarge
        case timMedium
        case timSmall
        case gilLarge
        case gilMedium
        case gilSmall
    }

    // MARK: - Initializers

    init(arrangedSubviews: [UIView]) {
        self.arrangedSubviews = arrangedSubviews
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "UIStackView arrangedSubviews"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(applyTapped(sender:)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0

        scrollView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        createViews()
        
        updateViewState()
    }

    // MARK: - Private methods

    private func createViews() {
        removeAllArrangedSubviews()

        stackView.addArrangedSubview(headerView(withText: "Arranged Subviews", content: .arrangedSubviewsHeader))
        for i in 0..<arrangedSubviews.count {
            stackView.addArrangedSubview(rowForArrangedSubview(view: arrangedSubviews[i], atIndex: i))
        }
        stackView.addArrangedSubview(headerView(withText: "Add Subviews", content: .addContentHeader))
        stackView.addArrangedSubview(rowView(withText: "Small Text", content: .addContentLabelSmall))
        stackView.addArrangedSubview(rowView(withText: "Medium Text", content: .addContentLabelMedium))
        stackView.addArrangedSubview(rowView(withText: "Large Text", content: .addContentLabelLarge))
        stackView.addArrangedSubview(rowView(withText: "Steve Jobs Image Small", content: .addContentImageSteveSmall))
        stackView.addArrangedSubview(rowView(withText: "Steve Jobs Image Medium", content: .addContentImageSteveMedium))
        stackView.addArrangedSubview(rowView(withText: "Steve Jobs Image Large", content: .addContentImageSteveLarge))
        stackView.addArrangedSubview(rowView(withText: "Tim Cook Image Small", content: .addContentImageTimSmall))
        stackView.addArrangedSubview(rowView(withText: "Tim Cook Image Medium", content: .addContentImageTimMedium))
        stackView.addArrangedSubview(rowView(withText: "Tim Cook Image Large", content: .addContentImageTimLarge))
        stackView.addArrangedSubview(rowView(withText: "Gil Amelio Image Small", content: .addContentImageGilSmall))
        stackView.addArrangedSubview(rowView(withText: "Gil Amelio Image Medium", content: .addContentImageGilMedium))
        stackView.addArrangedSubview(rowView(withText: "Gil Amelio Image Large", content: .addContentImageGilLarge))
    }

    private func updateViewState() {

    }

    private func removeAllArrangedSubviews() {
        // Remove any arrangedSubviews
        let subviews = stackView.arrangedSubviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    private func rowForArrangedSubview(view: UIView, atIndex index: Int) -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        stackView.isLayoutMarginsRelativeArrangement = true

        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = titleText(forArrangedSubview: view)
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont(name: "OpenSans-Semibold", size: 14.0)
        nameLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow-1, for: .horizontal)

        let deleteImageView = UIImageView(image: UIImage(named: "trash-can"))
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.tag = index
        deleteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteViewRowTapped(recognizer:))))

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(deleteImageView)

        return stackView
    }

    private func titleText(forArrangedSubview view: UIView) -> String {
        var text = ""

        if let imageView = view as? UIImageView {
            if let imageContent = ImageContent(rawValue: imageView.tag) {
                switch imageContent {
                    case .steveLarge:  text = "Image (Steve Jobs, Large)"
                    case .steveMedium: text = "Image (Steve Jobs, Medium)"
                    case .steveSmall:  text = "Image (Steve Jobs, Small)"
                    case .timLarge:    text = "Image (Tim Cook, Large)"
                    case .timMedium:   text = "Image (Tim Cook, Medium)"
                    case .timSmall:    text = "Image (Tim Cook, Small)"
                    case .gilLarge:    text = "Image (Gil Amelio, Large)"
                    case .gilMedium:   text = "Image (Gil Amelio, Medium)"
                    case .gilSmall:    text = "Image (Gil Amelio, Small)"
                }
            } else {
                text = "Unknown Image"
            }
        } else if let label = view as? UILabel {
            let labelText = label.text ?? "Nil Text"
            let colorName = label.backgroundColor?.name ?? "Nil Color"
            text = "Label (\"\(labelText)\", \(label.font.pointSize), \(colorName))"
        }

        return text
    }

    @objc private func cancelTapped(sender: AnyObject) {
        cancelBlock?()
    }

    @objc private func applyTapped(sender: AnyObject) {
        updateBlock?(arrangedSubviews)
    }

    @objc private func addContentRowTapped(recognizer: UIGestureRecognizer) {
        if let rowTag = recognizer.view?.tag,
           let rowContent = RowContent(rawValue: rowTag),
           let viewToAdd = handleAddContentTap(onRow: rowContent) {
            let rowView = rowForArrangedSubview(view: viewToAdd, atIndex: arrangedSubviews.count)
            let insertionIndex = arrangedSubviews.count + 1
            arrangedSubviews.append(viewToAdd)
            stackView.insertArrangedSubview(rowView, at: insertionIndex)
        }
    }

    @objc private func deleteViewRowTapped(recognizer: UIGestureRecognizer) {
        if let rowTag = recognizer.view?.tag, rowTag < arrangedSubviews.count {
            handleDeleteView(atIndex: rowTag)
        }
    }

    private func handleDeleteView(atIndex index: Int) {
        if index < arrangedSubviews.count {
            arrangedSubviews.remove(at: index)
        }
        let rowIndex = index + 1
        if rowIndex < stackView.arrangedSubviews.count {
            let rowView = stackView.arrangedSubviews[rowIndex]
            rowView.removeFromSuperview()
        }
    }
    
    private func handleAddContentTap(onRow row: RowContent) -> UIView? {
        var view: UIView? = nil

        switch row {
            case .addContentLabelSmall: break
            case .addContentLabelMedium: break
            case .addContentLabelLarge: break
            case .addContentImageSteveSmall:
                view = EHStackViewContentViewController.imageView(withImageContent: .steveSmall)
            case .addContentImageSteveMedium:
                view = EHStackViewContentViewController.imageView(withImageContent: .steveMedium)
            case .addContentImageSteveLarge:
                view = EHStackViewContentViewController.imageView(withImageContent: .steveLarge)
            case .addContentImageTimSmall:
                view = EHStackViewContentViewController.imageView(withImageContent: .timSmall)
            case .addContentImageTimMedium:
                view = EHStackViewContentViewController.imageView(withImageContent: .timMedium)
            case .addContentImageTimLarge:
                view = EHStackViewContentViewController.imageView(withImageContent: .timLarge)
            case .addContentImageGilSmall:
                view = EHStackViewContentViewController.imageView(withImageContent: .gilSmall)
            case .addContentImageGilMedium:
                view = EHStackViewContentViewController.imageView(withImageContent: .gilMedium)
            case .addContentImageGilLarge:
                view = EHStackViewContentViewController.imageView(withImageContent: .gilLarge)
            default:
                break
        }

        return view
    }

    class private func imageView(withImageContent content: ImageContent) -> UIImageView {
        var imageName = ""
        switch content {
            case .steveSmall:  imageName = "steve-small"
            case .steveMedium: imageName = "steve-medium"
            case .steveLarge:  imageName = "steve-large"
            case .timSmall:    imageName = "tim-small"
            case .timMedium:   imageName = "tim-medium"
            case .timLarge:    imageName = "tim-large"
            case .gilSmall:    imageName = "gil-small"
            case .gilMedium:   imageName = "gil-medium"
            case .gilLarge:    imageName = "gil-large"
        }
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.tag = content.rawValue
        return imageView
    }

    private func headerView(withText text: String, content: RowContent) -> UIStackView {
        let stackView = EHColorableStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = UIColor.lightGray

        let label = UILabel(frame: .zero)
        label.text = text
        label.textColor = UIColor.black
        label.font = UIFont(name: "OpenSans-Bold", size: 18.0)

        stackView.addArrangedSubview(label)

        return stackView
    }
    
    private func rowView(withText text: String, content: RowContent) -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.tag = content.rawValue
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addContentRowTapped(recognizer:))))

        let label = UILabel(frame: .zero)
        label.text = text
        label.textColor = UIColor.black
        label.font = UIFont(name: "OpenSans-Regular", size: 16.0)

        stackView.addArrangedSubview(label)

        return stackView
    }

}
