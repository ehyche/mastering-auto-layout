//
//  MasterViewController.swift
//  XcodePanes
//
//  Created by Eric Hyche on 8/12/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "XCode Panes"

        view.backgroundColor = UIColor.white

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Right", style: .plain, target: self, action: #selector(barButtonItemTapped(item:))),
            UIBarButtonItem(title: "Bottom", style: .plain, target: self, action: #selector(barButtonItemTapped(item:))),
            UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(barButtonItemTapped(item:)))
        ]

        // Your code goes here
    }

    @objc func barButtonItemTapped(item: UIBarButtonItem) {
        // Implement show/hide code here
    }

}

