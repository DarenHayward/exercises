//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 27/03/2022.
//

public protocol FeedImageDataStore {
    typealias RetrievalResult = Swift.Result <Data?, Error>

    typealias InsertionResult = Swift.Result <Void, Error>

    func insert(_ data: Data, for: URL, completion: @escaping (InsertionResult) -> Void)
    func retrieve(dataForURL url: URL, completion: @escaping (RetrievalResult) -> Void)
}
