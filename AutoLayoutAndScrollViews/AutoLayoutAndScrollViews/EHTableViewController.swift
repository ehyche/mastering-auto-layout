//
//  EHTableViewController.swift
//  AutoLayoutAndScrollViews
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class EHTableViewCell: UITableViewCell {

    private let stackView = UIStackView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let subtitleLabel = UILabel(frame: .zero)

    class var estimatedRowHeight: CGFloat {
        return UIFont.boldSystemFont(ofSize: 18.0).lineHeight + 10.0
    }

    static let cellID = "EHTableViewCellID"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white

        // Configure the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        //stackView.spacing = 4.0

        // Add the stack view to the UITableViewCell's contentView
        contentView.addSubview(stackView)

        // Pin the stack view to the contentView's margins
        stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5.0).isActive = true

        // Configure the title label and add to the stack view
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        stackView.addArrangedSubview(titleLabel)

        // Configure the subtitle label and add to the stack view
        // This view is initially hidden.
        subtitleLabel.textColor = UIColor.darkGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.isHidden = true
        subtitleLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vulputate varius sapien non vulputate. Mauris euismod ante diam, id facilisis enim sagittis at. Nulla facilisi."
        stackView.addArrangedSubview(subtitleLabel)

        // We always want to the info button in the accessory view
        accessoryType = .detailButton
    }

}

class EHTableViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)
    static fileprivate let rowCount = 30
    fileprivate var expanded: [Bool] = Array<Bool>(repeating: false, count: EHTableViewController.rowCount)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Automatic UITableViewCell Sizing"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        tableView.estimatedRowHeight = EHTableViewCell.estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.register(EHTableViewCell.self, forCellReuseIdentifier: EHTableViewCell.cellID)
    }

}

extension EHTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EHTableViewController.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EHTableViewCell.cellID, for: indexPath)

        if let ehCell = cell as? EHTableViewCell {
            let expandedText = (expanded[indexPath.row] ? "Expanded" : "Collapsed")
            ehCell.titleLabel.text = "Row \(indexPath.row) \(expandedText)"
            ehCell.subtitleLabel.isHidden = !expanded[indexPath.row]
        }

        return cell
    }
    
}

extension EHTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        expanded[indexPath.row] = !expanded[indexPath.row]

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
