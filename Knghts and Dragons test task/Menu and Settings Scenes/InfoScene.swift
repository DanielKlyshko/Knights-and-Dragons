import SpriteKit

class InfoScene: SKScene {
    
    private var backgroundImage: EasyBackground!
    private var closeButton: CustomButton!
    private var welcomeLabel: CustomText!
    private var bankBalance: BankBalance!
    private var termsOfUseButton: CustomButton!
    private var policyButton: CustomButton!
    private var contactsButton: CustomButton!
    
    override func didMove(to view: SKView) {
           
        backgroundImage = EasyBackground(imageName: "castleBG", size: self.size)
        addChild(backgroundImage)
        
        closeButton = CustomButton(image: "exitIcon",
                                   position: CGPoint(x: size.width / 10, y: size.height * 0.82),
                                   backgroundImage: "smallButtonBG")
        addChild(closeButton)
        
        welcomeLabel = CustomText(text: "INFORMATION",
                                  position: CGPoint(x: size.width / 2, y: size.height * 0.8),
                                  backgroundWidth: CGFloat(260))
        addChild(welcomeLabel)
        
        bankBalance = BankBalance()
        bankBalance.position = CGPoint(x: size.width * 0.85, y: size.height * 0.82)
        addChild(bankBalance)
        
        termsOfUseButton = CustomButton(text: "TERMS OF USE",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 + 15),
                                  backgroundImage: "bigButtonBG")
        addChild(termsOfUseButton)
        
        policyButton = CustomButton(text: "POLICY",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 45),
                                  backgroundImage: "bigButtonBG")
        addChild(policyButton)
        
        contactsButton = CustomButton(text: "CONTACTS",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 105),
                                  backgroundImage: "bigButtonBG")
        addChild(contactsButton)
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
        
    }
    
}
