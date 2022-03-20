//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 20/03/2022.
//

import Foundation

public struct FeedErrorViewModel {
    public let message: String?

    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: .none)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
