import UIKit
import PlaygroundSupport

let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))

let label0 = UILabel(frame: .zero)
label0.translatesAutoresizingMaskIntoConstraints = false
label0.backgroundColor = .green
label0.text = "111"
label0.textColor = .white
label0.font = UIFont.systemFont(ofSize: 18.0)

liveView.containerView.addSubview(label0)

let label1 = UILabel(frame: .zero)
label1.translatesAutoresizingMaskIntoConstraints = false
label1.backgroundColor = .red
label1.text = "22222"
label1.textColor = .white
label1.font = UIFont.systemFont(ofSize: 24.0)

liveView.containerView.addSubview(label1)

label0.centerYAnchor.constraint(equalTo: liveView.containerView.centerYAnchor).isActive = true
label1.centerYAnchor.constraint(equalTo: liveView.containerView.centerYAnchor).isActive = true

let horzConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[label0]-(20)-[label1]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label0": label0, "label1": label1])
NSLayoutConstraint.activate(horzConstraints)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView

