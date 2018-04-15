//
//  AppDelegate.swift
//  Todoey
//
//  Created by Doug Mason on 4/7/18.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        do {
            _ = try Realm()
        }
        catch {
            print("Error initialising new realm: \(error)")
        }
        
        return true
    }
    
    static let shared = UIApplication.shared.delegate as! AppDelegate
}
