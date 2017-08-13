//
//  ViewController.swift
//  StackViewSynthesis3
//
//  Created by Eric Hyche on 8/6/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10.0).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10.0).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        // Add your code here
    }


}

