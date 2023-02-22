//
//  DishPortraitCollectionViewCell.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import UIKit
import Kingfisher
class DishPortraitCollectionViewCell: UICollectionViewCell {

    static let identifier = "DishPortraitCollectionViewCell"
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dishImageView: UIImageView!
    
    
    @IBOutlet weak var caloriesLbl: UILabel!
    
    @IBOutlet weak var DescriptionLbl: UILabel!
    
    
    func setup(dish: Dish){
        titleLbl.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl) // URL OLARAK ÇEVİRİYOR
        caloriesLbl.text = dish.formattedCalories
        DescriptionLbl.text = dish.description
        
    }
    
    
}
