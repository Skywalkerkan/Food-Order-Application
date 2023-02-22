//
//  HomeVC.swift
//  Foodie
//
//  Created by Erkan on 18.02.2023.
//

import UIKit
import ProgressHUD

class HomeVC: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    @IBOutlet weak var specialCollectionView: UICollectionView!
    var categories: [DishCategory] = []
    
    var populars: [Dish] = []
    
    var specials: [Dish] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let service = NetworkService()
       // let request = service.createRequest(route: .temp, method: .post, parameters: ["firstName": "Erkan", "lastname": "Demir"])
       // print("the url is: \(request?.url)")
       // print("the body: \(request?.httpBody)")
       /*
        NetworkService.shared.myFirstRequest { (result) in
            switch result{
            case .success(let data):
               // print("The decoded data is \(data)")
                for dish in data{
                    print(dish.name ?? "")
                }
            
            case .failure(let error):
                print("erorr is \(error.localizedDescription)")
            }
        }*/
        
        
        
        
        title = "Foodie"
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        specialCollectionView.delegate = self
        specialCollectionView.dataSource = self
        registerCells()
        ProgressHUD.show()
        
        NetworkService.shared.fetchAllCategories { [weak self] result in
            switch result{
            case .success(let allDishes):
                //print("Itwas quite succesfull")
                ProgressHUD.dismiss()
                self?.categories = allDishes.categories ?? []
                self?.populars = allDishes.populars ?? []
                self?.specials = allDishes.specials ?? []
                
                self?.categoryCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.specialCollectionView.reloadData()
            case .failure(let error):
                //print("Error is \(error.localizedDescription)")
                ProgressHUD.showError()
            }
        }
        
        
    }
    
    private func registerCells(){ // xiblerin registerlanması
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: DishLandScapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandScapeCollectionViewCell.identifier)
        
    }
    
    



}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case categoryCollectionView:
            return categories.count  // collectionların ayrı dataların ayarlanması
        case popularCollectionView:
            return populars.count
        case specialCollectionView:
            return specials.count
        default: return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell  // collectionların ayrı dataların ayarlanması
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            return cell
        case specialCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandScapeCollectionViewCell.identifier, for: indexPath) as! DishLandScapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }

        
        

    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            //controller.dishes = categories[indexPath.row].id
           // controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }else{                                                  //Yemek kategorisi hariç diğer kategorilerin pushları
            let controller = DishDetailViewController.instantiate()
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row]: specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
