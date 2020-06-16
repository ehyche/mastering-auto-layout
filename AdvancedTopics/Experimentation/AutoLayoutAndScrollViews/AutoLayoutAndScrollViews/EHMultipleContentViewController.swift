//
//  EHMultipleContentViewController.swift
//  AutoLayoutAndScrollViews
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHMultipleContentViewController: UIViewController {

    private let scrollView = UIScrollView(frame: .zero)
    private let imageViewTim = UIImageView(image: UIImage(named: "tim"))
    private let imageViewSteve = UIImageView(image: UIImage(named: "steve"))
    private let imageViewGil = UIImageView(image: UIImage(named: "gil"))

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Multiple Content Views"

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

        // Add the three images to the scroll view's content, making SURE to set translatesAutoresizingMaskIntoConstraints = false
        imageViewGil.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageViewGil)
        imageViewSteve.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageViewSteve)
        imageViewTim.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageViewTim)

        // Now let's lay out the images left-to-right
        let views = ["gil": imageViewGil, "steve": imageViewSteve, "tim": imageViewTim]
        // These constraints are between the scroll view and a subview of the scroll view.
        // So they are referring to the scrollView's content, not the scrollView itself.
        let horzConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[gil]-[steve]-[tim]-|",
                                                             options: .alignAllTop,
                                                             metrics: nil,
                                                             views: views)
        NSLayoutConstraint.activate(horzConstraints)

        // Now we just need to align the first image vertically.
        // These constraints are between the scroll view and a subview of the scroll view.
        // So they are referring to the scrollView's content, not the scrollView itself.
        let vertConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[gil]-|",
                                                             options: NSLayoutFormatOptions(rawValue: 0),
                                                             metrics: nil,
                                                             views: views)
        NSLayoutConstraint.activate(vertConstraints)

        

    }


}
