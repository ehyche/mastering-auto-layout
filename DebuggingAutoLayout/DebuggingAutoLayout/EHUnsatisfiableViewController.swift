//
//  EHUnsatisfiableViewController.swift
//  DebuggingAutoLayout
//
//  Created by Eric Hyche on 8/8/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHUnsatisfiableViewController: UIViewController {

    private let adjustable = EHAdjustableContainerView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Unsatisfiable Layouts"

        view.backgroundColor = UIColor.white

        adjustable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(adjustable)

        adjustable.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        adjustable.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        adjustable.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        adjustable.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true

        let label0 = UILabel(frame: .zero)
        label0.translatesAutoresizingMaskIntoConstraints = false
        label0.backgroundColor = UIColor.purple
        label0.textColor = UIColor.white
        label0.font = UIFont.boldSystemFont(ofSize: 18.0)
        label0.text = "This is a label"
        adjustable.containerView.addSubview(label0)

        label0.centerYAnchor.constraint(equalTo: adjustable.containerView.centerYAnchor).isActive = true
        label0.widthAnchor.constraint(greaterThanOrEqualToConstant: 100.0).isActive = true
        label0.leadingAnchor.constraint(equalTo: adjustable.containerView.layoutMarginsGuide.leadingAnchor).isActive = true
        label0.trailingAnchor.constraint(equalTo: adjustable.containerView.layoutMarginsGuide.trailingAnchor).isActive = true

    }


}
