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
let longButton = createButton(withTitle: "Much Longer Button Title")

shortButton.translatesAutoresizingMaskIntoConstraints = false
container.addSubview(shortButton)

longButton.translatesAutoresizingMaskIntoConstraints = false
container.addSubview(longButton)

// |-[short]-(8)-[long]-|
shortButton.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor).isActive = true
longButton.leadingAnchor.constraint(equalTo: shortButton.trailingAnchor, constant: 8.0).isActive = true
longButton.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor).isActive = true

container.layoutMarginsGuide.bottomAnchor.constraint(equalTo: shortButton.bottomAnchor, constant: 20.0).isActive = true
container.layoutMarginsGuide.bottomAnchor.constraint(equalTo: longButton.bottomAnchor, constant: 20.0).isActive = true

shortButton.widthAnchor.constraint(equalTo: longButton.widthAnchor).isActive = true


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView
