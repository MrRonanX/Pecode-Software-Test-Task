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
        showLoadingView()
        CoreDataManager.shared.fetchFavorites { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
                
            case .failure(let error):
                self.presentSPAlertOnMainThread(title: "Bad Stuff Happened", message: error.localizedDescription, buttonTitle: "ok")
            }
        }
    }
    
    func updateUI(with favorites: [Article]) {
        if favorites.isEmpty {
                self.showEmptyStateView(with: "You've got no favorites yet 😕 \nGo add them from the main screen.", in: self.tableView)
                return
            
        } else {
            self.removeEmptyState()
            self.articles = favorites
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.updateData(with: self.articles)
                self.view.bringSubviewToFront(self.tableView)
            }
        }
        
        
        
    }
}
