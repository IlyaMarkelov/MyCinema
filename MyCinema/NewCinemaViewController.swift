//
//  NewCinemaViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 24/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit

class NewCinemaViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }

}

//MARK: Text field delegate

extension NewCinemaViewController: UITextFieldDelegate {
    
    //скрываем клавиатуру по нажатию Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
