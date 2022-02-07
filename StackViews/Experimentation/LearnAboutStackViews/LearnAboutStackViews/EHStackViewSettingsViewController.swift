//
//  EHStackViewSettingsViewController.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/30/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

typealias EHStackSettingsCancelBlock = () -> Void
typealias EHStackSettingsUpdateBlock = (EHStackViewSettingsModel) -> Void

/// This view controller displays the properties of the passed-in UIStackView,
/// and allows the user to modify these properties.
class EHStackViewSettingsViewController: UIViewController {

    // MARK: - Initializers

    init(stackViewSettings: EHStackViewSettingsModel) {
        initialSettings = stackViewSettings
        currentSettings = stackViewSettings
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "UIStackView Settings"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(applyTapped(sender:)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - External properties

    var cancelBlock: EHStackSettingsCancelBlock?
    var updateBlock: EHStackSettingsUpdateBlock?

    // MARK: - Internal properties

    enum RowContent: Int {
        case paramsHeader
        case axis
        case distribution
        case alignment
        case spacing
        case isBaselineRelativeArrangement
        case isLayoutMarginsRelativeArrangement
        case layoutMarginsHeader
        case layoutMarginsLeft
        case layoutMarginsTop
        case layoutMarginsRight
        case layoutMarginsBottom
        case pinningHeader
        case pinningValue
    }

    private let initialSettings: EHStackViewSettingsModel
    private var currentSettings: EHStackViewSettingsModel
    private let scrollView = UIScrollView(frame: .zero)
    private let displayStackView = UIStackView(frame: .zero)

    // MARK: - UIViewController overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        displayStackView.translatesAutoresizingMaskIntoConstraints = false
        displayStackView.axis = .vertical
        displayStackView.distribution = .fill
        displayStackView.alignment = .fill
        displayStackView.isLayoutMarginsRelativeArrangement = true
        displayStackView.layoutMargins = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
        displayStackView.spacing = 8.0

        scrollView.addSubview(displayStackView)

        displayStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        displayStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        displayStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        displayStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        displayStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        createViews()

        updateViewState()
    }

    private func createViews() {
        // Remove any arrangedSubviews
        let arrangedSubviews = displayStackView.arrangedSubviews
        for view in arrangedSubviews {
            view.removeFromSuperview()
        }

        displayStackView.addArrangedSubview(headerLabel(withText: "Parameters", content: .paramsHeader))
        displayStackView.addArrangedSubview(nameValueView(withName: "axis", andValue: currentSettings.axis.textDescription, content: .axis))
        displayStackView.addArrangedSubview(nameValueView(withName: "distribution", andValue: currentSettings.distribution.textDescription, content: .distribution))
        displayStackView.addArrangedSubview(nameValueView(withName: "alignment", andValue: currentSettings.alignment.textDescription, content: .alignment))
        displayStackView.addArrangedSubview(nameValueView(withName: "spacing", andValue: "\(currentSettings.spacing)", content: .spacing))
        displayStackView.addArrangedSubview(nameBooleanValueView(withName: "isBaselineRelativeArrangement", andValue: currentSettings.isBaselineRelativeArrangement, content: .isBaselineRelativeArrangement))
        displayStackView.addArrangedSubview(nameBooleanValueView(withName: "isLayoutMarginsRelativeArrangement", andValue: currentSettings.isLayoutMarginsRelativeArrangement, content: .isLayoutMarginsRelativeArrangement))
        displayStackView.addArrangedSubview(headerLabel(withText: "layoutMargins", content: .layoutMarginsHeader))
        displayStackView.addArrangedSubview(nameValueView(withName: "left", andValue: "\(currentSettings.layoutMargins.left)", content: .layoutMarginsLeft))
        displayStackView.addArrangedSubview(nameValueView(withName: "top", andValue: "\(currentSettings.layoutMargins.top)", content: .layoutMarginsTop))
        displayStackView.addArrangedSubview(nameValueView(withName: "right", andValue: "\(currentSettings.layoutMargins.right)", content: .layoutMarginsRight))
        displayStackView.addArrangedSubview(nameValueView(withName: "bottom", andValue: "\(currentSettings.layoutMargins.bottom)", content: .layoutMarginsBottom))
        displayStackView.addArrangedSubview(headerLabel(withText: "Pinning", content: .pinningHeader))
        displayStackView.addArrangedSubview(nameValueView(withName: "Anchors", andValue: currentSettings.pinning.textDescription, content: .pinningValue))
    }

    private func updateViewState() {
        // Headers are not updated since they don't change
        updateRow(content: .axis)
        updateRow(content: .distribution)
        updateRow(content: .alignment)
        updateRow(content: .spacing)
        updateRow(content: .isBaselineRelativeArrangement)
        updateRow(content: .isLayoutMarginsRelativeArrangement)
        updateRow(content: .layoutMarginsLeft)
        updateRow(content: .layoutMarginsTop)
        updateRow(content: .layoutMarginsRight)
        updateRow(content: .layoutMarginsBottom)
    }

    private func updateRow(content: RowContent) {
        if content.rawValue < displayStackView.arrangedSubviews.count,
           let rowStackView = displayStackView.arrangedSubviews[content.rawValue] as? UIStackView {
            switch content {
                case .axis:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.axis == initialSettings.axis ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = currentSettings.axis.textDescription
                        rowValueLabel.textColor = textColor
                    }
                case .distribution:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.distribution == initialSettings.distribution ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = currentSettings.distribution.textDescription
                        rowValueLabel.textColor = textColor
                    }
                case .alignment:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.alignment == initialSettings.alignment ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = currentSettings.alignment.textDescription
                        rowValueLabel.textColor = textColor
                    }
                case .spacing:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.spacing == initialSettings.spacing ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = "\(currentSettings.spacing)"
                        rowValueLabel.textColor = textColor
                    }
                case .isBaselineRelativeArrangement:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowSwitch = rowStackView.arrangedSubviews[1] as? UISwitch {
                        rowSwitch.isOn = currentSettings.isBaselineRelativeArrangement
                    }
                case .isLayoutMarginsRelativeArrangement:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowSwitch = rowStackView.arrangedSubviews[1] as? UISwitch {
                        rowSwitch.isOn = currentSettings.isLayoutMarginsRelativeArrangement
                    }
                case .layoutMarginsLeft:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                            let textColor = (currentSettings.layoutMargins.left == initialSettings.layoutMargins.left ? UIColor.blue : UIColor.red)
                            rowValueLabel.text = "\(currentSettings.layoutMargins.left)"
                            rowValueLabel.textColor = textColor
                    }
                case .layoutMarginsTop:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.layoutMargins.top == initialSettings.layoutMargins.top ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = "\(currentSettings.layoutMargins.top)"
                        rowValueLabel.textColor = textColor
                    }
                case .layoutMarginsRight:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.layoutMargins.right == initialSettings.layoutMargins.right ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = "\(currentSettings.layoutMargins.right)"
                        rowValueLabel.textColor = textColor
                    }
                case .layoutMarginsBottom:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.layoutMargins.bottom == initialSettings.layoutMargins.bottom ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = "\(currentSettings.layoutMargins.bottom)"
                        rowValueLabel.textColor = textColor
                    }
                case .pinningValue:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.pinning == initialSettings.pinning ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = currentSettings.pinning.textDescription
                        rowValueLabel.textColor = textColor
                    }
                    break
                default:
                    break
            }
        }
    }

    func headerLabel(withText text: String, content: RowContent) -> UILabel {
        let label = UILabel(frame: .zero)

        label.text = text
        label.font = UIFont(name: "OpenSans-Bold", size: 18.0)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.lightGray
        label.tag = content.rawValue

        return label
    }

    func nameValueView(withName name: String, andValue value: String, content: RowContent) -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0

        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont(name: "OpenSans-Semibold", size: 14.0)
        nameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow-1, for: .horizontal)
        nameLabel.isUserInteractionEnabled = true

        let valueLabel = UILabel(frame: .zero)
        valueLabel.text = value
        valueLabel.textColor = UIColor.blue
        valueLabel.font = UIFont(name: "OpenSans-Regular", size: 14.0)
        valueLabel.isUserInteractionEnabled = true

        let chevronImageView = UIImageView(image: UIImage(named: "chevron"))

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(chevronImageView)

        stackView.isUserInteractionEnabled = true
        stackView.tag = content.rawValue
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rowTapped(recognizer:))))

        return stackView
    }

    func nameBooleanValueView(withName name: String, andValue value: Bool, content: RowContent) -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10.0

        let nameLabel = UILabel(frame: .zero)
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont(name: "OpenSans-Semibold", size: 14.0)
        nameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow-1, for: .horizontal)

        let valueSwitch = UISwitch(frame: .zero)
        valueSwitch.isOn = value

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueSwitch)

        stackView.tag = content.rawValue
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rowTapped(recognizer:))))

        return stackView
    }

    @objc func rowTapped(recognizer: UIGestureRecognizer) {
        if let rowViewTag = recognizer.view?.tag,
           let rowEnum = RowContent(rawValue: rowViewTag) {
            switch rowEnum {
                case .axis:
                    let axisController = EHMultipleChoiceViewController(withDataSource: currentSettings.axis)
                    axisController.updateBlock = { [weak self] (dataSource) in
                        if let updatedEnum = dataSource as? NSLayoutConstraint.Axis {
                            self?.currentSettings.axis = updatedEnum
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(axisController, animated: true)
                case .distribution:
                    let distController = EHMultipleChoiceViewController(withDataSource: currentSettings.distribution)
                    distController.updateBlock = { [weak self] (dataSource) in
                        if let updatedEnum = dataSource as? UIStackView.Distribution {
                            self?.currentSettings.distribution = updatedEnum
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(distController, animated: true)
                case .alignment:
                    let alignController = EHMultipleChoiceViewController(withDataSource: currentSettings.alignment)
                    alignController.updateBlock = { [weak self] (dataSource) in
                        if let updatedEnum = dataSource as? UIStackView.Alignment {
                            self?.currentSettings.alignment = updatedEnum
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(alignController, animated: true)
                case .spacing:
                    let spacingController = EHMultipleChoiceViewController(withDataSource: currentSettings.spacing)
                    spacingController.updateBlock = { [weak self] (dataSource) in
                        if let updatedSpacing = dataSource as? CGFloat {
                            self?.currentSettings.spacing = updatedSpacing
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(spacingController, animated: true)
                case .isLayoutMarginsRelativeArrangement:
                    currentSettings.isLayoutMarginsRelativeArrangement = !currentSettings.isLayoutMarginsRelativeArrangement
                    updateRow(content: rowEnum)
                case .isBaselineRelativeArrangement:
                    currentSettings.isBaselineRelativeArrangement = !currentSettings.isBaselineRelativeArrangement
                    updateRow(content: rowEnum)
                case .layoutMarginsLeft:
                    let marginController = EHMultipleChoiceViewController(withDataSource: currentSettings.layoutMargins.left)
                    marginController.updateBlock = { [weak self] (dataSource) in
                        if let updatedMargin = dataSource as? CGFloat {
                            self?.currentSettings.layoutMargins.left = updatedMargin
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(marginController, animated: true)
                case .layoutMarginsTop:
                    let marginController = EHMultipleChoiceViewController(withDataSource: currentSettings.layoutMargins.top)
                    marginController.updateBlock = { [weak self] (dataSource) in
                        if let updatedMargin = dataSource as? CGFloat {
                            self?.currentSettings.layoutMargins.top = updatedMargin
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(marginController, animated: true)
                case .layoutMarginsRight:
                    let marginController = EHMultipleChoiceViewController(withDataSource: currentSettings.layoutMargins.right)
                    marginController.updateBlock = { [weak self] (dataSource) in
                        if let updatedMargin = dataSource as? CGFloat {
                            self?.currentSettings.layoutMargins.right = updatedMargin
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(marginController, animated: true)
                case .layoutMarginsBottom:
                    let marginController = EHMultipleChoiceViewController(withDataSource: currentSettings.layoutMargins.bottom)
                    marginController.updateBlock = { [weak self] (dataSource) in
                        if let updatedMargin = dataSource as? CGFloat {
                            self?.currentSettings.layoutMargins.bottom = updatedMargin
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(marginController, animated: true)
                case .pinningValue:
                    let pinningController = EHMultipleChoiceViewController(withDataSource: currentSettings.pinning)
                    pinningController.updateBlock = { [weak self] (dataSource) in
                        if let updatedPinning = dataSource as? EHPinningOptions {
                            self?.currentSettings.pinning = updatedPinning
                        }
                        self?.updateRow(content: rowEnum)
                    }
                    navigationController?.pushViewController(pinningController, animated: true)
                default:
                    break
            }
        }

    }

    @objc func cancelTapped(sender: AnyObject) {
        cancelBlock?()
    }

    @objc func applyTapped(sender: AnyObject) {
        updateBlock?(currentSettings)
    }
}
