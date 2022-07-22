//
//  AddEditEmojiViewModel.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import Foundation

class AddEditEmojiViewModel {
    var emojiToEdit: Emoji?

    @Published var emojiSymbol: String?
    @Published var emojiName: String?
    @Published var emojiUsage: String?
    @Published var emojiDetails: String?

    init(emojiToEdit: Emoji?) {
        if let emojiToEdit = emojiToEdit {
            self.emojiToEdit = emojiToEdit
            self.emojiSymbol = emojiToEdit.symbol
            self.emojiName = emojiToEdit.name
            self.emojiUsage = emojiToEdit.usage
            self.emojiDetails = emojiToEdit.details
        }
    }

    func saveEmoji() {
        var emoji: Emoji!

        if let emojiToEdit = emojiToEdit {
            emoji = emojiToEdit
        } else {
            emoji = Emoji(context: Constants.managedObjectContext)
        }

        emoji.symbol = emojiSymbol
        emoji.name = emojiName
        emoji.usage = emojiUsage
        emoji.details = emojiDetails

        Constants.appDelegate.saveContext()
    }

    func deleteEmoji() {
        guard let emojiToEdit = emojiToEdit else {
            return
        }

        Constants.managedObjectContext.delete(emojiToEdit)
        Constants.appDelegate.saveContext()
    }
}
