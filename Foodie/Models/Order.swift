//
//  Order.swift
//  Foodie
//
//  Created by Erkan on 21.02.2023.
//

import Foundation



struct Order: Decodable{
    let id : String?
    let name: String?
    let dish: Dish?
}
