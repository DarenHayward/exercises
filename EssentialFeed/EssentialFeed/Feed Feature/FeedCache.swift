//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 05/04/2022.
//

public protocol FeedCache {
    typealias SaveResult = Result<Void, Error>

    func save(_ feed: [FeedImage], completion: @escaping (SaveResult) -> Void)
}
