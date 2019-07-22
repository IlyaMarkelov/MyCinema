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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = cinemaNames[indexPath.row]
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

}
