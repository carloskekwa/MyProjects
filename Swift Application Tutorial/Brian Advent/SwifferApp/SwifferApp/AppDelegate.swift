//
//  AppDelegate.swift
//  SwifferApp
//
//  Created by Sun on 7/9/14.
//  Copyright (c) 2014 Sun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor.orangeColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        Parse.setApplicationId("wPrMzXGaRIy6aGtHybUdKeiEQpBJmMG2tpo8XFl2", clientKey: "77R2zyO7JYWAcJ9qJrZLydCrouK2bJ1nkf40qp1o")
        
        let notificationTypes:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let notificationSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        /*
        var testObject:PFObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.setObject("user1", forKey: "user")
        
        testObject.saveInBackground()
        */
        
        return true
    }
    
    func application(application: UIApplication!, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings!) {
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func application(application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        let currentInstallation:PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackground()
    }
    
    func application(application: UIApplication!, didFailToRegisterForRemoteNotificationsWithError error: NSError!) {
        println(error.localizedDescription)
    }

    func application(application: UIApplication!, didReceiveRemoteNotification userInfo: NSDictionary!) {
        var notification:NSDictionary = userInfo.objectForKey("aps") as NSDictionary
        
        if notification.objectForKey("content-available") {
            if notification.objectForKey("content-available").isEqualToNumber(1) {
                NSNotificationCenter.defaultCenter().postNotificationName("reloadTimeline", object: nil)
            }
        } else {
                PFPush.handlePush(userInfo)
        }
    }
    
    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

