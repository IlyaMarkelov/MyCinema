//
//  CinameModel.swift
//  MyCinema
//
//  Created by Илья Маркелов on 24/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import RealmSwift

class Cinema: Object {
    @objc dynamic var name = ""
    @objc dynamic var detailLocation: String?
    @objc dynamic var location: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0

    
    convenience init(name: String, detailLocation: String?, location: String?, imageData: Data?, rating: Double) {
        self.init()
        self.name = name
        self.location = location
        self.detailLocation = detailLocation
        self.imageData = imageData
        self.rating = rating
    }
    
}
