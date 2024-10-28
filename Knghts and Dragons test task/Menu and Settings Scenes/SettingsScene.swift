import SpriteKit

class SettingsScene: SKScene {
    
    private var backgroundImage: EasyBackground!
    private var closeButton: CustomButton!
    private var welcomeLabel: CustomText!
    private var bankBalance: BankBalance!
    private var soundsButton: CustomButton!
    private var musicButton: CustomButton!
    private var vibrationButton: CustomButton!
    
    override func didMove(to view: SKView) {
        
        backgroundImage = EasyBackground(imageName: "castleBG", size: self.size)
        addChild(backgroundImage)
        
        closeButton = CustomButton(image: "exitIcon",
                                   position: CGPoint(x: size.width / 10, y: size.height * 0.82),
                                   backgroundImage: "smallButtonBG")
        addChild(closeButton)
        
        welcomeLabel = CustomText(text: "SETTINGS",
                                  position: CGPoint(x: size.width / 2, y: size.height * 0.8),
                                  backgroundWidth: CGFloat(260))
        addChild(welcomeLabel)
        
        bankBalance = BankBalance()
        bankBalance.position = CGPoint(x: size.width * 0.85, y: size.height * 0.82)
        addChild(bankBalance)
        
        soundsButton = CustomButton(text: "SOUNDS",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 + 15),
                                  backgroundImage: "bigButtonBG")
        addChild(soundsButton)
        
        musicButton = CustomButton(text: "MUSIC",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 45),
                                  backgroundImage: "bigButtonBG")
        addChild(musicButton)
        
        vibrationButton = CustomButton(text: "VIBRATION",
                                  position: CGPoint(x: size.width / 2, y: size.height / 2 - 105),
                                  backgroundImage: "bigButtonBG")
        addChild(vibrationButton)
        
        updateButtonStates()
    }
    
    private func updateButtonStates() {
        let isSoundsEnabled = AudioManager.shared.isSoundsEnabled
        let isMusicEnabled = AudioManager.shared.isMusicEnabled
        let isVibrationEnabled = AudioManager.shared.isVibrationEnabled
        
        soundsButton.alpha = isSoundsEnabled ? 1.0 : 0.5
        musicButton.alpha = isMusicEnabled ? 1.0 : 0.5
        vibrationButton.alpha = isVibrationEnabled ? 1.0 : 0.5
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
        
        if soundsButton.contains(location) {
            AudioManager.shared.setSoundsEnabled(!AudioManager.shared.isSoundsEnabled)
            updateButtonStates()
        }
        
        if musicButton.contains(location) {
            AudioManager.shared.setMusicEnabled(!AudioManager.shared.isMusicEnabled)
            updateButtonStates()
        }
        
        if vibrationButton.contains(location) {
            AudioManager.shared.setVibrationEnabled(!AudioManager.shared.isVibrationEnabled)
            updateButtonStates()
        }
    }
}
