//
//  FavouriteViewController.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 30/04/2024.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var favoriteStatus: [String: Bool] = [:]
    var jsonDictionary : JsonDictionary?
    var favouriteMoviesArray : [NSManagedObject]? {
        didSet {
            tableViewMovies.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
   
        
      
        favouriteMoviesArray = Database.sharedInstance.retriveDataFromCoreData()
    }
    
    @IBOutlet var tableViewMovies: UITableView!
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteMoviesArray?.count ?? 0
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("FavouriteMoviewArray count = \(favouriteMoviesArray?.count)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let movie = favouriteMoviesArray?[indexPath.row] {
            cell.textLabel?.text = movie.value(forKey: "title") as? String
            
//            jsonDictionary?.title = movie.value(forKey: "title") as? String
//            jsonDictionary?.author = movie.value(forKey: "author") as? String
//            jsonDictionary?.desription = movie.value(forKey: "desription") as? String
//            jsonDictionary?.imageUrl = movie.value(forKey: "imageUrl") as? String
//            jsonDictionary?.publishedAt = movie.value(forKey: "publishedAt") as? String
//            jsonDictionary?.url = movie.value(forKey: "url") as? String
            
        } else {
            cell.textLabel?.text = "Unknown"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            
//            if let movie = favouriteMoviesArray?[indexPath.row]{
//                let title = movie.value(forKey: "title") as! String? ?? "title error"
//                Database.sharedInstance.deleteFromCoreData(title: title)
//
//                favouriteMoviesArray?.remove(at: indexPath.row)
//
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
            
            if let movie = favouriteMoviesArray?[indexPath.row] {
                let title = movie.value(forKey: "title") as! String? ?? "title error"
                favouriteMoviesArray = Database.sharedInstance.deleteFromCoreData(title: title)
                   }

        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        

        
        tableViewMovies.reloadData()
        
       
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        if let movie = favouriteMoviesArray?[indexPath.row] {
            let jsonDictionary = JsonDictionary()
            jsonDictionary.title = movie.value(forKey: "title") as? String
            jsonDictionary.author = movie.value(forKey: "author") as? String
            jsonDictionary.desription = movie.value(forKey: "desription") as? String
            jsonDictionary.imageUrl = movie.value(forKey: "imageUrl") as? String
            jsonDictionary.publishedAt = movie.value(forKey: "publishedAt") as? String
            jsonDictionary.url = movie.value(forKey: "url") as? String
            let title = jsonDictionary.title ?? ""
            detailsViewController.isFavorite = favoriteStatus[title] ?? true
            
            detailsViewController.selectedObject = jsonDictionary
        }
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
