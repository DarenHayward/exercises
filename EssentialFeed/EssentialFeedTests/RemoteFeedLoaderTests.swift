//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 13/02/2022.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestsDataFromURL() {
        // Arange
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        // Act
        sut.load()
        
        // Assert
        XCTAssertEqual(client.requestedURL, url)
    }
    
    func test_init_requestsDataFromURLTwice() {
        // Arange
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        // Act
        sut.load()
        sut.load()

        // Assert
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    // MARK: Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }
    
    private class HTTPClientSpy : HTTPClient {
        var requestedURL: URL?
        var requestedURLs = [URL]()
        
        func get(from url: URL) {
            requestedURL = url
            requestedURLs.append(url)
        }
    }
}
