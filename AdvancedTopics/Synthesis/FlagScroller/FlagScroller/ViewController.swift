//
//  ViewController.swift
//  FlagScroller
//
//  Created by Eric Hyche on 8/13/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

struct EHFlagNamePair {
    var flagImageName: String
    var countryName: String
}

class ViewController: UIViewController {

    let scrollView = UIScrollView(frame: .zero)
    let pairs = [
        EHFlagNamePair(flagImageName: "austria", countryName: "Austria"),
        EHFlagNamePair(flagImageName: "france",  countryName: "France"),
        EHFlagNamePair(flagImageName: "greece",  countryName: "Greece"),
        EHFlagNamePair(flagImageName: "ireland", countryName: "Ireland"),
        EHFlagNamePair(flagImageName: "italy",   countryName: "Italy"),
        EHFlagNamePair(flagImageName: "netherlands", countryName: "Netherlands"),
        EHFlagNamePair(flagImageName: "romania", countryName: "Romania"),
        EHFlagNamePair(flagImageName: "united-kingdom", countryName: "United Kingdom")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.lightGray

        automaticallyAdjustsScrollViewInsets = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.white
        view.addSubview(scrollView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20.0).isActive = true
        scrollView.heightAnchor.constraint(lessThanOrEqualToConstant: 140.0).isActive = true

        let rowView = EHFlagNameRowStackView(frame: .zero, pairs: pairs)
        rowView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rowView)

        rowView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        rowView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        rowView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        rowView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        rowView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true

    }


}

