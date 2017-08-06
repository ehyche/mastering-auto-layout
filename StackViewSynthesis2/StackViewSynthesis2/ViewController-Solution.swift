//
//  ViewController.swift
//  StackViewSynthesis2
//
//  Created by Eric Hyche on 8/3/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let rootStackView = UIStackView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let firstNameLabel = ViewController.nameLabel(text: "First")
    private let firstNameTextField = ViewController.nameTextField(placeholder: "Enter First Name")
    private let firstNameStackView = ViewController.nameRowStackView()
    private let middleNameLabel = ViewController.nameLabel(text: "Middle")
    private let middleNameTextField = ViewController.nameTextField(placeholder: "Enter Middle Name")
    private let middleNameStackView = ViewController.nameRowStackView()
    private let lastNameLabel = ViewController.nameLabel(text: "Last")
    private let lastNameTextField = ViewController.nameTextField(placeholder: "Enter Last Name")
    private let lastNameStackView = ViewController.nameRowStackView()
    private let nameRowsStackView = UIStackView(frame: .zero)
    private let upperStackView = UIStackView(frame: .zero)
    private let textView = UITextView(frame: .zero)
    private let saveButton = ViewController.actionButton(title: "Save")
    private let cancelButton = ViewController.actionButton(title: "Cancel")
    private let clearButton = ViewController.actionButton(title: "Clear")
    private let buttonStackView = UIStackView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        // Set up the root stack view
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .fill
        rootStackView.spacing = 8.0

        // Add it to the view hierarchy and anchor it
        view.addSubview(rootStackView)
        rootStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        rootStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        rootStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20.0).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: rootStackView.bottomAnchor, constant: 20.0).isActive = true

        // Make the image use a square aspect ratio and set a maximum width
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 80.0).isActive = true
        imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        // Add the label and text field to the first name stack view
        firstNameStackView.addArrangedSubview(firstNameLabel)
        firstNameStackView.addArrangedSubview(firstNameTextField)

        // Add the label and text field to the middle name stack view
        middleNameStackView.addArrangedSubview(middleNameLabel)
        middleNameStackView.addArrangedSubview(middleNameTextField)

        // Add the label and text field to the last name stack view
        lastNameStackView.addArrangedSubview(lastNameLabel)
        lastNameStackView.addArrangedSubview(lastNameTextField)

        // Add the first, middle, and last name stack views to the name rows stack view
        nameRowsStackView.axis = .vertical
        nameRowsStackView.distribution = .fill
        nameRowsStackView.alignment = .fill
        nameRowsStackView.spacing = 8.0
        nameRowsStackView.addArrangedSubview(firstNameStackView)
        nameRowsStackView.addArrangedSubview(middleNameStackView)
        nameRowsStackView.addArrangedSubview(lastNameStackView)

        // Add the image and the name rows stack view to the upper stack view
        upperStackView.axis = .horizontal
        upperStackView.distribution = .fill
        upperStackView.alignment = .fill
        upperStackView.spacing = 8.0
        upperStackView.addArrangedSubview(imageView)
        upperStackView.addArrangedSubview(nameRowsStackView)

        // Set up the text view
        textView.textColor = UIColor.black
        textView.text = "Notes:"
        textView.font = UIFont.systemFont(ofSize: 18.0)
        textView.backgroundColor = UIColor.lightGray

        // Add them to the button stack view
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .firstBaseline
        buttonStackView.spacing = 8.0
        buttonStackView.addArrangedSubview(saveButton)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(clearButton)

        rootStackView.addArrangedSubview(upperStackView)
        rootStackView.addArrangedSubview(textView)
        rootStackView.addArrangedSubview(buttonStackView)

        // Ensure that the first name, middle name, and last name text fields are the same width
        firstNameTextField.widthAnchor.constraint(equalTo: middleNameTextField.widthAnchor).isActive = true
        firstNameTextField.widthAnchor.constraint(equalTo: lastNameTextField.widthAnchor).isActive = true

    }

    class func nameLabel(text: String) -> UILabel {
        let label = UILabel(frame: .zero)

        label.text = text
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18.0)

        return label
    }

    class func nameTextField(placeholder: String) -> UITextField {
        let textField = UITextField(frame: .zero)

        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        return textField
    }

    class func nameRowStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .firstBaseline
        stackView.spacing = 8.0

        return stackView
    }

    class func actionButton(title: String) -> UIButton {
        let button = UIButton(frame: .zero)

        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.black, for: .highlighted)

        return button
    }

}

