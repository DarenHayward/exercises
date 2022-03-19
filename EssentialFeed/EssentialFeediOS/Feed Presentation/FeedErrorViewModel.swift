//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by Daren Hayward on 19/03/2022.
//

struct FeedErrorViewModel {
    let message: String?

    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: .none)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
