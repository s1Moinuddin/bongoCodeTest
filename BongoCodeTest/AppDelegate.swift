//
//  AppDelegate.swift
//  BongoCodeTest
//
//  Created by S.M.Moinuddin on 10/31/21.
//

import UIKit
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupProgressHUD()
        return true
    }
    
    private func setupProgressHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setMinimumDismissTimeInterval(0.3)
    }

}

