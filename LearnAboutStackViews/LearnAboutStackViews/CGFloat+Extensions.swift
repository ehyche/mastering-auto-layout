//
//  CGFloat+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension CGFloat: EHMultipleChoiceDataSource {

    static let numberOfChoices = 25
    static let choiceDelta: CGFloat = 5.0

    func title() -> String {
        return "CGFloat Selection"
    }

    func choiceCount() -> Int {
        return CGFloat.numberOfChoices
    }

    func choiceText(atIndex: Int) -> String {
        return "\(CGFloat(atIndex) * CGFloat.choiceDelta)"
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        let indexValue = CGFloat(atIndex) * CGFloat.choiceDelta
        return indexValue == self
    }

    func canSelectMultipleChoices() -> Bool {
        return false
    }

    func canSelectChoice(atIndex: Int) -> Bool {
        return true
    }

    mutating func setChoice(selected: Bool, atIndex: Int) {
        if atIndex < choiceCount() && selected {
            let indexValue = CGFloat(atIndex) * CGFloat.choiceDelta
            self = indexValue
        }
    }

}
