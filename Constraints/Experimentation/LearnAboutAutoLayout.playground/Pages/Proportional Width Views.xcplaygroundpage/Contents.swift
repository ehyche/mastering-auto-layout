import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let purple = UIView(frame: .zero)
purple.translatesAutoresizingMaskIntoConstraints = false
purple.backgroundColor = UIColor.purple

liveView.containerView.addSubview(purple)

let orange = UIView(frame: .zero)
orange.translatesAutoresizingMaskIntoConstraints = false
orange.backgroundColor = UIColor.orange

liveView.containerView.addSubview(orange)

purple.leadingAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.leadingAnchor).isActive = true
orange.leadingAnchor.constraint(equalTo: purple.trailingAnchor, constant: 8.0).isActive = true
orange.trailingAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.trailingAnchor).isActive = true
// Attach the top of the yellow and green
purple.topAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.topAnchor).isActive = true
orange.topAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.topAnchor).isActive = true
// Attach the bottom of yellow and green
purple.bottomAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.bottomAnchor).isActive = true
orange.bottomAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.bottomAnchor).isActive = true
// Now set orange's width to be 2x of purple's width
orange.widthAnchor.constraint(equalTo: purple.widthAnchor, multiplier: 2.0).isActive = true

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView
