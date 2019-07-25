//
//  MainViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 22/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {    
    
    var movieTheaters: Results<Cinema>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTheaters = realm.objects(Cinema.self)
    }

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTheaters.isEmpty ? 0 :  movieTheaters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let cinema = movieTheaters[indexPath.row]

        cell.nameLabel?.text = cinema.name
        cell.detailLocationLabel.text = cinema.detailLocation
        cell.locationLabel.text = cinema.location
        cell.imageOfCinema.image = UIImage(data: cinema.imageData!)

        cell.imageOfCinema?.layer.cornerRadius = cell.imageOfCinema.frame.size.height / 2
        cell.imageOfCinema?.clipsToBounds = true

        return cell
    }

    //MARK: table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cinema = movieTheaters[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(cinema)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newCinemaVC = segue.source as? NewCinemaViewController else {return}
        newCinemaVC.saveNewCinema()
        tableView.reloadData()
    }
}
