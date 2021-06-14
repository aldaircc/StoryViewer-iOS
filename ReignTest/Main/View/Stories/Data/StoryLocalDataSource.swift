//
//  StoryLocalDataSource.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation

struct StoryLocalDataSource: StoryDataSource {
    
    let storyManager = StoryManager()
    
    func getStory(completion: @escaping ([StoryModel]) -> Void) {
        completion(storyManager.getStories())
    }
    
    func addStories(stories: [StoryModel]) {
        for story in stories {
            if storyManager.isEntityAttributedExist(id: story.objectID, entityName: "StoryObject") == false {
                storyManager.save(story: story)
            }
        }
    }
    
    func deleteStory(story: StoryModel) {
        storyManager.update(objectId: story.objectID, deleted: true)
    }
}
