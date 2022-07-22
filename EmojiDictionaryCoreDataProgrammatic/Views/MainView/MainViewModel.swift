//
//  MainViewModel.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import CoreData
import Foundation

class MainViewModel: NSObject {
    var fetchedResultsController: NSFetchedResultsController<Emoji>!
    var controllerChangeType: NSFetchedResultsChangeType?

    @Published var controllerChangeIndexPath: IndexPath?
    
    func generateExampleData() {
        let emoji1 = Emoji(context: Constants.managedObjectContext)
        emoji1.name = "Grinning Face"
        emoji1.details = "A typical smiley face."
        emoji1.symbol = "😀"
        emoji1.usage = "happiness"

        let emoji2 = Emoji(context: Constants.managedObjectContext)
        emoji2.name = "Confused Face"
        emoji2.details = "A confused, puzzled face."
        emoji2.symbol = "😕"
        emoji2.usage = "unsure what to think; displeasure"

        let emoji3 = Emoji(context: Constants.managedObjectContext)
        emoji3.name = "Heart Eyes"
        emoji3.details = "A smiley face with hearts for eyes."
        emoji3.symbol = "😍"
        emoji3.usage = "love of something; attractive"

        Constants.appDelegate.saveContext()
    }

    func fetchEmoji() {
        let fetchRequest = Emoji.fetchRequest()
        fetchRequest.sortDescriptors = []

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: Constants.managedObjectContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)

        self.fetchedResultsController = controller
        controller.delegate = self

        do {
            try controller.performFetch()
        } catch {
            print(error)
        }
    }

    func deleteEmoji(_ emoji: Emoji) {
        Constants.managedObjectContext.delete(emoji)
        Constants.appDelegate.saveContext()
    }
}
