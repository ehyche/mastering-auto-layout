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

        currentSettings.axis = .horizontal

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

        displayStackView.addArrangedSubview(headerLabel(withText: "UIStackView parameters"))
        displayStackView.addArrangedSubview(nameValueView(withName: "axis", andValue: currentSettings.axis.textDescription))
        displayStackView.addArrangedSubview(nameValueView(withName: "distribution", andValue: currentSettings.distribution.textDescription))
        displayStackView.addArrangedSubview(nameValueView(withName: "alignment", andValue: currentSettings.alignment.textDescription))
        displayStackView.addArrangedSubview(nameValueView(withName: "spacing", andValue: "\(currentSettings.spacing)"))
        displayStackView.addArrangedSubview(nameBooleanValueView(withName: "isBaselineRelativeArrangement", andValue: currentSettings.isBaselineRelativeArrangement))
        displayStackView.addArrangedSubview(nameBooleanValueView(withName: "isLayoutMarginsRelativeArrangement", andValue: currentSettings.isLayoutMarginsRelativeArrangement))
    }

    func headerLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: .zero)

        label.text = text
        label.font = UIFont(name: "OpenSans-Bold", size: 18.0)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.lightGray

        return label
    }

    func nameValueView(withName name: String, andValue value: String) -> UIStackView {
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

        let valueLabel = UILabel(frame: .zero)
        valueLabel.text = value
        valueLabel.textColor = UIColor.blue
        valueLabel.font = UIFont(name: "OpenSans-Regular", size: 14.0)

        let chevronImageView = UIImageView(image: UIImage(named: "chevron"))

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(chevronImageView)

        return stackView
    }

    func nameBooleanValueView(withName name: String, andValue value: Bool) -> UIStackView {
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

        return stackView
    }

    @objc func cancelTapped(sender: AnyObject) {
        cancelBlock?()
    }

    @objc func applyTapped(sender: AnyObject) {
        updateBlock?(currentSettings)
    }
}
