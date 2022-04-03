//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Daren Hayward on 03/04/2022.
//

import XCTest
import EssentialFeed

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    private class Task: FeedImageDataLoaderTask {
        func cancel() {}
    }

    private let primary: FeedImageDataLoader

    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
    }

    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        _ = primary.loadImageData(from: url) { _ in }
        return Task()
    }
}

class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {

    func test_init_doesNotLoadImageData() {
        let (_, primaryLoader, fallbackLoader) = makeSUT()

        XCTAssertTrue(primaryLoader.loadedURLs.isEmpty, "Expected no loaded URLs in the primary loader")
        XCTAssertTrue(fallbackLoader.loadedURLs.isEmpty, "Expected no loaded URLs in the fallback loader")
    }

    func test_loadImageData_loadsFromPrimaryLoaderFirst() {
        let url = anyURL()
        let (sut, primaryLoader, fallbackLoader) = makeSUT()

        _ = sut.loadImageData(from: url) { _ in }

        XCTAssertEqual(primaryLoader.loadedURLs, [url])
        XCTAssertTrue(fallbackLoader.loadedURLs.isEmpty)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedImageDataLoaderWithFallbackComposite, primary: LoaderSpy, fallback: LoaderSpy) {
        let primaryLoader = LoaderSpy()
        let fallbackLoader = LoaderSpy()
        let sut = FeedImageDataLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        trackForMemoryLeaks(primaryLoader, file: file, line: line)
        trackForMemoryLeaks(fallbackLoader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, primaryLoader, fallbackLoader)
    }

    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }

    private func anyURL() -> URL {
        return URL(string: "http://a-url.com")!
    }

    private class LoaderSpy: FeedImageDataLoader {
        private(set) var loadedURLs = [URL]()

        private struct Task: FeedImageDataLoaderTask {
            func cancel() {}
        }

        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
            loadedURLs.append(url)
            return Task()
        }
    }
}
