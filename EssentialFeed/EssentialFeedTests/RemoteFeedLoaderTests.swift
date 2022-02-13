//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 13/02/2022.
//

import XCTest

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy : HTTPClient {
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load() {
        client.get(from: url)
    }
}

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_init_requestDataFromURL() {
        // Arange
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        // Act
        sut.load()
        
        // Assert
        XCTAssertEqual(client.requestedURL, url)
    }
}
