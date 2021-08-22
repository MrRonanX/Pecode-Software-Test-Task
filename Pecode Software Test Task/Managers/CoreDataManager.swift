//
//  CoreDataManager.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/19/21.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Pecode_Software_Test_Task")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    
    func saveToCoreData(_ article: Article) {
        let cdArticle               = SavedArticle(context: persistentContainer.viewContext)
        cdArticle.articleId         = article.id.uuidString
        cdArticle.title             = article.title
        cdArticle.descriptionText   = article.description
        cdArticle.imageURL          = article.urlToImage
        cdArticle.url               = article.url
        cdArticle.publishedAt       = article.publishedAt
        cdArticle.author            = article.author
        cdArticle.source            = article.source.name
        cdArticle.favorite          = true
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("error saving the article")
        }
    }
    
    
    func fetchFavorites(completed: @escaping (Result<[Article], PSError>) -> Void) {
        let fetchRequest: NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        
        persistentContainer.viewContext.perform {
            do {
                let result = try fetchRequest.execute()

                let articles = result.map { Article(id: UUID(uuidString: $0.articleId!)!, source: Source(id: "", name: $0.source ?? ""), author: $0.author, title: $0.title, description: $0.descriptionText, url: $0.url, urlToImage: $0.imageURL, publishedAt: $0.publishedAt, content: "", favorite: true)}

                completed(.success(articles))
                
            } catch {
                completed(.failure(.errorFetchingData))
                print("Unable to Execute Fetch Request, \(error)")
            }
        }
    }
    
    
    func deleteFromCoreData(_ article: Article) {
        let fetchRequest: NSFetchRequest<SavedArticle> = SavedArticle.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "articleId == %@", article.id.uuidString)
        fetchRequest.fetchLimit = 1
        
        do {
            if let result = try persistentContainer.viewContext.fetch(fetchRequest).first {

                persistentContainer.viewContext.delete(result)
                try persistentContainer.viewContext.save()
            }
        } catch {
            print("deletion error")
        }
    }
}
