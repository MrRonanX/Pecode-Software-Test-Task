//
//  StarButton.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

final class PSStarButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure() {
        clipsToBounds   = true
        contentMode     = .scaleAspectFit
        tintColor       = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
}
