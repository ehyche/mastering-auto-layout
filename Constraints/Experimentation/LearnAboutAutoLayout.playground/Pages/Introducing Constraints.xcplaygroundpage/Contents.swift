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

// This is most manual way of writing constraints, and the
// way that looks the most like an equation.
//
// label.centerY = liveView.containerView.centerY * 1.0 + 0.0
let centerY = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
// label.leading = liveView.containerView.leading * 1.0 + 20.0
let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .leading, multiplier: 1.0, constant: 20.0)

// Then you need to add the constraints to the appropriate view.
// You add it to the most immediate common ancestor of both views involved in the constraint.
liveView.containerView.addConstraint(centerY)
liveView.containerView.addConstraint(leading)

// What happens if we add the constraint to a view too low in the tree?
// What error do we get?
//label.addConstraint(leading)

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

