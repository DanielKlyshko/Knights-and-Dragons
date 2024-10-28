import SpriteKit

class GameFirstWelcomeScene: SKScene {

    private var backgroundImage: EasyBackground!
    private var closeButton: CustomButton!
    private var welcomeLabel: CustomText!
    private var bankBalance: BankBalance!
    private var nextButton: CustomButton!
    private let welcomeText: String
    private let backgroundImageName: String

    init(size: CGSize, welcomeText: String, backgroundImageName: String) {
        self.welcomeText = welcomeText
        self.backgroundImageName = backgroundImageName
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        backgroundImage = EasyBackground(imageName: backgroundImageName, size: self.size)
        addChild(backgroundImage)
        
        closeButton = CustomButton(image: "exitIcon",
                                   position: CGPoint(x: size.width / 10, y: size.height * 0.82),
                                   backgroundImage: "smallButtonBG")
        addChild(closeButton)
        
        welcomeLabel = CustomText(text: welcomeText,
                                  position: CGPoint(x: size.width / 2, y: size.height / 2),
                                  backgroundWidth: CGFloat(400))
        addChild(welcomeLabel)
        
        bankBalance = BankBalance()
        bankBalance.position = CGPoint(x: size.width * 0.85, y: size.height * 0.82)
        addChild(bankBalance)
        
        nextButton = CustomButton(text: "CONTINUE",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 135),
                                  backgroundImage: "bigButtonBG")
        addChild(nextButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")
        
        if closeButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let menuScene = MenuScene(size: self.size)
            view?.presentScene(menuScene, transition: transition)
        }
        
        if nextButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let nextScene = GameSecondWelcomeScene(size: self.size, backgroundImageName: backgroundImageName)
            view?.presentScene(nextScene, transition: transition)
        }
    }
}
