//
//  EHSelectionViewController.swift
//  LearnAboutStackViews
//
//  Created by Eric Hyche on 7/31/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

protocol EHMultipleChoiceDataSource {
    func title() -> String
    func choiceCount() -> Int
    func choiceText(atIndex: Int) -> String
    func isChoiceSelected(atIndex: Int) -> Bool
    func canSelectMultipleChoices() -> Bool
    func canSelectChoice(atIndex: Int) -> Bool
    mutating func setChoice(selected: Bool, atIndex: Int)
}

typealias EHMultipleChoiceActionBlock = (EHMultipleChoiceDataSource) -> Void

class EHMultipleChoiceViewController: UIViewController {

    // MARK: - External properties

    var updateBlock: EHMultipleChoiceActionBlock?

    // MARK: - Internal properties

    var dataSource: EHMultipleChoiceDataSource
    let scrollView = UIScrollView(frame: .zero)
    let stackView = UIStackView(frame: .zero)
    let textColorEnabled = UIColor.black
    let textColorDisabled = UIColor.lightGray
    let imageEnabledSelected = UIImage(named: "checkmark-selected")
    let imageEnabledNotSelected = UIImage(named: "checkmark-not-selected")
    let imageDisabledSelected = UIImage(named: "checkmark-disabled")
    let imageDisabledNotSelected = UIImage(named: "checkmark-disabled")

    // MARK: - Initializers

    init(withDataSource dataSource: EHMultipleChoiceDataSource) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = dataSource.title()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 1.0

        scrollView.addSubview(stackView)

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        createArrangedViews()

        updateViewState()
    }

    func createArrangedViews() {
        // Clear out any arrangedSubviews
        let arrangedSubviews = stackView.arrangedSubviews
        for view in arrangedSubviews {
            view.removeFromSuperview()
        }

        for i in 0..<dataSource.choiceCount() {
            let rowStackView = UIStackView(frame: .zero)
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fill
            rowStackView.alignment = .center
            rowStackView.isLayoutMarginsRelativeArrangement = true
            rowStackView.layoutMargins = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
            let rowLabel = UILabel(frame: .zero)
            rowLabel.font = UIFont(name: "OpenSans-Semibold", size: 14.0)
            rowLabel.textColor = textColorEnabled
            rowLabel.text = dataSource.choiceText(atIndex: i)
            rowStackView.addArrangedSubview(rowLabel)
            let rowImage = UIImageView(image: UIImage(named: "checkmark-not-selected"))
            rowStackView.addArrangedSubview(rowImage)
            rowStackView.tag = i
            rowStackView.isUserInteractionEnabled = true
            rowStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rowTapped(recognizer:))))
            stackView.addArrangedSubview(rowStackView)
        }
    }

    func updateViewState() {
        let minCount = min(dataSource.choiceCount(), stackView.arrangedSubviews.count)
        for i in 0..<minCount {
            if let rowStackView = stackView.arrangedSubviews[i] as? UIStackView,
               rowStackView.arrangedSubviews.count == 2,
               let rowLabel = rowStackView.arrangedSubviews[0] as? UILabel,
               let rowImageView = rowStackView.arrangedSubviews[1] as? UIImageView {
                rowLabel.textColor = (dataSource.canSelectChoice(atIndex: i) ? textColorEnabled : textColorDisabled)
                if dataSource.canSelectChoice(atIndex: i) {
                    rowImageView.image = (dataSource.isChoiceSelected(atIndex: i) ? imageEnabledSelected : imageEnabledNotSelected)
                } else {
                    rowImageView.image = (dataSource.isChoiceSelected(atIndex: i) ? imageDisabledSelected : imageDisabledNotSelected)
                }
            }
        }
    }

    @objc func rowTapped(recognizer: UIGestureRecognizer) {
        if let rowTappedIndex = recognizer.view?.tag, rowTappedIndex < dataSource.choiceCount() {
            // Get the current state of selection of the row
            let isRowSelected = dataSource.isChoiceSelected(atIndex: rowTappedIndex)
            // Can we make multiple selections?
            if dataSource.canSelectMultipleChoices() {
                // We can make multiple selections, so we will toggle the selected state of this row
                dataSource.setChoice(selected: !isRowSelected, atIndex: rowTappedIndex)
                // Now update the entire view state
                updateViewState()
                // Call the datasource updated block
                updateBlock?(dataSource)
            } else {
                // This is a single-select data source, so we only take action
                // if the row is not selected.
                if !isRowSelected {
                    dataSource.setChoice(selected: true, atIndex: rowTappedIndex)
                    // Now update the entire view state
                    updateViewState()
                    // Call the datasource updated block
                    updateBlock?(dataSource)
                }
            }
        }
    }

}
