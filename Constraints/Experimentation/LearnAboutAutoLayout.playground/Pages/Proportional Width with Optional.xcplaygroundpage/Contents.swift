import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let blue = UIView(frame: .zero)
blue.translatesAutoresizingMaskIntoConstraints = false
blue.backgroundColor = UIColor.blue

liveView.containerView.addSubview(blue)

let red = UIView(frame: .zero)
red.translatesAutoresizingMaskIntoConstraints = false
red.backgroundColor = UIColor.red

liveView.containerView.addSubview(red)

blue.leadingAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.leadingAnchor).isActive = true
red.leadingAnchor.constraint(equalTo: blue.trailingAnchor, constant: 8.0).isActive = true
red.trailingAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.trailingAnchor).isActive = true
// Attach the top of the yellow and green
blue.topAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.topAnchor).isActive = true
red.topAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.topAnchor).isActive = true
// Attach the bottom of yellow and green
blue.bottomAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.bottomAnchor).isActive = true
red.bottomAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.bottomAnchor).isActive = true
// Now set red's width to be 2x of blue's width (@750)
let widthConstraint = red.widthAnchor.constraint(equalTo: blue.widthAnchor, multiplier: 2.0)
widthConstraint.priority = UILayoutPriorityDefaultHigh
widthConstraint.isActive = true

blue.widthAnchor.constraint(greaterThanOrEqualToConstant: 50.0).isActive = true

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView
