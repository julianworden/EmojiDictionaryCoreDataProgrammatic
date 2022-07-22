//
//  MainViewModel+NSFetchedResultsControllerDelegate.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import CoreData
import Foundation

extension MainViewModel: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                self.controllerChangeType = .insert
                self.controllerChangeIndexPath = indexPath
            }
        case .delete:
            if let indexPath = indexPath {
                self.controllerChangeType = .delete
                self.controllerChangeIndexPath = indexPath
            }
        case .move:
            if let indexPath = newIndexPath {
                self.controllerChangeType = .move
                self.controllerChangeIndexPath = indexPath
            }
        case .update:
            if let indexPath = indexPath {
                self.controllerChangeType = .update
                self.controllerChangeIndexPath = indexPath
            }
        @unknown default:
            break
        }
    }
}
