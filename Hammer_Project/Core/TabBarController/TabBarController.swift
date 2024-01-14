//
//  TabBarController.swift
//  Hammer_Project
//
//  Created by Alikhan Tursunbekov on 14/1/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = UIColor(hex: "#FD3A69")
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.layer.borderWidth = 0.4
        tabBar.backgroundColor = UIColor(hex: "#FFFFFF", alpha: 1)
    }
    
    private func setupTabs() {
        let menu = createNav(title: "Меню", image: UIImage(named: "menu"), vc: ViewController())
        let location = createNav(title: "Контаты", image: UIImage(named: "location"), vc: UIViewController())
        let profile = createNav(title: "Пофиль", image: UIImage(named: "profile"), vc: UIViewController())
        let bag = createNav(title: "Корзина", image: UIImage(named: "bag"), vc: UIViewController())
        location.view.backgroundColor = .white
        profile.view.backgroundColor = .white
        bag.view.backgroundColor = .white
        
        self.setViewControllers([menu, location, profile, bag], animated: true)
    }
    
    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image?.withRenderingMode(.alwaysTemplate)
        nav.tabBarItem.selectedImage = image?.withRenderingMode(.alwaysOriginal)
        return nav
    }
}
