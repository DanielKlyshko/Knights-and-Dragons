import UIKit
import SpriteKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = UIViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        let skView = SKView(frame: window!.bounds)
        viewController.view.addSubview(skView)
        
        let initialScene = LoadingScene(size: skView.bounds.size)
        skView.presentScene(initialScene)
        
        return true
    }
}
