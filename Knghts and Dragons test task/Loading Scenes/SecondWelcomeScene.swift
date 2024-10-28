import SpriteKit

class SecondWelcomeScene: SKScene {
    
    private var welcomeLabel: CustomText!
    private var startButton: CustomButton!
    private var backgroundImage: EasyBackground!
    
    override func didMove(to view: SKView) {
        
        backgroundImage = EasyBackground(imageName: "castleBG", size: self.size)
        addChild(backgroundImage)
        
        welcomeLabel = CustomText(text: "YOUR CLOSE ASSISTANTS\nWILL BE PASSION AND LUCK",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2),
                                  backgroundWidth: CGFloat(400))
        addChild(welcomeLabel)
        
        startButton = CustomButton(text: "CONTINUE",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 130),
                                  backgroundImage: "bigButtonBG")
        addChild(startButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")
        
        if startButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let menuScene = MenuScene(size: self.size)
            view?.presentScene(menuScene, transition: transition)
        }
    }
}
