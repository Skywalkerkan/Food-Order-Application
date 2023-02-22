//
//  DishDetailViewController.swift
//  Foodie
//
//  Created by Erkan on 19.02.2023.
//

import UIKit
import Kingfisher
import ProgressHUD
class DishDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    
    var dish: Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
        // Do any additional setup after loading the view.
    }
    
    private func populateView(){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLabel.text = dish.name
        descriptionLabel.text = dish.description
        caloriesLabel.text = dish.formattedCalories
    }
    
    @IBAction func placeOrderButtonClicked(_ sender: Any) {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else{
            ProgressHUD.showError("Please Enter Your Name")
            return
            
        }
        ProgressHUD.show("Placing Order")
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { result in
            switch result{
            case .success(_):
                ProgressHUD.showSuccess("Your order has been recieved")
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    

    
}
