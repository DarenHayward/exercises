//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 05/04/2022.
//

import Foundation

public protocol FeedImageDataCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ data: Data, for url: URL, completion: @escaping (Result) -> Void)
}

