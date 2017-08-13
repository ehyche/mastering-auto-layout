import UIKit
import PlaygroundSupport

// This is our sample container view which allows us
// to adjust the width and height of the container
let liveView = EHAdjustableContainerView(frame: CGRect(x: 0.0, y: 0.0, width: 512.0, height: 512.0))
let container = liveView.containerView

let labelFontSizeSmall: CGFloat = 16.0
let labelFontSizeLarge: CGFloat = 32.0

func label(withText text: String) -> UILabel {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor.black
    label.font = UIFont.boldSystemFont(ofSize: labelFontSizeSmall)
//    label.font = UIFont.boldSystemFont(ofSize: labelFontSizeLarge)
    label.text = text
    return label
}

func textField(withPlaceholder placeholder: String) -> UITextField {
    let textField = UITextField(frame: .zero)
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.placeholder = placeholder

    return textField
}

let firstLabel = label(withText: "First Name")
let firstTextField = textField(withPlaceholder: "Enter first name")
let middleLabel = label(withText: "Middle Name")
let middleTextField = textField(withPlaceholder: "Enter middle name")
let lastLabel = label(withText: "Last Name")
let lastTextField = textField(withPlaceholder: "Enter last name")

container.addSubview(firstLabel)
container.addSubview(firstTextField)
container.addSubview(middleLabel)
container.addSubview(middleTextField)
container.addSubview(lastLabel)
container.addSubview(lastTextField)

// |-[firstLabel]-(8)-[firstTextField]-|
firstLabel.leadingAnchor.constraint(equalTo: container.layoutMarginsGuide.leadingAnchor).isActive = true
firstTextField.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor, constant: 8.0).isActive = true
firstTextField.trailingAnchor.constraint(equalTo: container.layoutMarginsGuide.trailingAnchor).isActive = true

// Middle label and text field
middleLabel.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor).isActive = true
middleTextField.leadingAnchor.constraint(equalTo: middleLabel.trailingAnchor, constant: 8.0).isActive = true
middleTextField.trailingAnchor.constraint(equalTo: firstTextField.trailingAnchor).isActive = true


lastLabel.leadingAnchor.constraint(equalTo: firstLabel.leadingAnchor).isActive = true
lastTextField.leadingAnchor.constraint(equalTo: lastLabel.trailingAnchor, constant: 8.0).isActive = true
lastTextField.trailingAnchor.constraint(equalTo: firstTextField.trailingAnchor).isActive = true

// Align baselines
firstLabel.firstBaselineAnchor.constraint(equalTo: firstTextField.firstBaselineAnchor).isActive = true
middleLabel.firstBaselineAnchor.constraint(equalTo: middleTextField.firstBaselineAnchor).isActive = true
lastLabel.firstBaselineAnchor.constraint(equalTo: lastTextField.firstBaselineAnchor).isActive = true

// Make all text field widths the same
firstTextField.widthAnchor.constraint(equalTo: middleTextField.widthAnchor).isActive = true
firstTextField.widthAnchor.constraint(equalTo: lastTextField.widthAnchor).isActive = true

// Pin first label to top margin
firstLabel.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor).isActive = true


// These constraints put space between the rows. But we 
// are assuming that the text fields are taller than the 
// labels. What happens if they are not?
middleTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 20.0).isActive = true
lastTextField.topAnchor.constraint(equalTo: middleTextField.bottomAnchor, constant: 20.0).isActive = true

// We set the content hugging priority so that 
// the labels have a higher content hugging priority
// than do the text fields. What happens if we reverse these?
let labelPriority = UILayoutPriorityDefaultLow + 1
let textFieldPriority = UILayoutPriorityDefaultLow
firstLabel.setContentHuggingPriority(labelPriority, for: .horizontal)
middleLabel.setContentHuggingPriority(labelPriority, for: .horizontal)
lastLabel.setContentHuggingPriority(labelPriority, for: .horizontal)
firstTextField.setContentHuggingPriority(textFieldPriority, for: .horizontal)
middleTextField.setContentHuggingPriority(textFieldPriority, for: .horizontal)
lastTextField.setContentHuggingPriority(textFieldPriority, for: .horizontal)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = liveView
