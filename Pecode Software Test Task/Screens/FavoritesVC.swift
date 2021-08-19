//
//  FavoritesVC.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

final class FavoritesVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }
    
    
    func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        screenType = .favorites
    }
    
    
    func fetchFavorites() {
        CoreDataManager.shared.fetchFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "You've got no favorites yet 😕 \nGo add them from the main screen.", in: self.tableView)
                        return
                    }
                }
                self.articles = favorites
                self.updateData(with: self.articles)
                
            case .failure(let error):
                self.presentSPAlertOnMainThread(title: "Bad Stuff Happened", message: error.localizedDescription, buttonTitle: "ok")
            }
        }
    }
}
