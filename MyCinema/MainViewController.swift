//
//  MainViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 22/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {    
    
    var movieTheaters = Cinema.getCinema()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTheaters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let cinema = movieTheaters[indexPath.row]
        
        cell.nameLabel?.text = cinema.name
        cell.detailLocationLabel.text = cinema.detailLocation
        cell.locationLabel.text = cinema.location
        
        if cinema.image == nil {
            cell.imageOfCinema.image = UIImage(named: cinema.cinemaImage!)
        } else {
            cell.imageOfCinema.image = cinema.image
        }
        
        
        cell.imageOfCinema?.layer.cornerRadius = cell.imageOfCinema.frame.size.height / 2
        cell.imageOfCinema?.clipsToBounds = true
        
        return cell
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
        movieTheaters.append(newCinemaVC.newCinema!)
        tableView.reloadData()
    }
}
