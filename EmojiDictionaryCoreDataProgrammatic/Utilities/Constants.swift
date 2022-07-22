//
//  Constants.swift
//  EmojiDictionaryCoreDataProgrammatic
//
//  Created by Julian Worden on 7/21/22.
//

import Foundation
import UIKit

struct Constants {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let managedObjectContext = appDelegate.persistentContainer.viewContext
    
    static let cellReuseIdentifier = "EmojiCell"
}
