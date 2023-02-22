//
//  CategoryCollectionViewCell.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    
    func setup(category: DishCategory){
        categoryTitleLabel.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
        
        print("DeBUGG : \(category.name) ----- \(category.image)")
        
    }
    
    

}
