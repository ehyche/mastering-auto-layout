//
//  EHStackViewContentViewController.swift
//  AutoLayoutAndScrollViews
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHStackViewContentViewController: UIViewController {

    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)
    private let imageViewTim = UIImageView(image: UIImage(named: "tim"))
    private let imageViewSteve = UIImageView(image: UIImage(named: "steve"))
    private let imageViewGil = UIImageView(image: UIImage(named: "gil"))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Stack View Content"

        // If we don't set this to false, then iOS tries to "help" us out
        // by automatically setting our vertical scroll view content insets for us
        // (to account for the translucent navigation bar).
        automaticallyAdjustsScrollViewInsets = false

        view.backgroundColor = UIColor.white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.lightGray
        view.addSubview(scrollView)

        // Pin the scroll view to the root view margins.
        // Since these are constraints between the container view and the scroll view,
        // then these contraints work exactly like we are used to.
        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20.0).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20.0).isActive = true

        // Configure the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = scrollView.layoutMargins.top

        // Put the stack view in the scroll view
        scrollView.addSubview(stackView)

        // Now pin the four edges of the stack view to the four edges of the scroll view.
        // Note that since these are anchors of the scroll view EDGES, then they refer to the content view of the scroll view,
        // and not the scroll view frame itself.
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: scrollView.layoutMargins.left).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: scrollView.layoutMargins.right).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: scrollView.layoutMargins.top).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: scrollView.layoutMargins.bottom).isActive = true

        // Add the images to the stack view
        stackView.addArrangedSubview(imageViewGil)
        stackView.addArrangedSubview(imageViewSteve)
        stackView.addArrangedSubview(imageViewTim)

    }

}
