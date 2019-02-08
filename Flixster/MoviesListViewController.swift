//
//  MoviesListViewController.swift
//  Flixster
//
//  Created by Shubham Sand on 2/7/19.
//  Copyright © 2019 Shubham Sand. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    
    @IBOutlet var movieTable: UITableView!
    
    var movieList = [[String: Any]]()
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        cell.movieLabel.text = movieList[indexPath.row]["title"] as? String
        cell.movieSynopsys.text = movieList[indexPath.row]["overview"] as? String
        
        let poster_url = movieList[indexPath.row]["poster_path"] as! String
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w185\(poster_url)")
        
        cell.moviePoster.af_setImage(withURL: imageUrl!)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTable.dataSource = self
        movieTable.delegate = self
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movieList = dataDictionary["results"] as! [[String:Any]]
                
                self.movieTable.reloadData()
                
                
                
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()

        // Do any additional setup after loading the view.
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
