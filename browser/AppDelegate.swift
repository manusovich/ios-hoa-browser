//
//  AppDelegate.swift
//  browser
//
//  Created by Alexander Manusovich on 3/6/16.
//  Copyright © 2016 Alexander Manusovich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveCookies()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        loadCookies()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        loadCookies()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveCookies()
    }

    func loadCookies() {
        
        let cookieDict : NSMutableArray? = NSUserDefaults.standardUserDefaults().valueForKey("cookieArray") as? NSMutableArray
        
        if cookieDict != nil {
            
            for var c in cookieDict! {
                
                let cookies = NSUserDefaults.standardUserDefaults().valueForKey(c as! String) as! NSDictionary
                let cookie = NSHTTPCookie(properties: cookies as! [String : AnyObject])
                
                NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie!)
            }
        }
    }
    
    func saveCookies() {
        
        var cookieArray = NSMutableArray()
        let savedC = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies
        
        for var c : NSHTTPCookie in savedC! {
            
            var cookieProps = NSMutableDictionary()
            cookieArray.addObject(c.name)
            cookieProps.setValue(c.name, forKey: NSHTTPCookieName)
            cookieProps.setValue(c.value, forKey: NSHTTPCookieValue)
            cookieProps.setValue(c.domain, forKey: NSHTTPCookieDomain)
            cookieProps.setValue(c.path, forKey: NSHTTPCookiePath)
            cookieProps.setValue(c.version, forKey: NSHTTPCookieVersion)
            cookieProps.setValue(NSDate().dateByAddingTimeInterval(2629743), forKey: NSHTTPCookieExpires)
            
            NSUserDefaults.standardUserDefaults().setValue(cookieProps, forKey: c.name)
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
        NSUserDefaults.standardUserDefaults().setValue(cookieArray, forKey: "cookieArray")
    }

}

