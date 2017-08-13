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

        // Add stuff to the stack view here.


    }


}

