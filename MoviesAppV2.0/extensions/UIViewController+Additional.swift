//
//  UIViewController+Additional.swift
//  MoviesAppV2.0
//
//  Created by Kashee on 01/07/22.
//

import Foundation
import UIKit


extension UIViewController {
//    class func controller<VC:UIViewController>() -> VC{
//        return controllerStoryboard(storyboardName:LEVAppConstants.StoryBoard.Main)
//    }
    
    class func controllerFromStoryboard<VC:UIViewController>(_ storyboard : UIStoryboard) -> VC {
        return storyboard.instantiateViewController(withIdentifier: String(describing:self)) as! VC
    }
    
    class func controllerStoryboard<VC:UIViewController>(storyboardName : String) -> VC{
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return controllerFromStoryboard(storyboard)
    }
    
    static func getTopViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        {
            return self.getTopViewController(navigationController.viewControllers.last)
            
        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController
        {
            return self.getTopViewController(selectedController)
            
        } else if let presentedController = viewController?.presentedViewController {
            return self.getTopViewController(presentedController)
            
        }
        
        return viewController
    }
}
