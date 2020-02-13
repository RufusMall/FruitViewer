//
//  AccessibleLabel.swift
//  FruitViewer
//
//  Created by Rufus on 13/02/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import UIKit

open class AccessibleLabel: UILabel {
    private override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(forTextStyle: .body)
    }
    
    public required init(textStyle: UIFont.TextStyle) {
        super.init(frame: .zero)
        commonInit(forTextStyle: textStyle)
    }
    
    private func commonInit(forTextStyle textStyle: UIFont.TextStyle) {
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
