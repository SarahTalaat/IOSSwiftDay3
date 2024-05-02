//
//  DatabaseOfflineMovie.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 02/05/2024.
//

import Foundation
import CoreData
import UIKit

class DatabaseOfflineMovie{
    
    static let sharedInstance = DatabaseOfflineMovie()
    
    private init() {
        
    }
    
    var movies: [NSManagedObject]? = [] // Initialize movies array
    
    func saveToCoreData(author: String, title: String, description: String, imageUrl: String, url: String, publishedAt: String) {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OfflineMovie")
            let predicate = NSPredicate(format: "title == %@", title)
            fetchRequest.predicate = predicate
            
            do {
                let results = try managedContext.fetch(fetchRequest)
                if let existingMovie = results.first as? NSManagedObject {
                    existingMovie.setValue(author, forKey: "author")
                    existingMovie.setValue(title, forKey: "title")
                    existingMovie.setValue(description, forKey: "desription")
                    existingMovie.setValue(imageUrl, forKey: "imageUrl")
                    existingMovie.setValue(url, forKey: "url")
                    existingMovie.setValue(publishedAt, forKey: "publishedAt")
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "OfflineMovie", in: managedContext)!
                    let movie = NSManagedObject(entity: entity, insertInto: managedContext)
                    movie.setValue(author, forKey: "author")
                    movie.setValue(title, forKey: "title")
                    movie.setValue(description, forKey: "desription")
                    movie.setValue(imageUrl, forKey: "imageUrl")
                    movie.setValue(url, forKey: "url")
                    movie.setValue(publishedAt, forKey: "publishedAt")
                }
                try managedContext.save()
                
                // Fetch updated data and assign it to the movies array
                self.movies = self.retriveDataFromCoreData()
            } catch let error as NSError {
                print("Error saving to CoreData: \(error.localizedDescription)")
            }
        }
    }
    
    func retriveDataFromCoreData() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "OfflineMovie")
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            return movies
        } catch let error as NSError {
            print("Error retrieving data: \(error.localizedDescription)")
            return []
        }
    }
    
    
    func deleteFromCoreData(title: String) -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OfflineMovie")
        let predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.predicate = predicate
        
        do {
            if let result = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
                managedContext.delete(result)
                try managedContext.save()
                return retriveDataFromCoreData()
            } else {
                print("Movie with title \(title) not found")
                return []
            }
        } catch let error as NSError {
            print("Error deleting from Core Data: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteAllRecordsFromTable(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OfflineMovie")
//        let predicate = NSPredicate(format: "title == %@", title)
//        fetchRequest.predicate = predicate
        
        do {
            
            let items = try managedContext.fetch(fetchRequest)as! [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }
            
        } catch let error as NSError {
            print("Error deleting from Core Data: \(error.localizedDescription)")
     
        }
    }
    
    
}
