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
    
    func saveToCoreData(author:String,title:String,desription:String,imageUrl:String,url:String,publishedAt:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
        movie.setValue(author, forKey: "author")
        movie.setValue(title, forKey: "title")
        movie.setValue(desription, forKey: "desription")
        movie.setValue(imageUrl, forKey: "imageUrl")
        movie.setValue(url, forKey: "url")
        movie.setValue(publishedAt, forKey: "publishedAt")
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error)
        }
        
    }
    
    func retriveDataFromCoreData() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
//        let myPredicate = NSPredicate(format: "title == %@", title)
//        fetchRequest.predicate = myPredicate
        do{
           
            movies = try managedContext.fetch(fetchRequest)
            return movies ?? []

        }catch let error as NSError {
            print("Error retrieving data: \(error.localizedDescription)")
            return []
        }
        
    }
    
    func deleteFromCoreData(index: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete((movies?[index])!)
        movies?.remove(at: index)
        do{
            try managedContext.save()
        }catch let error as NSError{
            print(error)
        }
    }
    
    
}
