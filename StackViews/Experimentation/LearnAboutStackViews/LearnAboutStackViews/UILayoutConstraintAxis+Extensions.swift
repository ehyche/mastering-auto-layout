//
//  UILayoutConstraintAxis+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
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

extension UILayoutConstraintAxis : EHMultipleChoiceDataSource {

    func title() -> String {
        return "UILayoutConstraintAxis"
    }

    func choiceCount() -> Int {
        return 2
    }

    func choiceText(atIndex: Int) -> String {
        var text = "Unknown"

        if let indexChoice = UILayoutConstraintAxis(rawValue: atIndex) {
            text = indexChoice.textDescription
        }

        return text
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        var selected = false

        if let indexChoice = UILayoutConstraintAxis(rawValue: atIndex) {
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
        if atIndex < 2 {
            let oppositeOfInputIndex = (atIndex == 0 ? 1 : 0)
            let updatedSelectedIndex = (selected ? atIndex : oppositeOfInputIndex)
            if updatedSelectedIndex != self.rawValue,
               let updatedEnum = UILayoutConstraintAxis(rawValue: updatedSelectedIndex) {
                self = updatedEnum
            }
        }
    }

}
