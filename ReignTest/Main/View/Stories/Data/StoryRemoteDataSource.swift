//
//  StoryRemoteDataSource.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation

class StoryRemoteDataSource: StoryDataSource, NetworkClient {   
    let baseUrl = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"
    
    func getStory(completion: @escaping ([StoryModel]) -> Void) {
        var stories: [StoryModel] = []
        self.callService(from: baseUrl,
                         method: .Gest,
                         objectType: RootClass.self) { response in
            switch response {
            case .success(let data):
                let hits = data.hits
                for hit in hits {
                    stories.append(StoryModel.init(objectID: hit.objectID,
                                                   story_title: hit.storyTitle ?? (hit.title ?? ""),
                                                   story_author: hit.author,
                                                   createdAt: hit.createdAt,
                                                   storyURL: hit.storyURL ?? (hit.url ?? "")))
                }
                completion(stories)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
