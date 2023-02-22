//
//  DishCategory.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import UIKit


struct DishCategory: Codable{
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name = "title"   // ADI FARKLI OLABİLİR BACKENDDEKİ DECODEDA
        case image
    }
}
