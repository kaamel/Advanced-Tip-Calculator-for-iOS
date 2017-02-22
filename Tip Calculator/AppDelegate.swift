//
//  AppDelegate.swift
//  Tip Calculator
//
//  Created by Kaamel Kermaani on 2/18/17.
//  Copyright © 2017 Kaamel Kermaani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var lastBillAmount: Double?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        let lastBillTime = defaults.object(forKey: "lastBillTime") as? TimeInterval ?? 0
        AppDelegate.lastBillAmount = defaults.object(forKey: "lastBillAmount") as! Double?
        if (AppDelegate.lastBillAmount != nil) {
            if (NSDate().timeIntervalSince1970 - lastBillTime > 600000) {
                AppDelegate.lastBillAmount = nil
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension String {
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            let currencySymbol = Locale.current.currencySymbol
            let newString = self.replacingOccurrences(of: currencySymbol!, with: "")
            if let result = String.numberFormatter.number(from: newString) {
                return result.doubleValue
            }
        }
        return 0
    }
}

extension Double {
    static var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }()
    var currency: String {
        return Double.currencyFormatter.string(from: self as NSNumber) ?? ""
    }
}



