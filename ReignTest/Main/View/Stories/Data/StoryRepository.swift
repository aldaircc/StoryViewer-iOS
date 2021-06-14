//
//  StoryRepository.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation


class StoryRepository {
    
    //MARK: - Local variables
    private let remoteDataSource: StoryRemoteDataSource
    private let localDataSource: StoryLocalDataSource
    
    //MARK: - Initializer
    init(remoteDataSource: StoryRemoteDataSource, localDataSource: StoryLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    //MARK: - Methods
    func getStories(isOnline: Bool, completion: @escaping([StoryModel]) -> Void) {
        if isOnline {
            remoteDataSource.getStory { response in
                self.localDataSource.addStories(stories: response)
                self.localDataSource.getStory { localStories in
                    completion(localStories)
                }
            }
        } else {
            localDataSource.getStory { response in
                completion(response)
            }
        }
    }
    
    func deleteStory(story: StoryModel) {
        localDataSource.deleteStory(story: story)
    }
    
}

//MARK: - StoryDataSource protocol
protocol StoryDataSource {
    func getStory(completion: @escaping([StoryModel]) -> Void)
}
