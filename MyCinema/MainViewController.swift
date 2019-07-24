//
//  MainViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 22/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let cinemaNames = [
        "СИНЕМА ПАРК Метрополис на Войковской", "KAPO SKY 17 Авиапарк",
        "Синема Парк", "Киномакс-Водный", "Кинотеатр Юность",
        "Формула Кино на Полежаевской", "Кинотеатр «Москва»",
        "Искра", "Балтика", "Кинотеатр Пионер","Киноцентр «Соловей»", "Полет",
        "Киносфера IMAX", "Каро 11 Октябрь", "Алмаз Синема Алтуфьевский"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemaNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel?.text = cinemaNames[indexPath.row]
        cell.imageOfPlace?.image = UIImage(named: cinemaNames[indexPath.row])
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
