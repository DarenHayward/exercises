//
//  UniqueFeed.swift
//  EssentialAppTests
//
//  Created by Daren Hayward on 05/04/2022.
//

import EssentialFeed

func uniqueFeed() -> [FeedImage] {
    return [FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())]
}
