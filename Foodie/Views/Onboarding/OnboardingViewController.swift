//
//  OnboardingViewController.swift
//  Foodie
//
//  Created by Erkan on 18.02.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    var slides : [OnboardingSlide] = []
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextBtn.setTitle("Get Started", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let image1 = UIImage(named: "slide1")
        let image2 = UIImage(named: "slide2")
        let image3 = UIImage(named: "slide3")
        
        slides = [
            OnboardingSlide(title: "Delicious dishes", description: "Experience a variety of amazing dishes from different cultures around the world", image: image1!),
            OnboardingSlide(title: "Worl-Class Chef's", description: "Our dishes are prepared by onlye the best", image: image2!),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world", image: image3!)
        ]
        
        pageControl.numberOfPages = slides.count
        
        
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            print("Go next page")
            let controller = storyboard?.instantiateViewController(withIdentifier: "homeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }

    }
    
}

                                                                                                    //boyutunun ayarlanması
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { // sürükledikten sonraki sayfanın indexi
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)  //pagesheetteki noktaların ayarlanması
        
    }
    
    
}
