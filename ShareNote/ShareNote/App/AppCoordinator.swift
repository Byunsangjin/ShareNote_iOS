//
//  AppCoordinator.swift
//  ShareNote
//
//  Created by sjbyun on 2021/01/02.
//

import Foundation
import UIKit

class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = LoginViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
