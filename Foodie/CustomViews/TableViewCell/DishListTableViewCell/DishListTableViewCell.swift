//
//  DishListTableViewCell.swift
//  Foodie
//
//  Created by Erkan on 21.02.2023.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

    static let identifier = "DishListTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dishImageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setup(dish: Dish){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLabel.text = dish.name
        descriptionLabel.text = dish.description
    }
    
    
    func setup(order: Order){
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        titleLabel.text = order.dish?.name
        descriptionLabel.text = order.name
    }
}
