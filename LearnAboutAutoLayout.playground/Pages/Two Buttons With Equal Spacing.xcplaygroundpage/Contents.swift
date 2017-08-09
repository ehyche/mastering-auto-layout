import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))
let container = liveView.containerView

func createButton(withTitle title: String) -> UIButton {
    let button = UIButton(frame: .zero)
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = UIColor.darkGray
    return button
}

let shortButton = createButton(withTitle: "Short")
let longButton = createButton(withTitle: "Longer Button Title")
let leadingGuide = UILayoutGuide()
let centerGuide = UILayoutGuide()
let trailingGuide = UILayoutGuide()

shortButton.translatesAutoresizingMaskIntoConstraints = false
container.addSubview(shortButton)

longButton.translatesAutoresizingMaskIntoConstraints = false
container.addSubview(longButton)

container.addLayoutGuide(leadingGuide)
container.addLayoutGuide(centerGuide)
container.addLayoutGuide(trailingGuide)

// |-[leadingGuide][short][centerGuide][long][trailingGuide]-|
leadingGuide.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor).isActive = true
shortButton.leadingAnchor.constraint(equalTo: leadingGuide.trailingAnchor).isActive = true
centerGuide.leadingAnchor.constraint(equalTo: shortButton.trailingAnchor).isActive = true
longButton.leadingAnchor.constraint(equalTo: centerGuide.trailingAnchor).isActive = true
trailingGuide.leadingAnchor.constraint(equalTo: longButton.trailingAnchor).isActive = true
trailingGuide.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor).isActive = true

// Position the bottom of the leading layout guide
// a fixed distance from the bottom
container.layoutMarginsGuide.bottomAnchor.constraint(equalTo: leadingGuide.bottomAnchor, constant: 20.0).isActive = true

// Now align the bottoms of all of the views
shortButton.bottomAnchor.constraint(equalTo: leadingGuide.bottomAnchor).isActive = true
centerGuide.bottomAnchor.constraint(equalTo: leadingGuide.bottomAnchor).isActive = true
longButton.bottomAnchor.constraint(equalTo: leadingGuide.bottomAnchor).isActive = true
trailingGuide.bottomAnchor.constraint(equalTo: leadingGuide.bottomAnchor).isActive = true

// Make the buttons don't overlap and don't
// overlap the leading and trailing margins
shortButton.leadingAnchor.constraint(greaterThanOrEqualTo: container.layoutMarginsGuide.leadingAnchor).isActive = true
longButton.leadingAnchor.constraint(greaterThanOrEqualTo: shortButton.trailingAnchor, constant: 8.0).isActive = true
container.layoutMarginsGuide.trailingAnchor.constraint(greaterThanOrEqualTo: longButton.trailingAnchor).isActive = true

// Make the layout guide widths the same
centerGuide.widthAnchor.constraint(equalTo: leadingGuide.widthAnchor).isActive = true
trailingGuide.widthAnchor.constraint(equalTo: leadingGuide.widthAnchor).isActive = true

// Make the button widths the same
longButton.widthAnchor.constraint(equalTo: shortButton.widthAnchor, multiplier: 1.0).isActive = true

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView
