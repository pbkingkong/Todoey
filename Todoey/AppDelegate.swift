//
//  AppDelegate.swift
//  Todoey
//
//  Created by Peter Buzek on 14.09.18.
//  Copyright © 2018 Peter Buzek. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
  print(Realm.Configuration.defaultConfiguration.fileURL)
         
        
        do {
            _ = try Realm()
            } catch {
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }



}

