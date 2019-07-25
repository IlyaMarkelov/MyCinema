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
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var movieTheaters: Results<Cinema>!
    private var filteredMovieTheaters: Results<Cinema>!
    private var ascendingSorting = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reverseSortingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTheaters = realm.objects(Cinema.self)
        
        //Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredMovieTheaters.count
        }
        return movieTheaters.isEmpty ? 0 :  movieTheaters.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        var cinema = Cinema()

        if isFiltering {
            cinema = filteredMovieTheaters[indexPath.row]
        } else {
            cinema = movieTheaters[indexPath.row]
        }
        
        cell.nameLabel?.text = cinema.name
        cell.detailLocationLabel.text = cinema.detailLocation
        cell.locationLabel.text = cinema.location
        cell.imageOfCinema.image = UIImage(data: cinema.imageData!)

        cell.imageOfCinema?.layer.cornerRadius = cell.imageOfCinema.frame.size.height / 2
        cell.imageOfCinema?.clipsToBounds = true

        return cell
    }

    //MARK: table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
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
            let cinema: Cinema
            if isFiltering {
                cinema = filteredMovieTheaters[indexPath.row]
            } else {
                cinema = movieTheaters[indexPath.row]
            }
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

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredMovieTheaters = movieTheaters.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@ OR detailLocation CONTAINS[c] %@", searchText, searchText, searchText)
        
        tableView.reloadData()
    }
}
