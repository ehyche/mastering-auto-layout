import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let image = UIImageView(image: UIImage(named: "steve-large.jpg"))
image.translatesAutoresizingMaskIntoConstraints = false

liveView.containerView.addSubview(image)

// Center the image vertically
let centerY = NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
centerY.priority = UILayoutPriorityRequired
// Center the image horizontally
let centerX = NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal,
                                 toItem: liveView.containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
centerX.priority = UILayoutPriorityRequired

// Make the height of the image equal to the width
let aspect1 = NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal,
                                 toItem: image, attribute: .width, multiplier: 1.0, constant: 0.0)
aspect1.priority = UILayoutPriorityRequired

// Make the image width half of the container width
let imageHalf = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal,
                                   toItem: liveView.containerView, attribute: .width, multiplier: 0.5, constant: 0.0)
imageHalf.priority = UILayoutPriorityRequired

// Put a minimum width of 40
let minWidth = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .greaterThanOrEqual,
                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
minWidth.priority = UILayoutPriorityRequired

// Put a maximum width of 80
let maxWidth = NSLayoutConstraint(item: image, attribute: .width, relatedBy: .lessThanOrEqual,
                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200.0)
maxWidth.priority = UILayoutPriorityRequired

// Then you need to add the constraints to the appropriate view.
// You add it to the most immediate common ancestor of both views involved in the constraint.
liveView.containerView.addConstraint(centerY)
liveView.containerView.addConstraint(centerX)
liveView.containerView.addConstraint(imageHalf)
image.addConstraint(aspect1)
image.addConstraint(minWidth)
image.addConstraint(maxWidth)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

