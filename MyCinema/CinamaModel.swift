//
//  CinameModel.swift
//  MyCinema
//
//  Created by Илья Маркелов on 24/07/2019.
//  Copyright © 2019 Илья Маркелов. All rights reserved.
//

import Foundation

struct Cinema {
    var name: String
    var price: String
    var location: String
    var image: String
    
    static let cinemaNames = [
        "СИНЕМА ПАРК Метрополис", "KAPO SKY 17 Авиапарк",
        "Синема Парк", "Киномакс-Водный", "Кинотеатр Юность",
        "Формула Кино на Полежаевской", "Кинотеатр Москва",
        "Искра", "Балтика", "Кинотеатр Пионер","Киноцентр «Соловей»", "Полет",
        "Киносфера IMAX", "Каро 11 Октябрь", "Алмаз Синема Алтуфьевский"
    ]

    static func getCinema() -> [Cinema] {
        
        var cinema = [Cinema]()
        
        for movie in cinemaNames {
            cinema.append(Cinema(name: movie, price: "100-200", location: "Москва", image: movie))
        }
        
        return cinema
    }
}
