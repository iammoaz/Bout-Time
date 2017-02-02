//
//  ThemeButton.swift
//  Bout Time
//
//  Created by Muhammad Moaz on 2/2/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class ThemeButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 4.0
    }
}
