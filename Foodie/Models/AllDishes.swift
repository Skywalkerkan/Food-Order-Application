//
//  AllDishes.swift
//  Foodie
//
//  Created by Erkan on 21.02.2023.
//

import Foundation


struct AllDishes: Decodable{
    
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
    
}
