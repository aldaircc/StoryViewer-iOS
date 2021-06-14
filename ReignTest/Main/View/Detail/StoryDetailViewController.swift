//
//  StoryDetailViewController.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import UIKit
import WebKit

class StoryDetailViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - UI Controls
    let detailWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    //MARK: - Local variables
    var storyUrl: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initializeWKWebView()
    }
    
    //MARK: - Methods
    fileprivate func initializeWKWebView() {
        guard let urlCorrect = URL.init(string: self.storyUrl ?? "") else {
            return
        }
        self.detailWebView.navigationDelegate = self
        self.detailWebView.load(URLRequest.init(url: urlCorrect))
        self.detailWebView.allowsBackForwardNavigationGestures = true
    }
    func setupUI() {
        self.view.backgroundColor = .red
        self.view.addSubview(detailWebView)
        NSLayoutConstraint.activate([
            detailWebView.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
