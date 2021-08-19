//
//  WebViewController.swift
//  Pecode Software Test Task
//
//  Created by Roman Kavinskyi on 8/19/21.
//

import UIKit
import WebKit

final class PSWebViewController: UIViewController {
    
    private var webView: WKWebView!
    private var url: URL!
    
    init(website: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        url = URL(string: website)
        self.title = title
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        webView = WKWebView(frame: .zero, configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
        configureButtons()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
    private func configureButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
    }
    
    
    @objc private func refreshTapped() {
        webView.load(URLRequest(url: url))
    }
    
    
    @objc private func doneTapped() {
        dismiss(animated: true, completion: nil)
    }
}
