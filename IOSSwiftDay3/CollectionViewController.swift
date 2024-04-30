//
//  CollectionViewController.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 29/04/2024.
//

import UIKit

//private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    var allObjectsArray: [JsonDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
        getDataFromApi{ [weak self] jsonResponse in
            self?.allObjectsArray = jsonResponse
            print("Json response = \(jsonResponse.count)")
            print("allObjectArray = \(self?.allObjectsArray.count)")
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
            
        }
        

        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    /*

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    
    */
    //----------------------------------
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return allObjectsArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        var object = allObjectsArray[indexPath.row]
        print("Object auther = \(object.author)")
        
        
        DispatchQueue.main.async {
            cell.myLabel.text = object.author
            print("auther Label= \(object.author)")
           // cell.myTextView.text = object.title
        }
        
        // Check if imageUrl is available
        if let imageUrlString = object.imageUrl, let imageUrl = URL(string: imageUrlString) {
            // Download image from imageUrl
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let error = error {
                    print("Error downloading image: \(error)")
                    return
                }
                
                // Ensure data is not nil and create UIImage from data
                if let data = data, let image = UIImage(data: data) {
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        cell.myImage.image = image
                    }
                }
            }.resume()
        }
      

        
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        let selectedObject = allObjectsArray[indexPath.row]
        detailsViewController.selectedObject = selectedObject
        detailsViewController.indexOfObject = indexPath.row
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate width of each cell to fit two cells in a row
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - 10 * 3) / 2 // 10 is the spacing between cells
        return CGSize(width: cellWidth, height: cellWidth) // Assuming square cells
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexaPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
