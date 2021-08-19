//
//  BaseVC.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit


class BaseVC: DataLoadingVC, UITableViewDelegate {
    enum ScreenType { case search, favorites}
    enum Section { case main }
    
    typealias DataSource            = UITableViewDiffableDataSource<Section, Article>
    typealias DataSourceSnapshot    = NSDiffableDataSourceSnapshot<Section, Article>
    
    var articles                    = [Article]()
    var filteredArray               = [Article]()
    
    private var dataSource          : DataSource!
    private var snapshot            = DataSourceSnapshot()
    
    var tableView                   = UITableView()
    var screenType: ScreenType      = .search
    var isSearching                 = false
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setTableView()
        configureDataSource()
    }
    
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.pinToEdges(of: view)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 420
    }
    
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, cellContent) -> NewsCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID, for: indexPath) as! NewsCell
            cell.delegate = self
            cell.configure(with: cellContent)
            return cell
        })
    }
    
    
    func updateData(with articles: [Article]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        DispatchQueue.main.async {
            self.dataSource.apply(self.snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    
    func toggleFavorites(_ article: Article) {
        if let index = articles.firstIndex(where: {$0.id == article.id }) {
            articles[index].isFavorite = article.isFavorite
            snapshot = DataSourceSnapshot()
            snapshot.appendSections([.main])
            snapshot.appendItems(articles)
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let activeArray = isSearching ? filteredArray : articles
        let article = activeArray[indexPath.row]
        let webView = PSWebViewController(website: article.url, title: article.source.name)
        let navVC = UINavigationController(rootViewController: webView)
        showDetailViewController(navVC, sender: self)
    }
}

extension BaseVC: NewsCellDelegate {
    func favoriteButtonPressed(_ article: Article) {
        toggleFavorites(article)
        
        switch article.isFavorite {
        case true:
            CoreDataManager.shared.saveToCoreData(article)
        case false:
            CoreDataManager.shared.deleteFromCoreData(article)
            if let index = articles.firstIndex(where: {$0.id == article.id }), screenType == .favorites {
                articles.remove(at: index)
                updateData(with: articles)
            }
        }
    }
}

