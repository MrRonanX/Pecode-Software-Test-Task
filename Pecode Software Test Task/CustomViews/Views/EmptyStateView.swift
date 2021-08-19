//
//  EmptyStateView.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit
final class EmptyStateView: UIView {
    
    let messageLabel = PSTitleLabel(textAlignment: .center, fontSize: 28)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubviews(messageLabel)
        configureMessageLabel()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor     = .secondaryLabel
   
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
