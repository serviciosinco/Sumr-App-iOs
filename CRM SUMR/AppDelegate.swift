//
//  AppDelegate.swift
//  CRM SUMR
//
//  Created by Desarollo Portatil on 3/11/16.
//  Copyright © 2016 Servicios.in. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

	

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if #available(iOS 10, *) {
            // iOS 10 support
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
        
        if #available(iOS 9, *) {
            // iOS 9 support
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                //Parse errors and track state
            }
        }
        
        if #available(iOS 8, *) {
            // iOS 8 support
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                //Parse errors and track state
            }
        }
        
        
        if #available(iOS 9, *), #available(iOS 10, *) {
            let s1 = UIMutableApplicationShortcutItem(   type: "serviciosin.CRM-SUMR.visitas",
                                                         localizedTitle: "Visitas",
                                                         localizedSubtitle: "Ver mis visitas",
                                                         icon: UIApplicationShortcutIcon(type: .share),
                                                         userInfo: nil
            )
            application.shortcutItems = [s1]
        }

		/*
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let storyboard = UIStoryboard(name: "FirstTime", bundle: nil)
		let initialViewController = storyboard.instantiateViewController(withIdentifier: "LaunchWelcome")
		self.window?.rootViewController = initialViewController
		self.window?.makeKeyAndVisible()
*/

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

    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
    }

    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "serviciosin.CRM-SUMR.visitas" {
            
        }
    }
 
    
}
