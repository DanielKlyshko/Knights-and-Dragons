import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            let scene = LoadingScene(size: view.bounds.size)
            
            view.presentScene(scene)
            
            view.showsFPS = false
            view.showsNodeCount = false
            
            view.showsPhysics = true
            
            view.ignoresSiblingOrder = true
            
            view.preferredFramesPerSecond = 60
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
