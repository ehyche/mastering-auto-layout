//
//  MasterViewController.swift
//  AutoLayoutAndScrollViews
//
//  Created by Eric Hyche on 8/11/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    enum RowContent: Int {
        case multipleContentViews
        case contentIsStackView
        case tableViewController
//        case floatingContent
        case numberOfRows
    }

    let cellID = "CellID"


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        navigationItem.title = "UIScrollViews and AutoLayout"

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowContent.numberOfRows.rawValue
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        var title = ""
        if let rowContent = RowContent(rawValue: indexPath.row) {
            switch rowContent {
                case .multipleContentViews: title = "Multiple Content Views"
                case .contentIsStackView:   title = "StackView Content View"
                case .tableViewController:  title = "Automatic UITableViewCell Sizing"
//                case .floatingContent:      title = "Floating Content"
                default: break
            }
        }
        cell.textLabel?.text = title

        return cell
    }

    // MARK: - UITableViewDelegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let rowContent = RowContent(rawValue: indexPath.row) {
            switch rowContent {
                case .multipleContentViews:
                    let controller = EHMultipleContentViewController(nibName: nil, bundle: nil)
                    navigationController?.pushViewController(controller, animated: true)
                case .contentIsStackView:
                    let controller = EHStackViewContentViewController(nibName: nil, bundle: nil)
                    navigationController?.pushViewController(controller, animated: true)
                case .tableViewController:
                    let controller = EHTableViewController(nibName: nil, bundle: nil)
                    navigationController?.pushViewController(controller, animated: true)
                    break
//                case .floatingContent:
//                    let controller = EHFloatingContentViewController(nibName: nil, bundle: nil)
//                    navigationController?.pushViewController(controller, animated: true)
                default:
                    break
            }
        }

    }

}

