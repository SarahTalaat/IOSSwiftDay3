//
//  FavouriteViewController.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 30/04/2024.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
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
           
            Database.sharedInstance.deleteFromCoreData(index: indexPath.row)
         
            favouriteMoviesArray?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
        
        
        tableViewMovies.reloadData()
        
       
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
