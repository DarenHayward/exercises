//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Daren Hayward on 10/03/2022.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
