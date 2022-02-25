//
//  CodeableFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 25/02/2022.
//

import XCTest
import EssentialFeed

class CodeableFeedStore: FeedStore {
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {

    }

    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {

    }

    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
}

class CodeableFeedStoreTests: XCTestCase {

    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = CodeableFeedStore()
        let exp = expectation(description: "Wait for cache retrieval")

        sut.retrieve { result in
            switch result {
            case .empty:
                break

            default:
                XCTFail("Expected empty result, got \(result) instead")
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }
}
