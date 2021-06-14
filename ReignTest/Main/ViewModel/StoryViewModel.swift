//
//  StoryViewModel.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation

protocol StoryViewDelegate: AnyObject {
    func goToStoryDetail(url: String)
}

class StoryViewModel {
    
    var delegate: StoryViewDelegate?
    let repository = StoryRepository(remoteDataSource: StoryRemoteDataSource(), localDataSource: StoryLocalDataSource())
    
    func getStories(completion: @escaping([StoryModel]) -> Void) {
        let isOnline = Reachability.isConnectedToNetwork()
        repository.getStories(isOnline: isOnline) { stories in
            completion(stories)
        }
    }
    
    func deleteStory(story: StoryModel) {
        repository.deleteStory(story: story)
    }
    
    func goToStoryDetail(_ url: String) {
        self.delegate?.goToStoryDetail(url: url)
    }
}
