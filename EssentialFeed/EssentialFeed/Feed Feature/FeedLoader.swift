//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 12/02/2022.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
