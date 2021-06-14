//
//  StoryDetailCoordinator.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation

class StoryDetailCoordinator: Coordinator {
    
    //MARK: - Local variables
    private let presenter: Router
    private var storyDetailView: StoryDetailViewController?
    private let url: String?
    
    //MARK: - Initializer
    init(presenter: Router, url: String? = nil) {
        self.presenter = presenter
        self.url = url
    }
    
    //MARK: - Methods
    func start() {
        let storyDetailView = StoryDetailViewController(nibName: nil, bundle: nil)
        storyDetailView.view.backgroundColor = .white
        storyDetailView.storyUrl = self.url
        self.presenter.push(storyDetailView.toShowable(), animated: true, completion: nil)
    }
}
