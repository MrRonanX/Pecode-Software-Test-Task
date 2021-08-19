//
//  TabBarController.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		UITabBar.appearance().tintColor = .systemGreen
		viewControllers 				= [createSearchNC(), createFavoritesNC()]
    }
	

	func createSearchNC() -> UINavigationController {
		let searchVC = SearchVC()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		
		return UINavigationController(rootViewController: searchVC)
	}
	
	
	func createFavoritesNC() -> UINavigationController {
		let favoritesVC = FavoritesVC()
		favoritesVC.title = "Favorites"
		favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		
		return UINavigationController(rootViewController: favoritesVC)
	}
}
