//
//  Bool+Extensions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 8/1/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import Foundation

extension Bool: EHMultipleChoiceDataSource {

    func title() -> String {
        return "Boolean Selection"
    }

    func choiceCount() -> Int {
        return 2
    }

    func choiceText(atIndex: Int) -> String {
        let indexChoice: Bool = (atIndex == 0 ? true : false)
        return "\(indexChoice)"
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        let indexChoice: Bool = (atIndex == 0 ? true : false)
        return self == indexChoice
    }

    func canSelectMultipleChoices() -> Bool {
        return false
    }

    func canSelectChoice(atIndex: Int) -> Bool {
        return true
    }

    mutating func setChoice(selected: Bool, atIndex: Int) {
        if atIndex < choiceCount() && selected {
            let indexChoice: Bool = (atIndex == 0 ? true : false)
            self = indexChoice
        }
    }
    
}
