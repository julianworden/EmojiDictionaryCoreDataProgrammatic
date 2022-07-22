//
//  MainViewController+UITableViewDataSource.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = viewModel.fetchedResultsController.sections {
            return sections.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = viewModel.fetchedResultsController.sections {
           let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: Constants.cellReuseIdentifier)
        tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath)
        configure(cell, indexPath: indexPath)
        return cell
    }

    func configure(_ cell: UITableViewCell, indexPath: IndexPath) {
        var contentConfiguration = cell.defaultContentConfiguration()
        let emoji = viewModel.fetchedResultsController.object(at: indexPath)
        
        contentConfiguration.text = emoji.symbol
        contentConfiguration.secondaryText = emoji.name
        cell.contentConfiguration = contentConfiguration
        cell.accessoryType = .disclosureIndicator
    }
}
