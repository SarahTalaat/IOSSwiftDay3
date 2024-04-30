//
//  FavouriteViewController.swift
//  IOSSwiftDay3
//
//  Created by Sara Talat on 30/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    
    @IBOutlet var tableViewMovies: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableViewMovies.delegate = self
        self.tableViewMovies.dataSource = self
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
