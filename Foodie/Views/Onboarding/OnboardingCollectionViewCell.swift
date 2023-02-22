//
//  OnboardingCollectionViewCell.swift
//  Foodie
//
//  Created by Erkan on 18.02.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var SlideImageView: UIImageView!
    
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    @IBOutlet weak var slideTitleLabel: UILabel!
    
    
    
    
    func setup(_ slide: OnboardingSlide){
        SlideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
