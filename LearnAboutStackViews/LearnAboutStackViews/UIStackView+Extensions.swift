//
//  UIStackView+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/30/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UILayoutConstraintAxis {

    var textDescription: String {
        get {
            var desc = ""
            switch self {
                case .horizontal: desc = "horizontal"
                case .vertical: desc = "vertical"
            }
            return desc
        }
    }

}

extension UIStackViewDistribution {

    var textDescription: String {
        get {
            var desc = ""
            switch self {
                case .equalCentering:     desc = "equalCentering"
                case .equalSpacing:       desc = "equalSpacing"
                case .fill:               desc = "fill"
                case .fillEqually:        desc = "fillEqually"
                case .fillProportionally: desc = "fillProportionally"
            }
            return desc
        }
    }
}

extension UIStackViewAlignment {

    var textDescription: String {
        get {
            var desc = ""
            switch self {
                case .center:        desc = "center"
                case .fill:          desc = "fill"
                case .firstBaseline: desc = "firstBaseline"
                case .lastBaseline:  desc = "lastBaseline"
                case .leading:       desc = "leading"
                case .trailing:      desc = "trailing"
            }
            return desc
        }
    }
}

