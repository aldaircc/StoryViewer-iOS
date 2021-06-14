//
//  StoryManager.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation
import CoreData

struct StoryManager {
    let context = PersistentStorage.shared.context
    
    func isEntityAttributedExist(id: String, entityName: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "objectId == %@", id)
        let result = try! context.fetch(fetchRequest)
        return result.count > 0 ? true : false
    }
    
    func save(story: StoryModel) {
        let entity = NSEntityDescription.entity(forEntityName: "StoryObject", in: context)!
        let storyMO = NSManagedObject(entity: entity, insertInto: context)
        storyMO.setValue(story.objectID, forKey: "objectId")
        storyMO.setValue(story.story_title, forKey: "story_title")
        storyMO.setValue(story.story_author, forKey: "story_author")
        storyMO.setValue(story.createdAt, forKey: "createdAt")
        storyMO.setValue(story.storyURL, forKey: "storyURL")
        storyMO.setValue(false, forKey: "isRemoved")
        PersistentStorage.shared.saveContext()
    }
    
    func getStoryObject(by objectId: String) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoryObject")
        let predicate = NSPredicate.init(format: "objectId==%@", objectId)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else { return nil }
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func update(objectId: String, deleted: Bool) {
        let storyObject = getStoryObject(by: objectId)
        guard storyObject != nil else { return }
        storyObject?.setValue(deleted, forKey: "isRemoved")
        PersistentStorage.shared.saveContext()
    }
    
    func getStories() -> [StoryModel] {
        var stories: [StoryModel] = []
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StoryObject")
        fetchRequest.predicate = NSPredicate.init(format: "isRemoved == NO")
        
        let sortDescriptor = NSSortDescriptor.init(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        var storiesObjects: [NSManagedObject] = []
        do {
            storiesObjects = try context.fetch(fetchRequest)
            for story in storiesObjects {
                let storyModel = self.convertToStoryModel(storyObject: story)
                stories.append(storyModel!)
            }
        } catch let error as NSError {
            print("Couldn´t not fetch. \(error), \(error.userInfo)")
        }
        
        return stories
    }
    
    func convertToStoryModel(storyObject: NSManagedObject) -> StoryModel? {
        let dictionary = self.convertToDictionary(storyObject: storyObject)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            do{
                _ = try? JSONSerialization.jsonObject(with: jsonData, options: [])
                let decoder = JSONDecoder()
                let decodeObject:StoryModel = try decoder.decode(StoryModel.self, from: jsonData)
                var storyEntity:StoryModel? = nil
                storyEntity = StoryModel.init(objectID: decodeObject.objectID,
                                                  story_title: decodeObject.story_title ?? "",
                                                  story_author: decodeObject.story_author,
                                                  createdAt: decodeObject.createdAt,
                                                  storyURL: decodeObject.storyURL ?? "",
                                                  isRemoved: decodeObject.isRemoved)
                return storyEntity
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func convertToDictionary(storyObject: NSManagedObject) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        for attribute in storyObject.entity.attributesByName {
            if let value = storyObject.value(forKey: attribute.key) {
                if attribute.key == "objectId" {
                    dictionary["objectId"] = value
                } else if attribute.key == "story_title" {
                    dictionary["story_title"] = value
                } else if attribute.key == "story_author" {
                    dictionary["story_author"] = value
                } else if attribute.key == "createdAt" {
                    dictionary["createdAt"] = value
                } else if attribute.key == "storyURL" {
                    dictionary["storyURL"] = value
                } else if attribute.key == "isRemoved" {
                    dictionary["isRemoved"] = value
                }
            }
        }
        return dictionary
    }
}
