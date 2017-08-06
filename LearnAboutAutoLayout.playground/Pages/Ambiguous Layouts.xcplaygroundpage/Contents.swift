import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let label = UILabel(frame: .zero)
label.translatesAutoresizingMaskIntoConstraints = false
label.backgroundColor = .purple
label.text = "111"
label.textColor = .white
label.font = UIFont.systemFont(ofSize: 32.0)

liveView.containerView.addSubview(label)

// Let's center the label vertically.
let centerY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
liveView.containerView.addConstraint(centerY)

// But we won't specify a horizontal position constraint.
// Where does the view wind up?

//let isLabelAmbiguous = label.hasAmbiguousLayout
//let isContainerAmbiguous = liveView.containerView.hasAmbiguousLayout


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

