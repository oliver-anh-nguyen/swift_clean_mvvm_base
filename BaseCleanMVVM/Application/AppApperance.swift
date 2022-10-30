//
//  AppApperance.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 29/10/2022.
//

import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(red: 37/255.0, green: 37/255.0, blue: 37/255.0, alpha: 1.0)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor(red: 37/255.0, green: 37/255.0, blue: 37/255.0, alpha: 1.0)
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
