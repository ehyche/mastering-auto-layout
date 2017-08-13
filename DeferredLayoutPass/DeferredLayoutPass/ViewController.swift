//
//  ViewController.swift
//  DeferredLayoutPass
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let redLabel = EHLabel(frame: .zero, withText: "Red", bgColor: UIColor.red)
    private let brownLabel = EHLabel(frame: .zero, withText: "Brown", bgColor: UIColor.brown)
    private let blackLabel = EHLabel(frame: .zero, withText: "Black", bgColor: UIColor.black)
    private let grayLabel = EHLabel(frame: .zero, withText: "Gray", bgColor: UIColor.darkGray)
    private let purpleLabel = EHLabel(frame: .zero, withText: "Purple", bgColor: UIColor.purple)
    private var redHeight = NSLayoutConstraint()
    private var blackHeight = NSLayoutConstraint()
    private var grayHeight = NSLayoutConstraint()
    private var purpleHeight = NSLayoutConstraint()
    private let shortHeight: CGFloat = 50.0
    private let tallHeight: CGFloat = 100.0
    private let margin: CGFloat = 20.0

    override func updateViewConstraints() {
        print("updateViewConstaints()")
        super.updateViewConstraints()
    }

    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews()")
        super.viewDidLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        // Add the labels
        redLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redLabel)
        brownLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(brownLabel)
        blackLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blackLabel)

        grayLabel.translatesAutoresizingMaskIntoConstraints = false
        brownLabel.addSubview(grayLabel)
        purpleLabel.translatesAutoresizingMaskIntoConstraints = false
        brownLabel.addSubview(purpleLabel)

        // Layout the red label manually
        redLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        redLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        redLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: margin).isActive = true

        // Layout the brown label below the red
        brownLabel.leadingAnchor.constraint(equalTo: redLabel.leadingAnchor).isActive = true
        brownLabel.trailingAnchor.constraint(equalTo: redLabel.trailingAnchor).isActive = true
        brownLabel.topAnchor.constraint(equalTo: redLabel.bottomAnchor, constant: margin).isActive = true

        // Layout the black label below the brown
        blackLabel.leadingAnchor.constraint(equalTo: redLabel.leadingAnchor).isActive = true
        blackLabel.trailingAnchor.constraint(equalTo: redLabel.trailingAnchor).isActive = true
        blackLabel.topAnchor.constraint(equalTo: brownLabel.bottomAnchor, constant: margin).isActive = true

        // Layout the gray label inside of the brown label
        grayLabel.leadingAnchor.constraint(equalTo: brownLabel.layoutMarginsGuide.leadingAnchor).isActive = true
        grayLabel.trailingAnchor.constraint(equalTo: brownLabel.layoutMarginsGuide.trailingAnchor).isActive = true
        grayLabel.topAnchor.constraint(equalTo: brownLabel.layoutMarginsGuide.topAnchor).isActive = true

        // Layout the purple label below the gray label
        purpleLabel.leadingAnchor.constraint(equalTo: grayLabel.leadingAnchor).isActive = true
        purpleLabel.trailingAnchor.constraint(equalTo: grayLabel.trailingAnchor).isActive = true
        purpleLabel.topAnchor.constraint(equalTo: grayLabel.bottomAnchor, constant: margin).isActive = true
        purpleLabel.bottomAnchor.constraint(equalTo: brownLabel.layoutMarginsGuide.bottomAnchor).isActive = true

        // Now set up the height constraints
        redHeight = redLabel.heightAnchor.constraint(equalToConstant: shortHeight)
        redHeight.isActive = true
        grayHeight = grayLabel.heightAnchor.constraint(equalToConstant: shortHeight)
        grayHeight.isActive = true
        purpleHeight = purpleLabel.heightAnchor.constraint(equalToConstant: shortHeight)
        purpleHeight.isActive = true
        blackHeight = blackLabel.heightAnchor.constraint(equalToConstant: shortHeight)
        blackHeight.isActive = true

        // Now set up click handlers
        redLabel.isUserInteractionEnabled = true
        redLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(recognizer:))))
        brownLabel.isUserInteractionEnabled = true
        grayLabel.isUserInteractionEnabled = true
        grayLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(recognizer:))))
        purpleLabel.isUserInteractionEnabled = true
        purpleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(recognizer:))))
        blackLabel.isUserInteractionEnabled = true
        blackLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(recognizer:))))
    }

    @objc func labelTapped(recognizer: UIGestureRecognizer) {
        if let label = recognizer.view as? UILabel, let labelText = label.text, !labelText.isEmpty {
            print("Label \(labelText) clicked")
            var constraint: NSLayoutConstraint? = nil
            switch labelText {
                case "Red": constraint = redHeight
                case "Gray": constraint = grayHeight
                case "Purple": constraint = purpleHeight
                case "Black": constraint = blackHeight
                default: break
            }
            if let constraint = constraint {
                print("Current Height is \(constraint.constant).")
                constraint.constant = (constraint.constant == shortHeight ? tallHeight : shortHeight)
            }
        }
    }

}

