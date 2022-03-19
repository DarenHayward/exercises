//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 19/03/2022.
//

import XCTest

final class FeedPresenter{
    init(view: Any) {

    }
}

class FeedPresenterTests: XCTestCase {

    func test_init_doesNotSendMessageToView() {
        let view = ViewSpy()

        _ = FeedPresenter(view: view)

        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }

    // MARK: - Helpers

    private class ViewSpy {
        let messages = [Any]()
    }
}
