//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 27/03/2022.
//

public protocol FeedImageDataStore {
    typealias Result = Swift.Result <Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.Result) -> Void)
}
