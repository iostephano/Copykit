//
//  MainTabBarController.swift
//  CopyKit
//
//  Created by Stephano Portella on 5/03/25.
//
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var homeVC: HomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }
        
        homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "square.and.pencil")?.withRenderingMode(.alwaysOriginal)
        )
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let pencilDummyVC = UIViewController()
        pencilDummyVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal)
        )
        pencilDummyVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let eraserDummyVC = UIViewController()
        eraserDummyVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "eraser.fill")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "eraser.fill")?.withRenderingMode(.alwaysOriginal)
        )
        eraserDummyVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let colorsVC = ColorsViewController()
        let defaultColorIcon = UIImage(systemName: "circle.fill")?
            .withTintColor(BrushSettings.shared.color, renderingMode: .alwaysOriginal)
        colorsVC.tabBarItem = UITabBarItem(
            title: nil,
            image: defaultColorIcon,
            selectedImage: defaultColorIcon
        )
        colorsVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        viewControllers = [homeVC, pencilDummyVC, eraserDummyVC, colorsVC]
        selectedIndex = 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = viewControllers?.firstIndex(of: viewController) {
            if index == 1 {
                homeVC.setActiveTool(.pencil)
                selectedIndex = 0
            } else if index == 2 {
                homeVC.setActiveTool(.eraser)
                selectedIndex = 0
            } else if index == 0 {
                homeVC.setActiveTool(.none)
            }
        }
    }
}
