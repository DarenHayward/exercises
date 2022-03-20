//
//  FeedViewControllerTests+Localization.swift
//  EssentialFeediOSTests
//
//  Created by Daren Hayward on 13/03/2022.
//

import Foundation
import XCTest
import EssentialFeed

extension FeedUIIntegrationTests {
    func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localizes string for key \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
}
