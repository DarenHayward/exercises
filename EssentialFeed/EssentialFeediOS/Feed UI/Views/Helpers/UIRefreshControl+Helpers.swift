//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Daren Hayward on 19/03/2022.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
