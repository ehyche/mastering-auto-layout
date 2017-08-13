//
//  MasterViewController.swift
//  XcodePanes
//
//  Created by Eric Hyche on 8/12/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    let cellID = "cellID"

    let stackView = UIStackView(frame: .zero)
    let leftPane = MasterViewController.createPaneLabel(withText: "Left Pane")
    let middlePane = UIStackView(frame: .zero)
    let rightPane = MasterViewController.createPaneLabel(withText: "Right Pane")
    let contentPane = MasterViewController.createPaneLabel(withText: "Content Pane")
    let contentStackView = UIStackView(frame: .zero)
    let bottomPane = MasterViewController.createPaneLabel(withText: "Bottom Pane")

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "XCode Panes"

        view.backgroundColor = UIColor.white

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Right", style: .plain, target: self, action: #selector(barButtonItemTapped(item:))),
            UIBarButtonItem(title: "Bottom", style: .plain, target: self, action: #selector(barButtonItemTapped(item:))),
            UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(barButtonItemTapped(item:)))
        ]

        // Configure the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0.0

        view.addSubview(stackView)

        // Pin the stack view to the view controller's root view
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        // Configure the content stack view
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.alignment = .fill
        contentStackView.spacing = 0.0

        // Make sure that it is the content view that gets stretched, and not the left or right panes
        leftPane.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        contentStackView.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        rightPane.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)

        contentPane.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)
        bottomPane.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)

        contentStackView.addArrangedSubview(contentPane)
        contentStackView.addArrangedSubview(bottomPane)

        // Add the left, content, and right panes to the stack view
        stackView.addArrangedSubview(leftPane)
        stackView.addArrangedSubview(contentStackView)
        stackView.addArrangedSubview(rightPane)

        // Make the bottom pane 10% of the stackView height
        let bottomHeight = bottomPane.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.10)
        bottomHeight.priority = UILayoutPriorityDefaultHigh
        bottomHeight.isActive = true

        // Make the left pane 25% of the stackView width, but at a lower priority
        let leftWidth = leftPane.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.25)
        leftWidth.priority = UILayoutPriorityDefaultHigh
        leftWidth.isActive = true

        // Make the right pane 25% of the stackView width but at a lower priority
        let rightWidth = rightPane.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.25)
        rightWidth.priority = UILayoutPriorityDefaultHigh
        rightWidth.isActive = true

    }

    class func createPaneLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textAlignment = .center
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }

    @objc func barButtonItemTapped(item: UIBarButtonItem) {
        if let itemTitle = item.title {
            var viewToToggle: UIView? = nil
            switch itemTitle {
                case "Left": viewToToggle = leftPane
                case "Bottom": viewToToggle = bottomPane
                case "Right": viewToToggle = rightPane
                default:
                    break
            }
            if let viewToToggle = viewToToggle {
                UIView.animate(withDuration: 0.3,
                               animations: {
                    viewToToggle.isHidden = !viewToToggle.isHidden
                })
            }
        }

    }

}

