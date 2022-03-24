//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 24/03/2022.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
