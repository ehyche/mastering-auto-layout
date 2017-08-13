//
//  UIStackViewAlignment+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UIStackViewAlignment {

    var textDescription: String {
        get {
            var desc = ""
            switch self {
                case .fill:          desc = "fill"
                case .leading:       desc = "leading"
                case .firstBaseline: desc = "firstBaseline"
                case .center:        desc = "center"
                case .trailing:      desc = "trailing"
                case .lastBaseline:  desc = "lastBaseline"
            }
            return desc
        }
    }
}

extension UIStackViewAlignment: EHMultipleChoiceDataSource {

    func title() -> String {
        return "UIStackViewAlignment"
    }

    func choiceCount() -> Int {
        return 6
    }

    func choiceText(atIndex: Int) -> String {
        var text = "Unknown"

        if let indexChoice = UIStackViewAlignment(rawValue: atIndex) {
            text = indexChoice.textDescription
        }

        return text
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        var selected = false

        if let indexChoice = UIStackViewAlignment(rawValue: atIndex) {
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
            if let updatedEnum = UIStackViewAlignment(rawValue: atIndex) {
                self = updatedEnum
            }
        }
    }

}
