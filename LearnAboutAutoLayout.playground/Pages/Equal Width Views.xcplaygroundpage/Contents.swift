import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let yellow = UIView(frame: .zero)
yellow.translatesAutoresizingMaskIntoConstraints = false
yellow.backgroundColor = UIColor.yellow

liveView.containerView.addSubview(yellow)

let green = UIView(frame: .zero)
green.translatesAutoresizingMaskIntoConstraints = false
green.backgroundColor = UIColor.green

liveView.containerView.addSubview(green)

yellow.leadingAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.leadingAnchor).isActive = true
green.leadingAnchor.constraint(equalTo: yellow.trailingAnchor, constant: 8.0).isActive = true
green.trailingAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.trailingAnchor).isActive = true
// Attach the top of the yellow and green
yellow.topAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.topAnchor).isActive = true
green.topAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.topAnchor).isActive = true
// Attach the bottom of yellow and green
yellow.bottomAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.bottomAnchor).isActive = true
green.bottomAnchor.constraint(equalTo: liveView.containerView.layoutMarginsGuide.bottomAnchor).isActive = true
// Now set the width of yellow and green to be the same
yellow.widthAnchor.constraint(equalTo: green.widthAnchor).isActive = true

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView
