//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Daren Hayward on 23/02/2022.
//

import Foundation

 struct RemoteFeedItem: Decodable {
     let id: UUID
     let description: String?
     let location: String?
     let image: URL
}
