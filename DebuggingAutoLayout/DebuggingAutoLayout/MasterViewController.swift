//
//  MasterViewController.swift
//  DebuggingAutoLayout
//
//  Created by Eric Hyche on 8/8/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    enum RowContent: Int {
        case unsatisfiableLayouts
        case ambiguousLayouts
    }

    let cellID = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Debugging Auto Layout"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        if let rowContent = RowContent(rawValue: indexPath.row) {
            var title = ""
            switch rowContent {
                case .unsatisfiableLayouts: title = "Unsatisfiable Layouts"
                case .ambiguousLayouts:     title = "Ambiguous Layouts"
            }
            cell.textLabel?.text = title
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    // MARK: - UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let rowContent = RowContent(rawValue: indexPath.row) {
            var viewController: UIViewController? = nil
            switch rowContent {
                case .unsatisfiableLayouts:
                    viewController = EHUnsatisfiableViewController(nibName: nil, bundle: nil)
                    break
                case .ambiguousLayouts:
                    break
            }
            if let viewController = viewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        }

    }

}

