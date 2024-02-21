//
//  TabBarVC.swift
//  InstagramTask
//
//  Created by Mustafa Kemal ARDA on 16.02.2024.
//

import UIKit

class TabBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let tabBarController = UITabBarController()
        
        
        let homeItem = HomeVC()
        homeItem.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let uploadItem = UploadVC()
        uploadItem.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "photo.badge.plus"), tag: 1)
        
        let settingsItem = SettingsVC()
        settingsItem.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        
        

        tabBarController.viewControllers = [homeItem,uploadItem,settingsItem]
        
        self.view.addSubview(tabBarController.view)
        self.addChild(tabBarController)
        tabBarController.didMove(toParent: self)
        
        
    }
    
    
    

  

}

//#Preview(body: {
//    TabBarVC()
//})
//
