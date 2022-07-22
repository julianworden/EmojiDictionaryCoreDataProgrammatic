//
//  ViewController.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import Combine
import UIKit

class MainViewController: UIViewController {
    let viewModel = MainViewModel()
    var subscribers = Set<AnyCancellable>()

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        viewModel.generateExampleData()
        viewModel.fetchEmoji()
        configureViews()
        layoutViews()
        configureSubscribers()
    }

    func configureViews() {
        view.backgroundColor = .white
        title = "Emoji Dictionary"
        let addEmojiButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEmojiTapped))
        navigationItem.backButtonTitle = ""
        navigationItem.rightBarButtonItem = addEmojiButton
        navigationItem.leftBarButtonItem = editButtonItem


        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
    }

    @objc func addEmojiTapped() {
        let addEditEmojiViewController = AddEditEmojiViewController()
        addEditEmojiViewController.viewModel = AddEditEmojiViewModel(emojiToEdit: nil)
        addEditEmojiViewController.title = "Add Emoji"
        navigationController?.pushViewController(addEditEmojiViewController, animated: true)
    }
}

// MARK: - Constraints

extension MainViewController {
    func layoutViews() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Combine

extension MainViewController {
    func configureSubscribers() {
        subscribers = [
            viewModel.$controllerChangeIndexPath
                .sink(receiveValue: { indexPath in
                    if let indexPath = indexPath {
                        switch self.viewModel.controllerChangeType {
                        case .insert:
                            self.tableView.insertRows(at: [indexPath], with: .none)
                        case .update:
                            let cell = self.tableView.cellForRow(at: indexPath)
                            self.configure(cell!, indexPath: indexPath)
                        case .delete:
                            self.tableView.deleteRows(at: [indexPath], with: .top)
                        case .move:
                            self.tableView.insertRows(at: [indexPath], with: .none)
                        default:
                            break
                        }

                        self.tableView.reloadData()
                    }
                })
        ]
    }
}
