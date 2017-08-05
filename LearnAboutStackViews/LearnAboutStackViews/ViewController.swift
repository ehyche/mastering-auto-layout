
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
    private let containerLabel = UILabel(frame: .zero)
    private let stackLabel = UILabel(frame: .zero)
    private let contentLabel = UILabel(frame: .zero)
    private let updateLabel = UILabel(frame: .zero)
    private let demonstrationStackView = EHColorableStackView(frame: .zero)

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
        bottomStackView.alignment = .fill
        bottomStackView.spacing = 20.0
        bottomStackView.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)

        containerLabel.text = "Container View"
        containerLabel.textColor = containerView.backgroundColor
        containerLabel.font = UIFont(name: "OpenSans-Bold", size: 24.0)

        stackLabel.text = "Stack View"
        stackLabel.textColor = demonstrationStackView.backgroundColor
        stackLabel.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        stackLabel.setContentHuggingPriority(UILayoutPriorityDefaultLow-1, for: .horizontal)

        contentLabel.text = "Content"
        contentLabel.textColor = UIColor.brown
        contentLabel.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        contentLabel.isUserInteractionEnabled = true
        let tapRecognizerContent = UITapGestureRecognizer(target: self, action: #selector(contentLabelTapped(recognizer:)))
        contentLabel.addGestureRecognizer(tapRecognizerContent)

        updateLabel.text = "Update"
        updateLabel.textColor = UIColor.blue
        updateLabel.font = UIFont(name: "OpenSans-Bold", size: 24.0)
        updateLabel.isUserInteractionEnabled = true
        let tapRecognizerUpdate = UITapGestureRecognizer(target: self, action: #selector(updateLabelTapped(recognizer:)))
        updateLabel.addGestureRecognizer(tapRecognizerUpdate)

        bottomStackView.addArrangedSubview(containerLabel)
        bottomStackView.addArrangedSubview(stackLabel)
        bottomStackView.addArrangedSubview(contentLabel)
        bottomStackView.addArrangedSubview(updateLabel)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(bottomStackView)
    }

    @objc func contentLabelTapped(recognizer: UIGestureRecognizer) {
        let contentController = EHStackViewContentViewController(arrangedSubviews: demonstrationStackView.arrangedSubviews)
        let navigationController = UINavigationController(rootViewController: contentController)

        contentController.cancelBlock = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }

        contentController.updateBlock = { [weak self] (updatedSubviews) in
            guard let strongSelf = self else {
                return
            }
            EHStackViewContentViewController.update(arrangedSubviews: updatedSubviews, inStackView: strongSelf.demonstrationStackView, animated: true, duration: 0.3)
            strongSelf.dismiss(animated: true, completion: nil)
        }

        navigationController.modalPresentationStyle = .popover
        navigationController.preferredContentSize = CGSize(width: 375.0, height: 320.0)
        navigationController.popoverPresentationController?.sourceView = contentLabel

        present(navigationController, animated: true, completion: nil)
    }

    @objc func updateLabelTapped(recognizer: UIGestureRecognizer) {
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
            EHStackViewSettingsModel.apply(settings: settings, toStackView: strongSelf.demonstrationStackView, inContainerView: strongSelf.containerView, animated: true, duration: 0.3, completion: nil)
            strongSelf.dismiss(animated: true, completion: nil)
        }

        navigationController.modalPresentationStyle = .popover
        navigationController.preferredContentSize = CGSize(width: 375.0, height: 320.0)
        navigationController.popoverPresentationController?.sourceView = updateLabel

        
        present(navigationController, animated: true, completion: nil)
    }

}

