//
//  FirstOnbardingScreenViewController.swift
//  CoinSaver
//
//  Created by fiskirton on 12.12.2020.
//

import UIKit
import paper_onboarding

let background = UIColor(red: 253/255, green: 196/255, blue: 70/255, alpha: 1)

let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
let descriptionFont = UIFont(name: "AvenirNext-Bold", size: 18)!

class OnboardingScreenViewController: UIViewController{

    @IBOutlet weak var onboardingView: PaperOnboarding!
        
    @IBOutlet weak var getStartedButton: UIButton!
    
    
    @IBAction func goToGetStarted(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toGetStarted", sender: nil)
    }
    
    let screens = [
        OnboardingItemInfo(informationImage: UIImage(named: "save_up")!, title: "Calc your expenses", description: "Icing lemon drops tootsie roll sugar plum. Cheesecake biscuit cupcake chocolate bar pudding chocolate cake. Danish donut sweet toffee.", pageIcon: UIImage(named: "mini_coin")!, color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        OnboardingItemInfo(informationImage: UIImage(named: "statistics")!, title: "Learn you expenses", description: "Icing lemon drops tootsie roll sugar plum. Cheesecake biscuit cupcake chocolate bar pudding chocolate cake. Danish donut sweet toffee.", pageIcon: UIImage(named: "mini_coin")!, color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        OnboardingItemInfo(informationImage: UIImage(named: "achivements")!, title: "Achive your goals", description: "Icing lemon drops tootsie roll sugar plum. Cheesecake biscuit cupcake chocolate bar pudding chocolate cake. Danish donut sweet toffee.", pageIcon: UIImage(named: "mini_coin")!, color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
}

extension OnboardingScreenViewController : PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    public func onboardingItemsCount() -> Int {
        screens.count
    }
    
    public func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return screens[index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index != screens.count - 1 {
            UIView.animate(withDuration: 0.2, animations: {
                self.getStartedButton.alpha = 0
            })
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == screens.count - 1 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
}
