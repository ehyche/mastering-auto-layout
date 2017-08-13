//
//  UIStackViewDistribution+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UIStackViewDistribution {

    var textDescription: String {
        get {
            var desc = ""
            switch self {
                case .fill:               desc = "fill"
                case .fillEqually:        desc = "fillEqually"
                case .fillProportionally: desc = "fillProportionally"
                case .equalSpacing:       desc = "equalSpacing"
                case .equalCentering:     desc = "equalCentering"
            }
            return desc
        }
    }
}

extension UIStackViewDistribution : EHMultipleChoiceDataSource {

    func title() -> String {
        return "UIStackViewDistribution"
    }

    func choiceCount() -> Int {
        return 5
    }

    func choiceText(atIndex: Int) -> String {
        var text = "Unknown"

        if let indexChoice = UIStackViewDistribution(rawValue: atIndex) {
            text = indexChoice.textDescription
        }

        return text
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        var selected = false

        if let indexChoice = UIStackViewDistribution(rawValue: atIndex) {
            selected = (indexChoice == self)
        }

        return selected
    }
    
    func canSelectMultipleChoices() -> Bool {
        return false
    }

    func canSelectChoice(atIndex: Int) -> Bool {
        return true
    }

    mutating func setChoice(selected: Bool, atIndex: Int) {
        if atIndex < choiceCount() && selected {
            if let updatedEnum = UIStackViewDistribution(rawValue: atIndex) {
                self = updatedEnum
            }
        }
    }

}
