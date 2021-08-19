//
//  CellImageView.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

final class PSImageView: UIImageView {
    
    let cache                 = NetworkManager.shared.cache
    let placeholderImage      = Images.placeholder
    var imageHeight: CGFloat? = nil
    var imageWidth: CGFloat?  = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        contentMode        = .scaleAspectFit
    }
    
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageHeight = image?.size.height
                self.imageWidth = image?.size.width
                if let image = image { self.image = image }
                else { self.image = self.placeholderImage }
            }
        }
    }
}


