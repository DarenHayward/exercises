//
//  SharedTestHelpers.swift
//  EssentialAppTests
//
//  Created by Daren Hayward on 03/04/2022.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

