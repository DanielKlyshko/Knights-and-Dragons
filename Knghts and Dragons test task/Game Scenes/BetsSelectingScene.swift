import SpriteKit

class BetsSelectingScene: SKScene {
    
    private var backgroundImage: EasyBackground!
    private var closeButton: CustomButton!
    private var welcomeLabel: CustomText!
    private var bankBalance: BankBalance!
    private var betButtons: [CustomButton] = []
    private var nextButton: CustomButton!
    private var selectedBet: String?
    private let backgroundImageName: String
    
    init(size: CGSize, backgroundImageName: String) {
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
        
        welcomeLabel = CustomText(text: "BET'S SIZE",
                                  position: CGPoint(x: size.width / 2, y: size.height * 0.8),
                                  backgroundWidth: CGFloat(260))
        addChild(welcomeLabel)
        
        let betValues = ["350", "400", "450", "500"]
        let positions: [CGPoint] = [
            CGPoint(x: size.width / 2 - 135, y: size.height / 2),
            CGPoint(x: size.width / 2 - 45, y: size.height / 2),
            CGPoint(x: size.width / 2 + 45, y: size.height / 2),
            CGPoint(x: size.width / 2 + 135, y: size.height / 2)
        ]
        
        for (index, value) in betValues.enumerated() {
            let button = CustomButton(text: value,
                                      position: positions[index],
                                      backgroundImage: "middleButtonBG")
            betButtons.append(button)
            addChild(button)
        }
        
        bankBalance = BankBalance()
        bankBalance.position = CGPoint(x: size.width * 0.85, y: size.height * 0.82)
        addChild(bankBalance)
        
        nextButton = CustomButton(text: "CONTINUE",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 135),
                                  backgroundImage: "bigButtonBG")
        nextButton.alpha = 0.5
        nextButton.isUserInteractionEnabled = false // Initially disabled
        addChild(nextButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")
        
        if closeButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let menuScene = MenuScene(size: self.size)
            view?.presentScene(menuScene, transition: transition)
            return
        }
        
        var selectedButton: CustomButton?
        
        for button in betButtons {
            if button.contains(location) {
                selectedButton = button
                break
            }
        }
        
        if let selectedButton = selectedButton {
            updateButtonStates(selectedButton)
            selectedBet = selectedButton.getText()
            
            nextButton.alpha = 1
            nextButton.isUserInteractionEnabled = false
        } else if nextButton.contains(location) && selectedBet != nil {
            let transition = SKTransition.fade(withDuration: 1.0)
            let mainGameScene = MainGameScene(size: self.size, selectedBet: selectedBet!, backgroundImageName: backgroundImageName)
            view?.presentScene(mainGameScene, transition: transition)
        }
    }
    
    private func updateButtonStates(_ selectedButton: CustomButton) {
        for button in betButtons {
            button.alpha = (button == selectedButton) ? 0.5 : 1
        }
    }
}
