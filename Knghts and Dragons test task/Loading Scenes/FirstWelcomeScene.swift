import SpriteKit

class FirstWelcomeScene: SKScene {
    
    private var welcomeLabel: CustomText!
    private var nextButton: CustomButton!
    private var backgroundImage: EasyBackground!
    
    override func didMove(to view: SKView) {
        
        backgroundImage = EasyBackground(imageName: "castleBG", size: self.size)
        addChild(backgroundImage)
        
        welcomeLabel = CustomText(text: "WELCOME TO THE WORLD OF\nMEDIEVAL ENTERTAINMENT",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2),
                                  backgroundWidth: CGFloat(400))
        addChild(welcomeLabel)
        
        nextButton = CustomButton(text: "CONTINUE",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 130),
                                  backgroundImage: "bigButtonBG")
        addChild(nextButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")
        
        if nextButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let secondWelcomeScene = SecondWelcomeScene(size: self.size)
            view?.presentScene(secondWelcomeScene, transition: transition)
        }
    }
}
