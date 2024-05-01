//
//  Database.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 30/04/2024.
//

import Foundation
import CoreData
import UIKit


class Database {
    
    static let sharedInstance = Database()
    
    private init() {
     
    }
    
    /*
     var author: String?
     var title: String?
     var desription: String?
     var imageUrl: String?
     var url: String?
     var publishedAt: String?
     */
    
    var movies: [NSManagedObject]?
    
//    func saveToCoreData(author:String,title:String,desription:String,imageUrl:String,url:String,publishedAt:String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
//        let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
//        movie.setValue(author, forKey: "author")
//        movie.setValue(title, forKey: "title")
//        movie.setValue(desription, forKey: "desription")
//        movie.setValue(imageUrl, forKey: "imageUrl")
//        movie.setValue(url, forKey: "url")
//        movie.setValue(publishedAt, forKey: "publishedAt")
//
//        do{
//            try managedContext.save()
//        }catch let error as NSError{
//            print(error)
//        }
//
//    }
    
    func saveToCoreData(author: String, title: String, description: String, imageUrl: String, url: String, publishedAt: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Check if the movie with the same title already exists
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let existingMovie = results.first as? NSManagedObject {
                // Movie with the same title already exists, update its attributes if necessary
                existingMovie.setValue(author, forKey: "author")
                existingMovie.setValue(title, forKey: "title")
                existingMovie.setValue(description, forKey: "desription")
                existingMovie.setValue(imageUrl, forKey: "imageUrl")
                existingMovie.setValue(url, forKey: "url")
                existingMovie.setValue(publishedAt, forKey: "publishedAt")
            } else {
                // Movie doesn't exist, create a new one
                let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
                let movie = NSManagedObject(entity: entity, insertInto: managedContext)
                movie.setValue(author, forKey: "author")
                movie.setValue(title, forKey: "title")
                movie.setValue(description, forKey: "desription")
                movie.setValue(imageUrl, forKey: "imageUrl")
                movie.setValue(url, forKey: "url")
                movie.setValue(publishedAt, forKey: "publishedAt")
            }
            
            try managedContext.save()
        } catch let error as NSError {
            print("Error saving to CoreData: \(error.localizedDescription)")
        }
    }

    
    
    func retriveDataFromCoreData() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
//        let myPredicate = NSPredicate(format: "title == %@", movies.title)
//        fetchRequest.predicate = myPredicate
        do{
           
            movies = try managedContext.fetch(fetchRequest)
            return movies ?? []

        }catch let error as NSError {
            print("Error retrieving data: \(error.localizedDescription)")
            return []
        }
        
    }
    
//    func deleteFromCoreData(index: Int){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        managedContext.delete((movies?[index])!)
//        movies?.remove(at: index)
//        do{
//            try managedContext.save()
//        }catch let error as NSError{
//            print(error)
//        }
//    }
//    func deleteFromCoreData(index: Int){
//        guard let managedObject = movies?[index] else {
//            print("Movie not found at index \(index)")
//            return
//        }
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        managedContext.delete(managedObject)
//        movies?.remove(at: index)
//
//        do {
//            try managedContext.save()
//        } catch let error as NSError {
//            print("Error saving after deletion: \(error.localizedDescription)")
//        }
//    }
//
//    func deleteFromCoreData(title: String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
//        let predicate = NSPredicate(format: "title == %@", title)
//        fetchRequest.predicate = predicate
//
//        do {
//            if let result = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
//                managedContext.delete(result)
//                try managedContext.save()
//                movies = retriveDataFromCoreData()
//            } else {
//                print("Movie with unique identifier \(title) not found")
//            }
//        } catch let error as NSError {
//            print("Error deleting from Core Data: \(error.localizedDescription)")
//        }
//    }

    func deleteFromCoreData(title: String) -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
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

    
}
