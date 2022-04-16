//
//  FeedLoaderStub.swift
//  EssentialAppTests
//
//  Created by Daren Hayward on 05/04/2022.
//

import EssentialFeed

class FeedLoaderStub: FeedLoader {
    private let result: FeedLoader.Result

    init(result: FeedLoader.Result) {
        self.result = result
    }

    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
}
