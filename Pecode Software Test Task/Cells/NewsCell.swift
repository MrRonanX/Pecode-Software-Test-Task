//
//  NewsCell.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

protocol NewsCellDelegate {
    func favoriteButtonPressed(_ article: Article)
}

final class NewsCell: UITableViewCell {
    
    static let reuseID = "NewsCell"
    
    private var titleLabel       = PSTitleLabel(textAlignment: .center, fontSize: 21)
    private var authorLabel      = PSBodyLabel(textAlignment: .right, fontSize: .caption1)
    private var descriptionLabel = PSBodyLabel(textAlignment: .center, fontSize: .body)
    private var publishedLabel   = PSBodyLabel(textAlignment: .right, fontSize: .caption2)
    private var sourceLabel      = PSBodyLabel(textAlignment: .right, fontSize: .caption1)
    private var newsImage        = PSImageView(frame: .zero)
    private var starButton       = PSStarButton()
    
    private var padding: CGFloat = 20
    private var currentArticle   : Article?
    var delegate                 : NewsCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView() {
        contentView.addSubviews(titleLabel, authorLabel, descriptionLabel, newsImage, publishedLabel, sourceLabel, starButton)
        
        descriptionLabel.textColor = .label
        descriptionLabel.numberOfLines = 5
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            newsImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: padding * 12),
            
            publishedLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 5),
            publishedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            publishedLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            publishedLabel.heightAnchor.constraint(equalToConstant: padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: publishedLabel.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -padding),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            
            starButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            starButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            starButton.widthAnchor.constraint(equalToConstant: 44),
            starButton.heightAnchor.constraint(equalToConstant: 44),
            
            authorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            authorLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            sourceLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 5),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            sourceLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding / 2)
            
        ])
    }
    
    
    func configure(with article: Article) {
        newsImage.downloadImage(fromURL: article.urlToImage) 
        if let date = article.publishedAt.toDate() {
            let correctDate = date.toString(.tableView)
            publishedLabel.text = correctDate
        }
        
        setButton(for: article)
        currentArticle          = article
        titleLabel.text         = article.title
        sourceLabel.text        = article.source.name
        authorLabel.text        = "by \(article.author)"
        descriptionLabel.text   = article.description
    }
    
    
    func setButton(for article: Article) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium)
        let buttonImage = UIImage(systemName: article.isFavorite ? "star.fill" : "star", withConfiguration: largeConfig)
        
        starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        starButton.setImage(buttonImage, for: .normal)
        starButton.tintColor = article.isFavorite ? .systemOrange : .black
    }
    
    
    @objc private func starButtonTapped() {
        guard var article = currentArticle else { return }
        article.isFavorite.toggle()
        setButton(for: article)
        delegate?.favoriteButtonPressed(article)
    }
}
