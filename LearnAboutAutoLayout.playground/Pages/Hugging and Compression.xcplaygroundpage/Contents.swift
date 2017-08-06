import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let label0 = UILabel(frame: .zero)
label0.translatesAutoresizingMaskIntoConstraints = false
label0.backgroundColor = .purple
label0.text = "CH=750,CR=250"
label0.textColor = .white
label0.font = UIFont.systemFont(ofSize: 24.0)
label0.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
label0.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)

liveView.containerView.addSubview(label0)

let label1 = UILabel(frame: .zero)
label1.translatesAutoresizingMaskIntoConstraints = false
label1.backgroundColor = .brown
label1.text = "CH=250,CR=750"
label1.textColor = .white
label1.font = UIFont.systemFont(ofSize: 24.0)
label1.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: .horizontal)
label1.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, for: .horizontal)

liveView.containerView.addSubview(label0)
liveView.containerView.addSubview(label1)

// Assign the vertical center of the label to the vertical center of the container
let centerY0 = NSLayoutConstraint(item: label0, attribute: .centerY, relatedBy: .equal,
                                  toItem: liveView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
let centerY1 = NSLayoutConstraint(item: label1, attribute: .centerY, relatedBy: .equal,
                                  toItem: liveView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)

// Position the label0 20 points to the right of the left edge of the container
let label0leading = NSLayoutConstraint(item: label0, attribute: .leading, relatedBy: .equal,
                                       toItem: liveView.containerView, attribute: .leading, multiplier: 1.0, constant: 20.0)

// Position the label1 right edge 20 points from the right edge of the container
let label1trailing = NSLayoutConstraint(item: liveView.containerView, attribute: .trailing, relatedBy: .equal,
                                       toItem: label1, attribute: .trailing, multiplier: 1.0, constant: 20.0)

// Put some space between the labels
let label0label1gap = NSLayoutConstraint(item: label1, attribute: .leading, relatedBy: .equal,
                                         toItem: label0, attribute: .trailing, multiplier: 1.0, constant: 20.0)

// Then you need to add the constraints to the appropriate view.
// You add it to the most immediate common ancestor of both views involved in the constraint.
liveView.containerView.addConstraint(centerY0)
liveView.containerView.addConstraint(centerY1)
liveView.containerView.addConstraint(label0leading)
liveView.containerView.addConstraint(label1trailing)
liveView.containerView.addConstraint(label0label1gap)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

