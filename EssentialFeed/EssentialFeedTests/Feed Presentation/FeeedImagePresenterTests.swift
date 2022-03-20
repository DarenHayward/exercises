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
        let view = ViewSpy()
        _ = FeedImagePresenter(view: view)

        XCTAssertTrue(view.messages.isEmpty, "Expected no view images")
    }

    // MARK: - Helpers

    class ViewSpy {
        let messages = [Any]()
    }
}
