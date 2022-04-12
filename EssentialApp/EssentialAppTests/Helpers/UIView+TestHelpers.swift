//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Daren Hayward on 12/04/2022.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.main.run(until: Date())
    }
}
