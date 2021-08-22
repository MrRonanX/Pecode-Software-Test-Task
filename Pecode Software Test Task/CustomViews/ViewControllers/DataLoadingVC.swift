//
//  DataLoadingVC.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/18/21.
//

import UIKit

class DataLoadingVC: UIViewController {
    
    var containerView: UIView!
    var emptyStateView: EmptyStateView?
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        
        emptyStateView                  = EmptyStateView(message: message)
        emptyStateView?.frame           = view.bounds
        emptyStateView?.backgroundColor = .systemBackground
        view.addSubview(emptyStateView!)
    }
    
    func removeEmptyState() {
        DispatchQueue.main.async {
            self.emptyStateView?.removeFromSuperview()
            self.emptyStateView = nil
        }
    }
}
