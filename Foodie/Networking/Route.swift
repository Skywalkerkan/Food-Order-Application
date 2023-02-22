//
//  Route.swift
//  Foodie
//
//  Created by Erkan on 21.02.2023.
//

import Foundation


enum Route{
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String) // category id
    case fetchOrders
    
    //return path of the endpoint
    var description: String{
        switch self{
        case .fetchAllCategories: return "/dish-categories"
        case .placeOrder(let dishId): return "/orders/\(dishId)" // idsine göre belirliyor
        case .fetchCategoryDishes(let categoryID): return "/dishes/\(categoryID)"
        case .fetchOrders:
            return "/orders"
        }
    }
}
