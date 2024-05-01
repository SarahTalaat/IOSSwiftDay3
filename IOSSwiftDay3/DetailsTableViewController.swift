//
//  DetailsTableViewController.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 01/05/2024.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    
    @IBOutlet var descriptionDetails: UITextView!
    @IBOutlet var publishedAtDetails: UILabel!
    @IBOutlet var urlDetails: UILabel!
    @IBOutlet var titleDetails: UILabel!
    @IBOutlet var authorDetails: UILabel!
    @IBOutlet var imageDetails: UIImageView!
    
    @IBOutlet var favouriteButtonUIDetails: UIButton!
    @IBAction func favouriteButtonDetails(_ sender: Any) {
        
        isFavorite.toggle()
        
        if isFavorite {
   
            print("XXXX")
            
            let filledHeartImage = UIImage(systemName: "heart.fill")
            favouriteButtonUIDetails.setImage(filledHeartImage, for: .normal)
            Database.sharedInstance.saveToCoreData(author: selectedObject?.author ?? "auther error", title: selectedObject?.title ?? "title error", description: selectedObject?.desription ?? "desription error", imageUrl: selectedObject?.imageUrl ?? "imageUrl error", url: selectedObject?.url ?? "url error", publishedAt: selectedObject?.publishedAt ?? "publishedAt error")
        } else {
   
            let emptyHeartImage = UIImage(systemName: "heart")
            favouriteButtonUIDetails.setImage(emptyHeartImage, for: .normal)
            
        }
        
    }
    
    var selectedObject:JsonDictionary?
    var indexOfObject: Int?
    var isFavouriteButtonClicked = false
    var isFavorite: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        navigationController?.title = "Details"
        
  
        if let selectedObject = selectedObject,
           let imageUrlString = selectedObject.imageUrl as? String,
           let imageUrl = URL(string: imageUrlString) {
            loadImage(from: imageUrl)
        }
        
        descriptionDetails.text = selectedObject?.desription
        authorDetails.text = selectedObject?.author
        urlDetails.text = selectedObject?.url
        publishedAtDetails.text = selectedObject?.publishedAt
        titleDetails.text = selectedObject?.title

        if isFavorite {
            favouriteButtonUIDetails.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouriteButtonUIDetails.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageDetails.image = UIImage(data: data)
                }
            } else {
                // Handle error
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }

    
/*
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
