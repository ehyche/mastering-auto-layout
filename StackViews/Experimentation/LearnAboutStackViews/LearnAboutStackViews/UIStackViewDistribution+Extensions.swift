//
//  UIStackViewDistribution+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UIStackView.Distribution {

    var textDescription: String {
        switch self {
        case .fill: return "fill"
        case .fillEqually: return "fillEqually"
        case .fillProportionally: return "fillProportionally"
        case .equalSpacing: return "equalSpacing"
        case .equalCentering: return "equalCentering"
        @unknown default: return "unknown"
        }
    }
}

extension UIStackView.Distribution : EHMultipleChoiceDataSource {

    func title() -> String {
        return "UIStackViewDistribution"
    }

    func choiceCount() -> Int {
        return 5
    }

    func choiceText(atIndex: Int) -> String {
        var text = "Unknown"

        if let indexChoice = UIStackView.Distribution(rawValue: atIndex) {
            text = indexChoice.textDescription
        }

        return text
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        var selected = false

        if let indexChoice = UIStackView.Distribution(rawValue: atIndex) {
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
            if let updatedEnum = UIStackView.Distribution(rawValue: atIndex) {
                self = updatedEnum
            }
        }
    }

}
