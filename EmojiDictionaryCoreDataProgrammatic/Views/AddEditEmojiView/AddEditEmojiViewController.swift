//
//  AddEditEmojiViewController.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import Combine
import UIKit

class AddEditEmojiViewController: UIViewController {
    var viewModel: AddEditEmojiViewModel!
    var subscribers = Set<AnyCancellable>()

    let scrollView = UIScrollView()
    lazy var contentStackView = UIStackView(arrangedSubviews: [symbolStackView, nameStackView, usageStackView, detailsStackView])
    lazy var symbolStackView = UIStackView(arrangedSubviews: [symbolLabel, symbolTextField])
    let symbolLabel = UILabel()
    let symbolTextField = UITextField()
    lazy var nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    lazy var usageStackView = UIStackView(arrangedSubviews: [usageLabel, usageTextField])
    let usageLabel = UILabel()
    let usageTextField = UITextField()
    lazy var detailsStackView = UIStackView(arrangedSubviews: [detailsLabel, detailsTextField])
    let detailsLabel = UILabel()
    let detailsTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerForKeyboardNotifications()
        configureViews()
        layoutViews()
        configureSubscribers()
    }

    func configureViews() {
        view.backgroundColor = .white
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
        deleteButton.tintColor = .red
        navigationItem.rightBarButtonItems = [deleteButton, saveButton]

        scrollView.keyboardDismissMode = .interactive

        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.spacing = 20
        contentStackView.distribution = .fillEqually

        symbolStackView.axis = .vertical
        symbolStackView.alignment = .leading
        symbolStackView.spacing = 8

        symbolLabel.text = "Symbol"

        symbolTextField.borderStyle = .roundedRect

        nameStackView.axis = .vertical
        nameStackView.alignment = .leading
        nameStackView.spacing = 8

        nameLabel.text = "Name"

        nameTextField.borderStyle = .roundedRect

        usageStackView.axis = .vertical
        usageStackView.alignment = .leading
        usageStackView.spacing = 8

        usageLabel.text = "Usage"

        usageTextField.borderStyle = .roundedRect

        detailsStackView.axis = .vertical
        detailsStackView.alignment = .leading
        detailsStackView.spacing = 8

        detailsLabel.text = "Details"

        detailsTextField.borderStyle = .roundedRect
    }

    @objc func saveButtonTapped() {
        viewModel.emojiSymbol = symbolTextField.text
        viewModel.emojiName = nameTextField.text
        viewModel.emojiUsage = usageTextField.text
        viewModel.emojiDetails = detailsTextField.text
        viewModel.saveEmoji()
        navigationController?.popViewController(animated: true)
    }

    @objc func deleteButtonTapped() {
        viewModel.deleteEmoji()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Contraints

extension AddEditEmojiViewController {
    func layoutViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),

            symbolTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            usageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            detailsTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}

// MARK: - Combine

extension AddEditEmojiViewController {
    func configureSubscribers() {
        subscribers = [
            viewModel.$emojiSymbol
                .assign(to: \.text, on: symbolTextField),
            viewModel.$emojiName
                .assign(to: \.text, on: nameTextField),
            viewModel.$emojiUsage
                .assign(to: \.text, on: usageTextField),
            viewModel.$emojiDetails
                .assign(to: \.text, on: detailsTextField)
        ]
    }
}

// MARK: - Keyboard Notifications

extension AddEditEmojiViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keyboardWillBeShown(_ notification: NSNotification) {
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        scrollView.showsVerticalScrollIndicator = true

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size

        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }

    @objc func keyboardDidHide(_ notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.showsVerticalScrollIndicator = false
    }
}
