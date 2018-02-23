//
//  TabBarController.swift
//  FlashCardUnit6HomeWork
//
//  Created by C4Q on 2/22/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .lightGray
        
        ///main login
        let categoryNavigation = UINavigationController(rootViewController: CategoryViewController())
        ///FavoriteVC
        let flashCardNavigation = UINavigationController(rootViewController: FlashCardViewController())
        
        categoryNavigation.tabBarItem = UITabBarItem(title: "Create", image: #imageLiteral(resourceName: "iconCreate"), tag: 0)
        flashCardNavigation.tabBarItem = UITabBarItem(title: "Play", image: #imageLiteral(resourceName: "play-button "), tag: 1)
        let tabList = [categoryNavigation, flashCardNavigation]
        viewControllers = tabList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
