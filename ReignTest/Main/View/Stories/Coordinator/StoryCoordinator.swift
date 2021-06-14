//
//  StoryCoordinator.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation

class StoryCoordinator: Coordinator {
    
    //MARK: - Local variables
    private let presenter: Router
    private var storyView: StoryViewController?
    private var storyDetailCoordinator: StoryDetailCoordinator?
    
    //MARK: - Initializer
    init(_ presenter: Router) {
        self.presenter = presenter
    }
    
    //MARK: - Methods
    func start() {
        let storyView = StoryViewController(nibName: nil, bundle: nil)
        storyView.view.backgroundColor = .white
        storyView.viewModel.delegate = self
        self.presenter.push(storyView, animated: true, completion: nil)
        self.storyView = storyView
    }
}

//MARK: - StoryViewDelegate
extension StoryCoordinator: StoryViewDelegate {
    func goToStoryDetail(url: String) {
        let detailStoryCoordinator = StoryDetailCoordinator(presenter: self.presenter, url: url)
        detailStoryCoordinator.start()
    }
}
