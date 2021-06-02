//
//  AppDelegate.swift
//  EcoApp
//
//  Created by Artem on 23.04.2021.
//

import UIKit
import CoreData
import ParseSwift
import AuthenticationServices
import FBSDKCoreKit
import UserNotifications

let appDelegate = (UIApplication.shared.delegate as! AppDelegate)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let serverUrl = "http://ecobalance.life:1337/parse"
    private lazy var networkReachability = NetworkReachability(hostname: serverUrl)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let appId = "ecoapp"
        let serverUrl = "http://ecobalance.life:1337/parse"
        ParseSwift.initialize(applicationId: appId,
                              serverURL: URL(string: serverUrl)!)
        
//        if User.current == nil {
//            let vc = getController(forName: LoginViewController.self)
//            window?.rootViewController = vc
//        }
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                break // The Apple ID credential is valid.
//            case .revoked, .notFound:
//                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                DispatchQueue.main.async {
//                    self.window?.rootViewController?.showLoginViewController()
//                }
//            default:
//                break
//            }
//        }
        

        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay ]) {
                 (granted, error) in
                 print("Permission granted: \(granted)")
                 guard granted else { return }
                 self.getNotificationSettings()
             }
        
        return true
    }
    
    func getNotificationSettings() {
         UNUserNotificationCenter.current().getNotificationSettings { (settings) in
             print("Notification settings: \(settings)")
             guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
         }
     }
    
    func routeToHabitList() {
        let vc = getController(forName: HabitListViewController.self)
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
    }
    
    func logoutUser() {
        try? User.logout()
//        presentLoginScreeenIfNeeded()
    }
    
//    func presentLoginScreeenIfNeeded() {
//        guard User.current == nil else {
//            return
//        }
//        let vc = getController(forName: LoginViewController.self)
//        window?.rootViewController = vc
//    }
    
    func createInstallationOnParse(deviceTokenData:Data) {
        if var inst = Installation.current {
            inst.setDeviceToken(deviceTokenData)
            inst.save { (result) in
                switch result {
                case .success(let inst):
                    print("You have successfully saved your push installation to Back4App!", inst.installationId ?? "")
                case .failure(let error):
                    print(error)
                }
            }
        }
     }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        createInstallationOnParse(deviceTokenData: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("error reg push:", error)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "EcoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    func isConnectedToServer() -> Bool {
        switch networkReachability.currentReachabilityStatus {
        case .notReachable:
            return false
        case .reachableViaWiFi, .reachableViaWWAN:
            return true
        }
    }
    
}

