
//
//  ViewController.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/30/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let stackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private let bottomStackView = UIStackView(frame: .zero)
    private let contentButton = UIButton(frame: .zero)
    private let parametersButton = UIButton(frame: .zero)
    private let animatedLabel = UILabel(frame: .zero)
    private let animatedSwitch = UISwitch(frame: .zero)
    private let demonstrationStackView = EHColorableStackView(frame: .zero)
    private var animated = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)

        view.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true

        titleLabel.text = "Learn About Stack Views"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)

        containerView.backgroundColor = UIColor.darkGray
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 2.0
        containerView.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)

        demonstrationStackView.translatesAutoresizingMaskIntoConstraints = false
        demonstrationStackView.backgroundColor = UIColor.lightGray
        demonstrationStackView.axis = .vertical
        demonstrationStackView.distribution = .fill
        demonstrationStackView.alignment = .center
        containerView.addSubview(demonstrationStackView)

        demonstrationStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        demonstrationStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

        let defaultViews = EHStackViewContentViewController.defaultArrangedSubviews()
        for defaultView in defaultViews {
            demonstrationStackView.addArrangedSubview(defaultView)
        }

        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fill
        bottomStackView.alignment = .center
        bottomStackView.spacing = 20.0
        bottomStackView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)

        contentButton.setTitle("Content", for: .normal)
        contentButton.setTitleColor(UIColor.darkGray, for: .normal)
        contentButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        contentButton.addTarget(self, action: #selector(contentButtonTapped(sender:)), for: .touchUpInside)

        parametersButton.setTitle("Parameters", for: .normal)
        parametersButton.setTitleColor(UIColor.darkGray, for: .normal)
        parametersButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        parametersButton.setContentHuggingPriority(UILayoutPriorityDefaultLow-1, for: .horizontal)
        parametersButton.addTarget(self, action: #selector(parametersButtonTapped(sender:)), for: .touchUpInside)

        animatedLabel.text = "Animated"
        animatedLabel.textColor = UIColor.darkGray
        animatedLabel.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        animatedLabel.isUserInteractionEnabled = true
        animatedLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animatedLabelTapped(recognizer:))))

        animatedSwitch.isOn = animated
        animatedSwitch.addTarget(self, action: #selector(animatedSwitchValueChanged(sender:)), for: .valueChanged)

        bottomStackView.addArrangedSubview(contentButton)
        bottomStackView.addArrangedSubview(parametersButton)
        bottomStackView.addArrangedSubview(animatedLabel)
        bottomStackView.addArrangedSubview(animatedSwitch)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(bottomStackView)
    }

    @objc private func contentButtonTapped(sender: UIButton) {
        let contentController = EHStackViewContentViewController(arrangedSubviews: demonstrationStackView.arrangedSubviews)
        let navigationController = UINavigationController(rootViewController: contentController)

        contentController.cancelBlock = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        contentController.updateBlock = { [weak self] (updatedSubviews) in
            guard let strongSelf = self else {
                return
            }
            EHStackViewContentViewController.update(arrangedSubviews: updatedSubviews, inStackView: strongSelf.demonstrationStackView, animated: strongSelf.animated, duration: 0.3)
            strongSelf.dismiss(animated: true, completion: nil)
        }

        navigationController.modalPresentationStyle = .popover
        navigationController.preferredContentSize = CGSize(width: 375.0, height: 320.0)
        navigationController.popoverPresentationController?.sourceView = contentButton
        let sourceRect = CGRect(x: contentButton.frame.size.width / 2.0, y: 0.0, width: 1.0, height: 1.0)
        navigationController.popoverPresentationController?.sourceRect = sourceRect

        present(navigationController, animated: true, completion: nil)
    }

    @objc private func parametersButtonTapped(sender: UIButton) {
        let stackViewSettings = EHStackViewSettingsModel.settingsModel(fromStackView: demonstrationStackView, inContainerView: containerView)
        let stackViewSettingsController = EHStackViewSettingsViewController(stackViewSettings: stackViewSettings)
        let navigationController = UINavigationController(rootViewController: stackViewSettingsController)

        stackViewSettingsController.cancelBlock = {[weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        stackViewSettingsController.updateBlock = {[weak self] (settings: EHStackViewSettingsModel) in
            guard let strongSelf = self else {
                return
            }
            EHStackViewSettingsModel.apply(settings: settings, toStackView: strongSelf.demonstrationStackView, inContainerView: strongSelf.containerView, animated: strongSelf.animated, duration: 0.3, completion: nil)
            strongSelf.dismiss(animated: true, completion: nil)
        }

        navigationController.modalPresentationStyle = .popover
        navigationController.preferredContentSize = CGSize(width: 375.0, height: 320.0)
        navigationController.popoverPresentationController?.sourceView = parametersButton
        let sourceRect = CGRect(x: parametersButton.frame.size.width / 2.0, y: 0.0, width: 1.0, height: 1.0)
        navigationController.popoverPresentationController?.sourceRect = sourceRect

        
        present(navigationController, animated: true, completion: nil)
    }

    @objc private func animatedSwitchValueChanged(sender: UISwitch) {
        animated = sender.isOn
    }

    @objc private func animatedLabelTapped(recognizer: UIGestureRecognizer) {
        animated = !animated
        animatedSwitch.setOn(animated, animated: true)
    }

}

