//
//  MainViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 22/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reverseSortingButton: UIBarButtonItem!
    
    var movieTheaters: Results<Cinema>!
    var ascendingSorting = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTheaters = realm.objects(Cinema.self)
    }

    // MARK: - Table view data source
   
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTheaters.isEmpty ? 0 :  movieTheaters.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cinema = movieTheaters[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
            StorageManager.deleteObject(cinema)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let cinema = movieTheaters[indexPath.row]
            let newCinemaVC = segue.destination as! NewCinemaViewController
            newCinemaVC.currentCinema = cinema
        }
    }
    

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newCinemaVC = segue.source as? NewCinemaViewController else {return}
        newCinemaVC.saveCinema()
        tableView.reloadData()
    }
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
        sorting()
    }
    
    @IBAction func reversefSorting(_ sender: Any) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reverseSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverseSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        
        sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            movieTheaters = movieTheaters.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            movieTheaters = movieTheaters.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        tableView.reloadData()
    }
}
