//
//  FeeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 20/03/2022.
//

import XCTest

final class FeedImagePresenter {
    init (view: Any) {

    }
}

class FeedImagePresenterTests: XCTestCase {

    func test_init_doesNotSendImagesToView() {
        let (_, view) = makeSUT()

        XCTAssertTrue(view.messages.isEmpty, "Expected no view images")
    }

    // MARK: - Helpers

    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedImagePresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view)
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(sut)
        return (sut, view)
    }

    class ViewSpy {
        let messages = [Any]()
    }
}
