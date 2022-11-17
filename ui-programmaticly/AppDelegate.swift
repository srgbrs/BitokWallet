

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    static let sharedAppDelegate: AppDelegate = {
            guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
                fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
            }
            return delegate
        }()

    var deviceOrientation = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return deviceOrientation
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        if (UserDefaults.standard.object(forKey: "appCounter") == nil) {
            let appCounter = 0
            UserDefaults.standard.set(appCounter, forKey: "appCounter")
        } else {
            var appCounter = UserDefaults.standard.integer(forKey: "appCounter")
            appCounter += 1
            UserDefaults.standard.set(appCounter, forKey: "appCounter")
        }
        
        if (UserDefaults.standard.object(forKey: "wallet") == nil) {
            var wallet = 0
            UserDefaults.standard.set(wallet, forKey: "wallet")
        } else {
            
        }
        return true
        
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack

    static var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ui_programmaticly")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
    
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = AppDelegate.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

