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

// Assign the vertical center of the label to the vertical center of the container
let centerY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
// Position the label 20 points to the left of the left edge of the container
let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .leading, multiplier: 1.0, constant: 20.0)
// Now also add a conflicting constraint putting the
// center of the label 40 points below the top.
let top = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                             toItem: liveView.containerView, attribute: .top, multiplier: 1.0, constant: 40.0)

// Then you need to add the constraints to the appropriate view.
// You add it to the most immediate common ancestor of both views involved in the constraint.
liveView.containerView.addConstraint(centerY)
liveView.containerView.addConstraint(leading)
liveView.containerView.addConstraint(top)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

