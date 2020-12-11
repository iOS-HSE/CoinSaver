//
//  ConfirmViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 15.11.2020.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentIndex = 0
    let images = [UIImage(named: "first"),
                  UIImage(named: "second"),
                  UIImage(named: "third"),
    ]
    let texts   = ["Control your spendings",
                   "Analyze finances",
                   "Set and achive goals"]
    var scheduler:Timer?
    func start(){
        scheduler = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
    }
    @objc func scroll(){
        if (currentIndex != 2){
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentIndex+1, section: 0), at: .centeredHorizontally, animated: true)
        }
        else{
            scheduler?.invalidate()
            scheduler=nil
            self.performSegue(withIdentifier: "afterGetStarted", sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Confirmation"
        pageControl.currentPage = 0
        start()
    }
    
}
extension ConfirmViewController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "getstartedCell", for: indexPath) as! GetStartedCollectionViewCell
        cell.image.image = images[indexPath.item]
        cell.label.text = texts[indexPath.item]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.currentIndex = Int(scrollView.contentOffset.x / sliderCollectionView.frame.width)
        pageControl.currentPage = self.currentIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
