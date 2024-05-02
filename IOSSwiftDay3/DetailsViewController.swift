//
//  DetailsViewController.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 29/04/2024.
//

import UIKit

class DetailsViewController: UIViewController {

    var selectedObject:JsonDictionary?
    var indexOfObject: Int?
    var isFavouriteButtonClicked = false
    var isFavorite: Bool = false
    
    @IBOutlet var favouriteButtonUI: UIButton!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet var urlLabel: UILabel!
    

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.title = "Details"
        
  
        if let selectedObject = selectedObject,
           let imageUrlString = selectedObject.imageUrl as? String,
           let imageUrl = URL(string: imageUrlString) {
            loadImage(from: imageUrl)
        }
        
        descriptionTextView.text = selectedObject?.desription
        authorLabel.text = selectedObject?.author
        urlLabel.text = selectedObject?.url
        publishedAtLabel.text = selectedObject?.publishedAt
        titleLabel.text = selectedObject?.title

        if isFavorite {
            favouriteButtonUI.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouriteButtonUI.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
    

    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.myImage.image = UIImage(data: data)
                }
            } else {
                // Handle error
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }

    @IBAction func favouriteButton(_ sender: Any) {
        
        isFavorite.toggle()
        
        if isFavorite {
   
            print("XXXX")
            
            let filledHeartImage = UIImage(systemName: "heart.fill")
            favouriteButtonUI.setImage(filledHeartImage, for: .normal)
            
//            DatabaseOfflineMovie.sharedInstance.saveToCoreData(author: selectedObject?.author ?? "auther error", title: selectedObject?.title ?? "title error", description: selectedObject?.desription ?? "desription error", imageUrl: selectedObject?.imageUrl ?? "imageUrl error", url: selectedObject?.url ?? "url error", publishedAt: selectedObject?.publishedAt ?? "publishedAt error")
//
            Database.sharedInstance.saveToCoreData(author: selectedObject?.author ?? "auther error", title: selectedObject?.title ?? "title error", description: selectedObject?.desription ?? "desription error", imageUrl: selectedObject?.imageUrl ?? "imageUrl error", url: selectedObject?.url ?? "url error", publishedAt: selectedObject?.publishedAt ?? "publishedAt error")
            

        } else {
   
            let emptyHeartImage = UIImage(systemName: "heart")
            favouriteButtonUI.setImage(emptyHeartImage, for: .normal)
            
        }
        
        
        
        
        // Toggle isFavorite property
//        selectedObject?.isFavorite.toggle()
        
//        if selectedObject?.isFavorite == true {
//            // Update UI when favorited
//            let filledHeartImage = UIImage(systemName: "heart.fill")
//            favouriteButtonUI.setImage(filledHeartImage, for: .normal)
//            Database.sharedInstance.saveToCoreData(author: selectedObject?.author ?? "auther error", title: selectedObject?.title ?? "title error", description: selectedObject?.desription ?? "desription error", imageUrl: selectedObject?.imageUrl ?? "imageUrl error", url: selectedObject?.url ?? "url error", publishedAt: selectedObject?.publishedAt ?? "publishedAt error")
//            // Save to CoreData or update your data model accordingly
//        } else {
//            // Update UI when unfavorited
//            let emptyHeartImage = UIImage(systemName: "heart")
//            favouriteButtonUI.setImage(emptyHeartImage, for: .normal)
//            // Remove from CoreData or update your data model accordingly
//        }
//
        
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
