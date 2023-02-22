//
//  DishLandScapeCollectionViewCell.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import UIKit

class DishLandScapeCollectionViewCell: UICollectionViewCell {

    
    static let identifier = String(describing: DishLandScapeCollectionViewCell.self)
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!

    
    func setup(dish: Dish){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLabel.text = dish.name
        descriptionLabel.text = dish.description
        caloriesLabel.text = dish.formattedCalories
    }
    

}
