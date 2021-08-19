//
//  ArticlesModel.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import Foundation

struct Request: Codable {
    var articles: [Article]
    var totalResults: Int
}

struct Article: Codable, Hashable {
    
    let id          = UUID()
    let source      : Source
    let author      : String
    let title       : String
    let description : String
    let url         : String
    let urlToImage  : String
    let publishedAt : String
    let content     : String
    
    var isFavorite = false
    
    enum CodingKeys: String, CodingKey {

        case source         = "source"
        case author         = "author"
        case title          = "title"
        case description    = "description"
        case url            = "url"
        case urlToImage     = "urlToImage"
        case publishedAt    = "publishedAt"
        case content        = "content"
    }

    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        source      = try values.decodeIfPresent(Source.self, forKey: .source) ?? Source(id: "", name: "")
        author      = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        title       = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        url         = try values.decodeIfPresent(String.self, forKey: .url) ?? "https://www.google.com"
        urlToImage  = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        content     = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
    
    init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?, favorite: Bool) {
        self.source      = source ?? Source(id: "", name: "")
        self.author      = author ?? ""
        self.title       = title ?? ""
        self.description = description ?? ""
        self.url         = url ?? "https://www.google.com"
        self.urlToImage  = urlToImage ?? ""
        self.publishedAt = publishedAt ?? ""
        self.content     = content ?? ""
        self.isFavorite  = favorite
    } 
}

struct Source: Codable, Hashable {
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        
        case id     = "id"
        case name   = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        id      = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name    = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
