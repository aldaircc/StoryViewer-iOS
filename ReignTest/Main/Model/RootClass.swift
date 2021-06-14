//
//  RootClass.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation

// MARK: - Welcome
struct RootClass: Codable {
    let hits: [Hit]
    let nbHits, page, nbPages, hitsPerPage: Int
    let exhaustiveNbHits: Bool
    let query: Query
    let params: String
    let processingTimeMS: Int
}

// MARK: - Hit
struct Hit: Codable {
    let createdAt: String
    let title: String?
    let url: String?
    let author: String
    let points: Int?
    let storyText: String?
    let commentText: String?
    let numComments, storyID: Int?
    let storyTitle: String?
    let storyURL: String?
    let parentID: Int?
    let createdAtI: Int
    let tags: [String]
    let objectID: String
    let highlightResult: HighlightResult

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title, url, author, points
        case storyText = "story_text"
        case commentText = "comment_text"
        case numComments = "num_comments"
        case storyID = "story_id"
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case parentID = "parent_id"
        case createdAtI = "created_at_i"
        case tags = "_tags"
        case objectID
        case highlightResult = "_highlightResult"
    }
}

// MARK: - HighlightResult
struct HighlightResult: Codable {
    let author: Author
    let commentText, storyTitle, storyURL, title: Author?
    let url: Author?

    enum CodingKeys: String, CodingKey {
        case author
        case commentText = "comment_text"
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case title, url
    }
}

// MARK: - Author
struct Author: Codable {
    let value: String
    let matchLevel: MatchLevel
    let matchedWords: [Query]
    let fullyHighlighted: Bool?
}

enum MatchLevel: String, Codable {
    case full = "full"
    case none = "none"
}

enum Query: String, Codable {
    case mobile = "mobile"
}
