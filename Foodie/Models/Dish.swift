//
//  Dish.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import Foundation

struct Dish: Codable{
    let id: String?
    let name: String?
    let description: String?
    let image: String?
    let calories: Int?
    
    var formattedCalories: String{
        return "\(calories ?? 0) calories"
        
        
        //return String(format: "%.2f Calories", calories ?? 0)
    }
    
}
