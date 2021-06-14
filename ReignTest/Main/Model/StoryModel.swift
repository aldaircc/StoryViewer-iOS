//
//  StoryModel.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 11/06/21.
//

import Foundation

struct StoryModel: Codable {
    let objectID: String
    let story_title: String?
    let story_author: String
    let createdAt: String
    let storyURL: String?
    var isRemoved: Int
    
    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case story_title = "story_title"
        case story_author = "story_author"
        case createdAt = "createdAt"
        case storyURL = "storyURL"
        case isRemoved = "isRemoved"
    }
    
    init(objectID: String, story_title: String, story_author: String, createdAt: String, storyURL: String, isRemoved: Int = 0) {
        self.objectID = objectID
        self.story_title = story_title
        self.story_author = story_author
        self.createdAt = createdAt
        self.storyURL = storyURL
        self.isRemoved = isRemoved
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        objectID = try values.decodeIfPresent(String.self, forKey: .objectID) ?? ""
        story_title = try values.decodeIfPresent(String.self, forKey: .story_title) ?? ""
        story_author = try values.decodeIfPresent(String.self, forKey: .story_author) ?? ""
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        storyURL = try values.decodeIfPresent(String.self, forKey: .storyURL) ?? ""
        isRemoved = try values.decodeIfPresent(Int.self, forKey: .isRemoved) ?? 0
    }
}
