//
//  StorageManager.swift
//  MyCinema
//
//  Created by Илья Маркелов on 24/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ cinema: Cinema) {
        
        try! realm.write {
            realm.add(cinema)
        }
    }
    
    static func deleteObject(_ cinema: Cinema) {
        try! realm.write {
            realm.delete(cinema)
        }
    }
}
