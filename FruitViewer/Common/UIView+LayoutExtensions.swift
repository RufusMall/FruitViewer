//
//  UIView+LayoutExtensions.swift
//  FruitViewer
//
//  Created by Rufus on 12/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

extension UIView {
    public func constrainPinningEdgesToSuperview(useSystemSpacing: Bool = false, multiplier: CGFloat = 1) {
        guard let superview = self.superview  else {
            fatalError("constrainPinningEdgesToSuperview requires a valid superview")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if useSystemSpacing {
            leadingAnchor.constraint(equalToSystemSpacingAfter: superview.leadingAnchor, multiplier: multiplier).isActive = true
            superview.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: multiplier).isActive = true
            topAnchor.constraint(equalToSystemSpacingBelow: superview.topAnchor, multiplier: multiplier).isActive = true
            superview.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: multiplier).isActive = true
        } else {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
