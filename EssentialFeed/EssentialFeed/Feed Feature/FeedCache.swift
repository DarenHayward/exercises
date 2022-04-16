//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 05/04/2022.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
