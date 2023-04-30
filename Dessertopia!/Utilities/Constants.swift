//
//  Constants.swift
//  Dessertopia!
//
//  Created by Samir Pandey on 4/25/23.
//

import Foundation

enum DessertCellReuseId {
    static let cellId = "dessertCell"
}

enum DessertVCConstant {
    static let title = "What's for Dessert?"
    static let fatalErrorAtCell = "Failed to dequeue DessertTableViewCell"
    static let rowHeight = 100
}

enum ErrorAlertConstant {
    static let alertMessage = "No internet connection. Try Again!"
    static let retryButton = "Retry"
    static let cancelButton = "Cancel"
}

enum TableCellConstant {
    static let fatalError = "init(coder:) has not been implemented"
    static let placeHolderImage = "placeholder"
}

enum ThumbnailConstants {
    static let youtubeURL = "https://www.youtube.com/"
    static let playImage = "play.circle.fill"
}

enum IngredientConstant {
    static let title = "Ingredients & Measurements"
    static let defaultString = "Name not Available"
}

enum InstructionConstant {
    static let title = "Instructions"
    static let defaultString = "Don't have any instruction at this time."
    static let buttonUp = "chevron.up.circle.fill"
    static let buttonDown = "chevron.down.circle.fill"
}

enum EmptyConstant {
    static let empty = ""
}
