import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let board:Board = Board()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)->Bool{
        let navigation = window!.rootViewController as! UINavigationController
        let controller = navigation.viewControllers[0] as! ViewController
        controller.board = board
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
           print("app did become active")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       print("app will become inactive")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("app did enter background")
        board.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       print("app will become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("app did terminate")
        board.save()
    }
       
       

}

