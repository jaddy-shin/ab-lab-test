//
//  ab_lab_testApp.swift
//  ab-lab-test
//
//  Created by jaddy on 6/4/25.
//

import SwiftUI
import TiaraSDK

@main
struct ab_lab_testApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initTiaraTracker()
        initTiaraABFactory()
        return true
    }
}
