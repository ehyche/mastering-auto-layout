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
        case header
        case axis
        case distribution
        case alignment
        case spacing
        case isBaselineRelativeArrangement
        case isLayoutMarginsRelativeArrangement
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

        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        displayStackView.translatesAutoresizingMaskIntoConstraints = false
        displayStackView.axis = .vertical
        displayStackView.distribution = .fill
        displayStackView.alignment = .fill
        displayStackView.isLayoutMarginsRelativeArrangement = true
        displayStackView.layoutMargins = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
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

        displayStackView.addArrangedSubview(headerLabel(withText: "UIStackView parameters", content: .header))
        displayStackView.addArrangedSubview(nameValueView(withName: "axis", andValue: currentSettings.axis.textDescription, content: .axis))
        displayStackView.addArrangedSubview(nameValueView(withName: "distribution", andValue: currentSettings.distribution.textDescription, content: .distribution))
        displayStackView.addArrangedSubview(nameValueView(withName: "alignment", andValue: currentSettings.alignment.textDescription, content: .alignment))
        displayStackView.addArrangedSubview(nameValueView(withName: "spacing", andValue: "\(currentSettings.spacing)", content: .spacing))
        displayStackView.addArrangedSubview(nameBooleanValueView(withName: "isBaselineRelativeArrangement", andValue: currentSettings.isBaselineRelativeArrangement, content: .isBaselineRelativeArrangement))
        displayStackView.addArrangedSubview(nameBooleanValueView(withName: "isLayoutMarginsRelativeArrangement", andValue: currentSettings.isLayoutMarginsRelativeArrangement, content: .isLayoutMarginsRelativeArrangement))
    }

    private func updateViewState() {
        updateRow(content: .header)
        updateRow(content: .axis)
        updateRow(content: .distribution)
        updateRow(content: .alignment)
        updateRow(content: .spacing)
        updateRow(content: .isBaselineRelativeArrangement)
        updateRow(content: .isLayoutMarginsRelativeArrangement)
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
                    break
                case .distribution:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.distribution == initialSettings.distribution ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = currentSettings.distribution.textDescription
                        rowValueLabel.textColor = textColor
                    }
                    break
                case .alignment:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.alignment == initialSettings.alignment ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = currentSettings.alignment.textDescription
                        rowValueLabel.textColor = textColor
                    }
                    break
                case .spacing:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowValueLabel = rowStackView.arrangedSubviews[1] as? UILabel {
                        let textColor = (currentSettings.spacing == initialSettings.spacing ? UIColor.blue : UIColor.red)
                        rowValueLabel.text = "\(currentSettings.spacing)"
                        rowValueLabel.textColor = textColor
                    }
                    break
                case .isBaselineRelativeArrangement:
                    if rowStackView.arrangedSubviews.count >= 2,
                       let rowSwitch = rowStackView.arrangedSubviews[1] as? UISwitch {
                        rowSwitch.isOn = currentSettings.isBaselineRelativeArrangement
                    }
                    break
                case .isLayoutMarginsRelativeArrangement:
                    if rowStackView.arrangedSubviews.count >= 2,
                        let rowSwitch = rowStackView.arrangedSubviews[1] as? UISwitch {
                        rowSwitch.isOn = currentSettings.isLayoutMarginsRelativeArrangement
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
        nameLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow-1, for: .horizontal)
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
        nameLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow-1, for: .horizontal)

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
                        if let updatedEnum = dataSource as? UILayoutConstraintAxis {
                            self?.currentSettings.axis = updatedEnum
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(axisController, animated: true)
                    break
                case .distribution:
                    let distController = EHMultipleChoiceViewController(withDataSource: currentSettings.distribution)
                    distController.updateBlock = { [weak self] (dataSource) in
                        if let updatedEnum = dataSource as? UIStackViewDistribution {
                            self?.currentSettings.distribution = updatedEnum
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(distController, animated: true)
                    break
                case .alignment:
                    let alignController = EHMultipleChoiceViewController(withDataSource: currentSettings.alignment)
                    alignController.updateBlock = { [weak self] (dataSource) in
                        if let updatedEnum = dataSource as? UIStackViewAlignment {
                            self?.currentSettings.alignment = updatedEnum
                        }
                        self?.updateRow(content: rowEnum)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    navigationController?.pushViewController(alignController, animated: true)
                    break
                case .spacing:
                    break
                case .isLayoutMarginsRelativeArrangement:
                    break
                case .isBaselineRelativeArrangement:
                    break
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
