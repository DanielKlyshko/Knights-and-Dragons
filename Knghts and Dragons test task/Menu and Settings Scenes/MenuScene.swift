import SpriteKit

class MenuScene: SKScene {
    
    private var backgroundImage: EasyBackground!
    private var settingsButton: CustomButton!
    private var infoButton: CustomButton!
    private var bankBalance: BankBalance!
    private var knightGameCardImage: SKSpriteNode!
    private var dragonGameCardImage: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        backgroundImage = EasyBackground(imageName: "castleBG", size: self.size)
        addChild(backgroundImage)
        
        settingsButton = CustomButton(image: "settingsIcon",
                                      position: CGPoint(x: size.width / 10, y: size.height * 0.82),
                                      backgroundImage: "smallButtonBG")
        addChild(settingsButton)
        
        infoButton = CustomButton(image: "infoIcon",
                                  position: CGPoint(x: size.width / 10 + 60, y: size.height * 0.82),
                                  backgroundImage: "smallButtonBG")
        addChild(infoButton)
        
        bankBalance = BankBalance()
        bankBalance.position = CGPoint(x: size.width * 0.85, y: size.height * 0.82)
        addChild(bankBalance)
        
        knightGameCardImage = SKSpriteNode(imageNamed: "knightGameCard")
        knightGameCardImage.position = CGPoint(x: size.width / 2 + 100, y: size.height / 2 - 40)
        knightGameCardImage.zPosition = 1
        addChild(knightGameCardImage)
        
        dragonGameCardImage = SKSpriteNode(imageNamed: "dragonGameCard")
        dragonGameCardImage.position = CGPoint(x: size.width / 2 - 80, y: size.height / 2 - 40)
        dragonGameCardImage.zPosition = 1
        addChild(dragonGameCardImage)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")
        
        if knightGameCardImage.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let knightGameFirstWelcomeScene = GameFirstWelcomeScene(size: self.size, welcomeText: "WELCOME TO KNIGHT'S ADVENTURE", backgroundImageName: "dungeonBG")
            view?.presentScene(knightGameFirstWelcomeScene, transition: transition)
        }
        
        if dragonGameCardImage.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let dragonGameFirstWelcomeScene = GameFirstWelcomeScene(size: self.size, welcomeText: "WELCOME TO DRAGON MOUTH", backgroundImageName: "dragonBG")
            view?.presentScene(dragonGameFirstWelcomeScene, transition: transition)
        }
        
        if settingsButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let settingsScene = SettingsScene(size: self.size)
            view?.presentScene(settingsScene, transition: transition)
        }
        
        if infoButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let infoScene = InfoScene(size: self.size)
            view?.presentScene(infoScene, transition: transition)
        }
    }
}
