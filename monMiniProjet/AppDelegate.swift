//
//  AppDelegate.swift
//  monMiniProjet
//
//  Created by ESPRIT on 07/11/2018.
//  Copyright © 2018 ESPRIT. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import GoogleSignIn;
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GIDSignInDelegate {

    var window: UIWindow?

    //facebook
    /* func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     // Override point for customization after application launch.
     return FBSDKApplicationDelegate.sharedInstance().application(application , didFinishLaunchingWithOptions: launchOptions)
     
     
     }*/
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication =  options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplication.OpenURLOptionsKey.annotation]
        
        let googleHandler = GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: sourceApplication,
            annotation: annotation )
        
        let facebookHandler = FBSDKApplicationDelegate.sharedInstance().application (
            app,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation )
        
        return googleHandler || facebookHandler
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      //  PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
       // let configureError: NSError?
        GIDSignIn.sharedInstance().clientID = "839231014739-mv58uclaq1gqtst5mqb5i130k38sq6cg.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
       
        
       // assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        return true
    }
  
    
    func signInWillDispatch(_signIn : GIDSignIn!, error : Error!){}
    
   /* func signIn(_signIn : GIDSignIn!, presentViewController viewController: UIViewController!)
    {self.presentV(viewController ,animated: true, completion: nil)}
    
    func signIn(_signIn : GIDSignIn!, dismissViewController viewController: UIViewController!)
    {self.dismiss(animated: true, completion: nil)}
    */
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
        //    let userId = user.userID
          // print(userId!)
            // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
         print(idToken!)
            let fullName = user.profile.name
         print(fullName!)
            let givenName = user.profile.givenName
         print(givenName!)
            let familyName = user.profile.familyName
        print(familyName!)
            let email = user.profile.email
        print(email!)
        }
    }
    
 
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.por la déconnection
        // ...
    }
    
   
    
   /***/
  

   
    
    func application(_ application: UIApplication, open url: URL,sourceApplication: String?,annotation:Any) -> Bool {
        
    let checkFb = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication , annotation: annotation)
        let checkGoogle = GIDSignIn.sharedInstance()?.handle(url as URL, sourceApplication: sourceApplication, annotation: annotation)
        // Add any custom logic here.
        return checkFb || checkGoogle!
    }

    /**/
    
  
    

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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "monMiniProjet")
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

}

