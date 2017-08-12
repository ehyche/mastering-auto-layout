//
//  EHFloatingContentViewController.swift
//  AutoLayoutAndScrollViews
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHFloatingContentViewController: UIViewController {

    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)
    private var headerCount = 0
    private var rowCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Floating Content"

        view.backgroundColor = UIColor.white

        let headerBarButtonItem = UIBarButtonItem(title: "Header", style: .plain, target: self, action: #selector(addHeaderButtonTapped(sender:)))
        let rowBarButtonItem = UIBarButtonItem(title: "Row", style: .plain, target: self, action: #selector(addRowButtonTapped(sender:)))
        navigationItem.rightBarButtonItems = [rowBarButtonItem, headerBarButtonItem]

        // If we don't set this to false, then iOS tries to "help" us out
        // by automatically setting our vertical scroll view content insets for us
        // (to account for the translucent navigation bar).
        automaticallyAdjustsScrollViewInsets = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // Pin the scroll view to the root view margins.
        // Since these are constraints between the container view and the scroll view,
        // then these contraints work exactly like we are used to.
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        // Configure the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4.0

        // Put the stack view in the scroll view
        scrollView.addSubview(stackView)

        // Now pin the four edges of the stack view to the four edges of the scroll view.
        // Note that since these are anchors of the scroll view EDGES, then they refer to the content view of the scroll view,
        // and not the scroll view frame itself.
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        // Since we are using stackView.alignment = .fill, then we want the stack view to stretch the rows
        // to fill the width of the scroll view. So we need to make the stack view with be the same as the scroll view width.
        //  Note that since this is a width anchor it refers to the scrollView frame, not the content view
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true


    }

    @objc func addHeaderButtonTapped(sender: AnyObject) {
        let headerLabel = UILabel(frame: .zero)
        headerLabel.backgroundColor = UIColor.lightGray
        headerLabel.textColor = UIColor.black
        headerLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        headerLabel.text = "Header \(headerCount)"
        headerLabel.textAlignment = .center

        stackView.addArrangedSubview(headerLabel)
        headerCount = headerCount + 1
    }

    @objc func addRowButtonTapped(sender: AnyObject) {
        let headerLabel = UILabel(frame: .zero)
        headerLabel.backgroundColor = UIColor.white
        headerLabel.textColor = UIColor.black
        headerLabel.font = UIFont.systemFont(ofSize: 16.0)
        headerLabel.text = "Row \(rowCount)"
        headerLabel.textAlignment = .center

        stackView.addArrangedSubview(headerLabel)
        rowCount = rowCount + 1
    }

}
