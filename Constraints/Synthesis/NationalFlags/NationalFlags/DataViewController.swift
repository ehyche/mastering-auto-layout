//
//  DataViewController.swift
//  NationalFlags
//
//  Created by Eric Hyche on 8/12/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""

    @IBOutlet weak var flagContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureFlag(forCountry: dataObject)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

    func configureFlag(forCountry country: String) {

        switch country {
            case "France":
                configureFlagFrance()
            case "Germany":
                configureFlagGermany()
            case "United Arab Emirates":
                configureFlagUAE()
            case "Norway":
                configureFlagNorway()
            default:
                break
        }
    }

    func configureFlagFrance() {
        // Your code here
    }

    func configureFlagGermany() {
        // Your code here
    }

    func configureFlagUAE() {
        // Your code here
    }

    func configureFlagNorway() {
        // Your code here
    }


}

