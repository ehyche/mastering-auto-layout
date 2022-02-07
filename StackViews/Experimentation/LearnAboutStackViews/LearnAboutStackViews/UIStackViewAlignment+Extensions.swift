//
//  UIStackViewAlignment+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UIStackView.Alignment {

    var textDescription: String {
        switch self {
        case .fill: return "fill"
        case .leading: return "leading"
        case .firstBaseline: return "firstBaseline"
        case .center: return "center"
        case .trailing: return "trailing"
        case .lastBaseline: return "lastBaseline"
        @unknown default: return "unknown"
        }
    }
}

extension UIStackView.Alignment: EHMultipleChoiceDataSource {

    func title() -> String {
        return "UIStackViewAlignment"
    }

    func choiceCount() -> Int {
        return 6
    }

    func choiceText(atIndex: Int) -> String {
        var text = "Unknown"

        if let indexChoice = UIStackView.Alignment(rawValue: atIndex) {
            text = indexChoice.textDescription
        }

        return text
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        var selected = false

        if let indexChoice = UIStackView.Alignment(rawValue: atIndex) {
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
            if let updatedEnum = UIStackView.Alignment(rawValue: atIndex) {
                self = updatedEnum
            }
        }
    }

}
