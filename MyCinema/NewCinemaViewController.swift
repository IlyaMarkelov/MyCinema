//
//  NewCinemaViewController.swift
//  MyCinema
//
//  Created by Илья Маркелов on 24/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import UIKit

class NewCinemaViewController: UITableViewController {
    
    var currentCinema: Cinema?
    var imageIsChanged = false

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cinemaImage: UIImageView!
    @IBOutlet weak var cinemaName: UITextField!
    @IBOutlet weak var cinemaDetailLocation: UITextField!
    @IBOutlet weak var cinemaLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        saveButton.isEnabled = false
        cinemaName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                    self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                    self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

//MARK: Text field delegate

extension NewCinemaViewController: UITextFieldDelegate {
    
    //скрываем клавиатуру по нажатию Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if cinemaName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    func saveCinema() {
        
        
        var image: UIImage?
        
        if imageIsChanged {
            image = cinemaImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceHolder")
        }
        
        let imageData = image?.pngData()
        
        let newCinema = Cinema(name: cinemaName.text!,
                               detailLocation: cinemaDetailLocation.text,
                               location: cinemaLocation.text,
                               imageData: imageData)
        
        if currentCinema != nil {
            try! realm.write {
                currentCinema?.name = newCinema.name
                currentCinema?.location = newCinema.location
                currentCinema?.detailLocation = newCinema.detailLocation
                currentCinema?.imageData = newCinema.imageData
            }
        } else {
            StorageManager.saveObject(newCinema)
        }
    }
    
    private func setupEditScreen() {
        if currentCinema != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentCinema?.imageData, let image = UIImage(data: data) else {return}
            cinemaImage.image = image
            cinemaImage.contentMode = .scaleAspectFill
            cinemaName.text = currentCinema?.name
            cinemaDetailLocation.text = currentCinema?.detailLocation
            cinemaLocation.text = currentCinema?.location
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentCinema?.name
        saveButton.isEnabled = true
    }
}


//MARK: Work with image
extension NewCinemaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cinemaImage.image = info[.editedImage] as? UIImage
        cinemaImage.contentMode = .scaleAspectFill
        cinemaImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}
