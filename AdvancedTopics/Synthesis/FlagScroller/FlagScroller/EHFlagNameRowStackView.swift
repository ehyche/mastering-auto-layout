//
//  EHFlagNameRowStackView.swift
//  FlagScroller
//
//  Created by Eric Hyche on 8/13/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHFlagNameRowStackView: UIStackView {

    init(frame: CGRect, pairs: [EHFlagNamePair]) {
        super.init(frame: frame)

        axis = .horizontal
        distribution = .fill
        alignment = .fill
        spacing = 10.0
        layoutMargins = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        isLayoutMarginsRelativeArrangement = true

        for pair in pairs {
            let pairView = EHFlagNameStackView(frame: .zero, imageName: pair.flagImageName, countryName: pair.countryName)
            addArrangedSubview(pairView)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
