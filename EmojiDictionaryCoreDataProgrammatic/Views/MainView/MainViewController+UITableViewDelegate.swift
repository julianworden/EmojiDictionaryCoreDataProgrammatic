//
//  MainViewController+UITableViewDelegate.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let addEditEmojiViewController = AddEditEmojiViewController()
        addEditEmojiViewController.viewModel = AddEditEmojiViewModel(emojiToEdit: viewModel.fetchedResultsController.object(at: indexPath))
        addEditEmojiViewController.title = "Edit Emoji"
        navigationController?.pushViewController(addEditEmojiViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        tableView.deleteRows(at: [indexPath], with: .automatic)
        viewModel.deleteEmoji(viewModel.fetchedResultsController.object(at: indexPath))
        tableView.reloadData()
//        tableView.beginUpdates()
//        tableView.endUpdates()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        let status = navigationItem.leftBarButtonItem?.title

        if status == "Edit" {
            tableView.setEditing(true, animated: true)
            navigationItem.leftBarButtonItem?.title = "Done"
        } else if status == "Done" {
            tableView.setEditing(false, animated: true)
            navigationItem.leftBarButtonItem?.title = "Edit"
        }
    }
}
