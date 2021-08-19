//
//  CellBodyTitle.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

class PSBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize size: UIFont.TextStyle) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: size)
    }
    
    
    private func configure() {
        textColor                                   = .secondaryLabel
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.75
        lineBreakMode                               = .byWordWrapping
        adjustsFontForContentSizeCategory           = true
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
