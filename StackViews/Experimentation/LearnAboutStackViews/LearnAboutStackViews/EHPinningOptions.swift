//
//  EHPinningOptions.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 8/1/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

struct EHPinningOptions: OptionSet {
    let rawValue: Int

    static let none     = EHPinningOptions(rawValue: 0)
    static let leading  = EHPinningOptions(rawValue: 1 << 0)
    static let centerX  = EHPinningOptions(rawValue: 1 << 1)
    static let trailing = EHPinningOptions(rawValue: 1 << 2)
    static let top      = EHPinningOptions(rawValue: 1 << 3)
    static let centerY  = EHPinningOptions(rawValue: 1 << 4)
    static let bottom   = EHPinningOptions(rawValue: 1 << 5)

    var textDescription: String {
        get {
            return EHPinningOptions.toString(options: self)
        }
    }

    static func toString(options: EHPinningOptions) -> String {
        var optionStrings = [String]()

        if options.contains(.leading) {
            optionStrings.append("leading")
        }
        if options.contains(.centerX) {
            optionStrings.append("centerX")
        }
        if options.contains(.trailing) {
            optionStrings.append("trailing")
        }
        if options.contains(.top) {
            optionStrings.append("top")
        }
        if options.contains(.centerY) {
            optionStrings.append("centerY")
        }
        if options.contains(.bottom) {
            optionStrings.append("bottom")
        }

        var desc = ""
        if optionStrings.isEmpty {
            desc = "none"
        } else if optionStrings.count == 1 {
            desc = optionStrings[0]
        } else {
            desc = "\(optionStrings)"
        }

        return desc
    }

}

extension EHPinningOptions: EHMultipleChoiceDataSource {

    func title() -> String {
        return "Pinning Options"
    }

    func choiceCount() -> Int {
        return 6
    }

    func choiceText(atIndex: Int) -> String {
        var text = "unknown"

        if atIndex < choiceCount() {
            let option = EHPinningOptions(rawValue: (1 << atIndex))
            text = option.textDescription
        }

        return text
    }

    func isChoiceSelected(atIndex: Int) -> Bool {
        var selected = false

        if atIndex < choiceCount() {
            selected = contains(EHPinningOptions(rawValue: (1 << atIndex)))
        }

        return selected
    }

    func canSelectMultipleChoices() -> Bool {
        return true
    }

    func canSelectChoice(atIndex: Int) -> Bool {
        return true
    }

    mutating func setChoice(selected: Bool, atIndex: Int) {
        if atIndex < choiceCount() {
            let option = EHPinningOptions(rawValue: (1 << atIndex))
            if selected {
                insert(option)
            } else {
                remove(option)
            }
        }
    }
    
}
