//
//  EHStackViewSettingsModel.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/30/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

typealias EHStackViewSettingsAnimationBlock = () -> Void
typealias EHStackViewSettingsCompletionBlock = (_ finished: Bool) -> Void

struct EHPinningOptions: OptionSet {
    let rawValue: Int

    static let none     = EHPinningOptions(rawValue: 0)
    static let top      = EHPinningOptions(rawValue: 1 << 0)
    static let centerY  = EHPinningOptions(rawValue: 1 << 1)
    static let bottom   = EHPinningOptions(rawValue: 1 << 2)
    static let leading  = EHPinningOptions(rawValue: 1 << 3)
    static let centerX  = EHPinningOptions(rawValue: 1 << 4)
    static let trailing = EHPinningOptions(rawValue: 1 << 5)
}

struct EHStackViewSettingsModel {
    var axis: UILayoutConstraintAxis
    var distribution: UIStackViewDistribution
    var alignment: UIStackViewAlignment
    var spacing: CGFloat
    var isBaselineRelativeArrangement: Bool
    var isLayoutMarginsRelativeArrangement: Bool
    var layoutMargins: UIEdgeInsets
    var pinning: EHPinningOptions
}

extension EHStackViewSettingsModel {

    static func settingsModel(fromStackView stackView: UIStackView, inContainerView containerView: UIView) -> EHStackViewSettingsModel {
        let pinning = computePinning(forStackView: stackView, inContainerView: containerView)
        return EHStackViewSettingsModel(axis: stackView.axis,
                                        distribution: stackView.distribution,
                                        alignment: stackView.alignment,
                                        spacing: stackView.spacing,
                                        isBaselineRelativeArrangement: stackView.isBaselineRelativeArrangement,
                                        isLayoutMarginsRelativeArrangement: stackView.isLayoutMarginsRelativeArrangement,
                                        layoutMargins: stackView.layoutMargins,
                                        pinning: pinning)
    }

    static func apply(settings: EHStackViewSettingsModel, toStackView stackView: UIStackView, inContainerView containerView: UIView, animated: Bool, duration: TimeInterval, completion: EHStackViewSettingsCompletionBlock?) {
        let animationBlock: EHStackViewSettingsAnimationBlock = {
            if settings.axis != stackView.axis {
                stackView.axis = settings.axis
            }
            if settings.distribution != stackView.distribution {
                stackView.distribution = settings.distribution
            }
            if settings.alignment != stackView.alignment {
                stackView.alignment = settings.alignment
            }
            if settings.spacing != stackView.spacing {
                stackView.spacing = settings.spacing
            }
            if settings.isBaselineRelativeArrangement != stackView.isBaselineRelativeArrangement {
                stackView.isBaselineRelativeArrangement = settings.isBaselineRelativeArrangement
            }
            if settings.isLayoutMarginsRelativeArrangement != stackView.isLayoutMarginsRelativeArrangement {
                stackView.isLayoutMarginsRelativeArrangement = settings.isLayoutMarginsRelativeArrangement
            }
            if settings.layoutMargins != stackView.layoutMargins {
                stackView.layoutMargins = settings.layoutMargins
            }
            let pinning = computePinning(forStackView: stackView, inContainerView: containerView)
            if settings.pinning != pinning {
                // Remove the stack view from the container view. This will blow away all constraints.
                stackView.removeFromSuperview()
                // Now re-add it
                containerView.addSubview(stackView)
                // Re-apply the new constraints
                apply(pinning: settings.pinning, toStackView: stackView, inContainerView: containerView)
            }
        }
        if animated {
            UIView.animate(withDuration: duration,
                           animations: animationBlock,
                           completion: completion)
        } else {
            animationBlock()
        }
    }

    static func apply(pinning: EHPinningOptions, toStackView stackView: UIStackView, inContainerView containerView: UIView) {
        if pinning.contains(.bottom) {
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        }
        if pinning.contains(.centerX) {
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        }
        if pinning.contains(.centerY) {
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
        if pinning.contains(.leading) {
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        }
        if pinning.contains(.top) {
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        }
        if pinning.contains(.trailing) {
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        }
    }

    static func computePinning(forStackView stackView: UIStackView, inContainerView containerView: UIView) -> EHPinningOptions {
        // Get all the contraints on the stackView
        var pinning: EHPinningOptions = EHPinningOptions.none
        let constraints = stackView.constraints
        for constraint in constraints {
            // This has to be a constraint between two views
            if let firstView = constraint.firstItem as? UIView,
               let secondView = constraint.secondItem as? UIView {
                // Sort out which is the stack view and which is the container view
                var stackViewAttribute: NSLayoutAttribute = .notAnAttribute
                var containerViewAttribute: NSLayoutAttribute = .notAnAttribute
                if firstView == stackView && secondView == containerView {
                    stackViewAttribute = constraint.firstAttribute
                    containerViewAttribute = constraint.secondAttribute
                } else if firstView == containerView && secondView == stackView {
                    stackViewAttribute = constraint.secondAttribute
                    containerViewAttribute = constraint.firstAttribute
                }
                let pinOption = pinningOption(stackViewAttribute: stackViewAttribute, containerViewAttribute: containerViewAttribute)
                pinning.update(with: pinOption)
            }
        }
        return pinning
    }


    static func pinningOption(stackViewAttribute: NSLayoutAttribute, containerViewAttribute: NSLayoutAttribute) -> EHPinningOptions {
        var option: EHPinningOptions = EHPinningOptions.none

        switch (stackViewAttribute,containerViewAttribute) {
            case (.bottom, .bottom):
                option = EHPinningOptions.bottom
            case (.bottom, .bottomMargin):
                option = EHPinningOptions.bottom
            case (.bottomMargin, .bottom):
                option = EHPinningOptions.bottom
            case (.bottomMargin, .bottomMargin):
                option = EHPinningOptions.bottom
            case (.centerX, .centerX):
                option = EHPinningOptions.centerX
            case (.centerXWithinMargins, .centerX):
                option = EHPinningOptions.centerX
            case (.centerX, .centerXWithinMargins):
                option = EHPinningOptions.centerX
            case (.centerXWithinMargins, .centerXWithinMargins):
                option = EHPinningOptions.centerX
            case (.centerY, .centerY):
                option = EHPinningOptions.centerY
            case (.centerYWithinMargins, .centerY):
                option = EHPinningOptions.centerY
            case (.centerY, .centerYWithinMargins):
                option = EHPinningOptions.centerY
            case (.centerYWithinMargins, .centerYWithinMargins):
                option = EHPinningOptions.centerY
            case (.leading, .leading):
                option = EHPinningOptions.leading
            case (.leading, .leadingMargin):
                option = EHPinningOptions.leading
            case (.leadingMargin, .leading):
                option = EHPinningOptions.leading
            case (.leadingMargin, .leadingMargin):
                option = EHPinningOptions.leading
            case (.top, .top):
                option = EHPinningOptions.top
            case (.topMargin, .top):
                option = EHPinningOptions.top
            case (.top, .topMargin):
                option = EHPinningOptions.top
            case (.topMargin, .topMargin):
                option = EHPinningOptions.top
            case (.trailing, .trailing):
                option = EHPinningOptions.trailing
            case (.trailing, .trailingMargin):
                option = EHPinningOptions.trailing
            case (.trailingMargin, .trailing):
                option = EHPinningOptions.trailing
            case (.trailingMargin, .trailingMargin):
                option = EHPinningOptions.trailing
            default:
                break
        }

        return option
    }

}

