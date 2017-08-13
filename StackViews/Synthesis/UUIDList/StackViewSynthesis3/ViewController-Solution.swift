//
//  ViewController.swift
//  StackViewSynthesis3
//
//  Created by Eric Hyche on 8/6/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10.0).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10.0).isActive = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        // Configure the stack view here
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4.0

        // Add an "Add Item" row to the stack view
        let addItemButton = UIButton(frame: .zero)
        addItemButton.setTitle("Add Item", for: .normal)
        addItemButton.setTitleColor(UIColor.blue, for: .normal)
        addItemButton.addTarget(self, action: #selector(addItemButtonTapped(sender:)), for: .touchUpInside)

        stackView.addArrangedSubview(addItemButton)
    }

    @objc private func addItemButtonTapped(sender: UIButton) {
        let insertionIndex = stackView.arrangedSubviews.count - 1
        let viewToInsert = rowView()
        viewToInsert.isHidden = true
        stackView.insertArrangedSubview(viewToInsert, at: insertionIndex)

        UIView.animate(withDuration: 0.3, animations: {
            viewToInsert.isHidden = false
        })
    }

    @objc private func deleteItemButtonTapped(sender: UIButton) {
        if let viewToRemove = sender.superview,
           stackView.arrangedSubviews.contains(viewToRemove) {
            UIView.animate(withDuration: 0.3,
                           animations: {
                viewToRemove.isHidden = true
            },
                           completion: { (finished) in
                viewToRemove.removeFromSuperview()
            })
        }
    }

    private func rowView() -> UIView {
        let rowStackView = UIStackView(frame: .zero)

        rowStackView.axis = .horizontal
        rowStackView.distribution = .fill
        rowStackView.alignment = .firstBaseline
        rowStackView.spacing = 8.0

        let dateLabel = UILabel(frame: .zero)
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: traitCollection)
        dateLabel.textColor = UIColor.black

        let uuidLabel = UILabel(frame: .zero)
        uuidLabel.text = UUID().uuidString
        uuidLabel.textColor = UIColor.black
        uuidLabel.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: traitCollection)

        let deleteButton = UIButton(frame: .zero)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.blue, for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteItemButtonTapped(sender:)), for: .touchUpInside)

        rowStackView.addArrangedSubview(dateLabel)
        rowStackView.addArrangedSubview(uuidLabel)
        rowStackView.addArrangedSubview(deleteButton)

        return rowStackView
    }


}

