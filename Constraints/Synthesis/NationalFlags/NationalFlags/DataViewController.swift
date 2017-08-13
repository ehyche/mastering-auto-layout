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
            case "Italy":
                configureFlagItaly()
            default:
                break
        }
    }

    func configureFlagFrance() {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0.0

        flagContainerView.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: flagContainerView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: flagContainerView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: flagContainerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: flagContainerView.bottomAnchor).isActive = true

        let blue = UIView(frame: .zero)
        blue.backgroundColor = UIColor.blue
        stackView.addArrangedSubview(blue)

        let white = UIView(frame: .zero)
        white.backgroundColor = UIColor.white
        stackView.addArrangedSubview(white)

        let red = UIView(frame: .zero)
        red.backgroundColor = UIColor.red
        stackView.addArrangedSubview(red)



    }

    func configureFlagItaly() {

    }


}

