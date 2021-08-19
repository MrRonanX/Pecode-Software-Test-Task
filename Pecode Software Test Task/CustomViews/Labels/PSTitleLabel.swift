//
//  CellTitleLabel.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

final class PSTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure() {
        textColor                 = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.8
        lineBreakMode             = .byTruncatingTail
        numberOfLines             = 2
    }
}
