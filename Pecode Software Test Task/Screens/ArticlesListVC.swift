//
//  ViewController.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

// api bc0556bf8d8a43d7806e669f113965c6

import UIKit

final class ArticlesListVC: BaseVC  {
    
    private var query               : String!
    private let searchController    = UISearchController(searchResultsController: nil)
    private let refreshControl      = UIRefreshControl()
    private var today               = Date()
    private var page                = 1
    private var hasMorePages        = true
    private var isRefreshing        = false
    
    init(query: String) {
        super.init(nibName: nil, bundle: nil)
        self.query = query
        self.title = query.uppercased()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSortAndFilter()
        setupRefreshControl()
        setupSearch()
        loadArticles(with: query, page: page)
    }
    
    
    func setupSortAndFilter() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped))
    }
    
    
    @objc private func sortTapped() {
        let sheet = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Name", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.articles.sort(by: { $0.title < $1.title })
            self.updateData(with: self.articles)
        })
        
        sheet.addAction(UIAlertAction(title: "Date", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.articles.sort(by: { $0.publishedAt < $1.publishedAt })
            self.updateData(with: self.articles)
        })
        
        sheet.addAction(UIAlertAction(title: "Source", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.articles.sort(by: { $0.source.name < $1.source.name })
            self.updateData(with: self.articles)
        })
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.showDetailViewController(sheet, sender: self)
    }
    
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Filter"
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    @objc private func refresh(_ sender: AnyObject) {
        isRefreshing = true
        loadArticles(with: query, page: page)
    }
    
    
    func loadArticles(with query: String, page: Int) {
        showLoadingView()
        hasMorePages = true
        NetworkManager.shared.getArticles(for: query, date: today.toString(.query), page: page) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingView()
                self.refreshControl.endRefreshing()
                
                switch result {
                case .success(let articles):
                    self.updateUI(with: articles)
                case .failure(let error):
                    self.presentSPAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
                }
            }
        }
    }
    
    func updateUI(with articles: [Article]) {
        if isRefreshing {
            self.updateData(with: articles)
            isRefreshing = false
        }
        
        if articles.count < 20 { self.hasMorePages = false }
        self.articles.append(contentsOf: articles)
        
        if self.articles.isEmpty {
            let message = "Cannot find anything 😢 \nTry another query"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.tableView)
                return
            }
        }
        self.updateData(with: self.articles)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard screenType == .search, indexPath.row == articles.count - 1, hasMorePages else { return }
        page += 1
        DispatchQueue.main.async {
            self.loadArticles(with: self.query, page: self.page)
        }
    }
}

extension ArticlesListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        isSearching = true
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredArray.removeAll()
            updateData(with: articles)
            isSearching = false
            return
        }
        
        filteredArray = articles.filter { $0.description.lowercased().contains(filter.lowercased()) }
        updateData(with: filteredArray)
    }
}







