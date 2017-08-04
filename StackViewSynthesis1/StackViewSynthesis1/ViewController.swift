//
//  ViewController.swift
//  StackViewSynthesis1
//
//  Created by Eric Hyche on 8/3/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let outerHorzStackView = UIStackView(frame: .zero)
    private let navigationPane = UIView(frame: .zero)
    private let contentVertStackView = UIStackView(frame: .zero)
    private let editorPane = UIView(frame: .zero)
    private let debugHorzStackView = UIStackView(frame: .zero)
    private let variablesPane = UIView(frame: .zero)
    private let consolePane = UIView(frame: .zero)
    private let utilitiesPane = UIView(frame: .zero)

    private let panelWidth: CGFloat = 150.0
    private let panelHeight: CGFloat = 150.0

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        navigationItem.title = "Xcode Pane Synthesis Exercise"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Navigation", style: .done, target: self, action: #selector(barButtonItemTapped(sender:)))

        let debugItem = UIBarButtonItem(title: "Debug", style: .done, target: self, action: #selector(barButtonItemTapped(sender:)))
        let utilitiesItem = UIBarButtonItem(title: "Utilities", style: .done, target: self, action: #selector(barButtonItemTapped(sender:)))

        navigationItem.rightBarButtonItems = [utilitiesItem, debugItem]


        outerHorzStackView.translatesAutoresizingMaskIntoConstraints = false
        outerHorzStackView.axis = .horizontal
        outerHorzStackView.distribution = .fill
        outerHorzStackView.alignment = .fill

        view.addSubview(outerHorzStackView)

        outerHorzStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        outerHorzStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        outerHorzStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        outerHorzStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        // Add navigation pane
        navigationPane.translatesAutoresizingMaskIntoConstraints = false
        navigationPane.backgroundColor = .yellow
        navigationPane.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        let navWidth = navigationPane.widthAnchor.constraint(equalToConstant: panelWidth)
        navWidth.priority = 750
        navWidth.isActive = true
        outerHorzStackView.addArrangedSubview(navigationPane)

        // Configure content stack view
        contentVertStackView.translatesAutoresizingMaskIntoConstraints = false
        contentVertStackView.axis = .vertical
        contentVertStackView.distribution = .fill
        contentVertStackView.alignment = .fill
        contentVertStackView.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
        let contentWidth = contentVertStackView.widthAnchor.constraint(equalToConstant: 200.0)
        contentWidth.priority = 750
        contentWidth.isActive = true
        outerHorzStackView.addArrangedSubview(contentVertStackView)

        // Add the utilities pane
        utilitiesPane.translatesAutoresizingMaskIntoConstraints = false
        utilitiesPane.backgroundColor = .purple
        contentVertStackView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        let utilitiesWidth = utilitiesPane.widthAnchor.constraint(equalToConstant: panelWidth)
        utilitiesWidth.priority = 750
        utilitiesWidth.isActive = true
        outerHorzStackView.addArrangedSubview(utilitiesPane)

        // Add editor pane to content vertical stack view
        editorPane.translatesAutoresizingMaskIntoConstraints = false
        editorPane.backgroundColor = UIColor.orange
        editorPane.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .vertical)
        let editorHeight = editorPane.heightAnchor.constraint(equalToConstant: 200.0)
        editorHeight.priority = 750
        editorHeight.isActive = true

        contentVertStackView.addArrangedSubview(editorPane)

        // Add debug stack view
        debugHorzStackView.translatesAutoresizingMaskIntoConstraints = false
        debugHorzStackView.axis = .horizontal
        debugHorzStackView.distribution = .fillEqually
        debugHorzStackView.alignment = .fill
        debugHorzStackView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .vertical)
        let debugHeight = debugHorzStackView.heightAnchor.constraint(equalToConstant: panelHeight)
        debugHeight.priority = 750
        debugHeight.isActive = true

        contentVertStackView.addArrangedSubview(debugHorzStackView)

        // Add variables pane to debug stack view
        variablesPane.translatesAutoresizingMaskIntoConstraints = false
        variablesPane.backgroundColor = .blue

        debugHorzStackView.addArrangedSubview(variablesPane)

        // Add the console pane
        consolePane.translatesAutoresizingMaskIntoConstraints = false
        consolePane.backgroundColor = .green

        debugHorzStackView.addArrangedSubview(consolePane)

    }

    @objc private func barButtonItemTapped(sender: UIBarButtonItem) {

        if sender.title == "Navigation" {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationPane.isHidden = !self.navigationPane.isHidden
            })
        } else if sender.title == "Debug" {
            UIView.animate(withDuration: 0.3, animations: {
                self.debugHorzStackView.isHidden = !self.debugHorzStackView.isHidden
            })
        } else if sender.title == "Utilities" {
            UIView.animate(withDuration: 0.3, animations: {
                self.utilitiesPane.isHidden = !self.utilitiesPane.isHidden
            })
        }

    }


}

