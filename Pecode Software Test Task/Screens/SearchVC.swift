//
//  SearchVC.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/19/21.
//

import UIKit

final class SearchVC: UIViewController {
    
    let logoImageView      = UIImageView()
    let logoLabel          = PSTitleLabel(textAlignment: .center, fontSize: 25)
    let articleTextField   = SPTextField()
    let callToActionButton = PSButton(backgroundColor: .systemGreen, title: "Get Articles")
    
    var isQueryEntered: Bool {
        return !articleTextField.text!.isEmpty
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, logoLabel, articleTextField, callToActionButton)
        configureLogoImageView()
        configureLogoLabel()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articleTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc private func pushArticlesVC() {
        guard isQueryEntered else {
            presentSPAlertOnMainThread(title: "Empty Query", message: "Please, enter a query. We need to know what to look for 😀.", buttonTitle: "Ok")
            return
        }
        
        articleTextField.resignFirstResponder()
        
        let articlesListVC         = ArticlesListVC(query: articleTextField.text!)
        show(articlesListVC, sender: self)
    }
    
    
    private func configureLogoImageView() {
        logoImageView.image = Images.logo
        logoImageView.contentMode = .scaleAspectFit
                
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoLabel() {
        logoLabel.text = "Your News"
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            logoLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configureTextField() {
        articleTextField.delegate = self
        
        NSLayoutConstraint.activate([
            articleTextField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 48),
            articleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            articleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            articleTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushArticlesVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushArticlesVC()
        return true
    }
}

