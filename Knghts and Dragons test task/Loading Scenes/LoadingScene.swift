import SpriteKit

class LoadingScene: SKScene {

    private var loadingBar: SKSpriteNode!
    private var loadingBarBackground: SKSpriteNode!
    private var loadingPercentageLabel: SKLabelNode!
    private var startButton: CustomButton!
    private var backgroundImage: SKSpriteNode!
    private var followerImage: SKSpriteNode!
    private var shieldImage: SKSpriteNode!
    private var spearOne: SKSpriteNode!
    private var spearTwo: SKSpriteNode!

    override func didMove(to view: SKView) {
        
        AudioManager.shared.playBackgroundMusic(named: "backgroundMusic.wav")
        
        backgroundImage = SKSpriteNode(imageNamed: "castleBG")
        backgroundImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundImage.size = self.size
        backgroundImage.zPosition = -1
        addChild(backgroundImage)

        shieldImage = SKSpriteNode(imageNamed: "shieldIcon")
        shieldImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        shieldImage.size = CGSize(width: 180, height: 180)
        shieldImage.zPosition = 2
        addChild(shieldImage)
        
        spearOne = SKSpriteNode(imageNamed: "spearIcon")
        spearOne.size = CGSize(width: 230, height: 230)
        spearOne.position = CGPoint(x: size.width / 2 + 40, y: size.height / 2 + 30)
        spearOne.zPosition = 1
        addChild(spearOne)
        
        spearTwo = SKSpriteNode(imageNamed: "spearIcon")
        spearTwo.size = CGSize(width: 230, height: 230)
        spearTwo.position = CGPoint(x: size.width / 2 - 40, y: size.height / 2 + 30)
        spearTwo.zPosition = 1
        spearTwo.xScale = -1
        addChild(spearTwo)

        let backgroundBarSize = CGSize(width: size.width * 0.8, height: 32)
        loadingBarBackground = SKSpriteNode(imageNamed: "progressBarBG")
        loadingBarBackground.position = CGPoint(x: size.width / 2, y: size.height / 6)
        loadingBarBackground.size = backgroundBarSize
        loadingBarBackground.zPosition = 1
        addChild(loadingBarBackground)

        loadingBar = SKSpriteNode(imageNamed: "progressBar")
        loadingBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        loadingBar.position = CGPoint(x: loadingBarBackground.position.x - loadingBarBackground.size.width / 2, y: loadingBarBackground.position.y)
        loadingBar.zPosition = 2
        loadingBar.size = CGSize(width: 0, height: 32)
        addChild(loadingBar)

        loadingPercentageLabel = SKLabelNode(text: "0%")
        loadingPercentageLabel.fontName = "BigShouldersStencilDisplay-Bold"
        loadingPercentageLabel.fontSize = 16
        loadingPercentageLabel.fontColor = .white
        loadingPercentageLabel.position = CGPoint(x: size.width / 2, y: loadingBarBackground.position.y - 6)
        loadingPercentageLabel.zPosition = 4
        addChild(loadingPercentageLabel)

        followerImage = SKSpriteNode(imageNamed: "coinIcon")
        followerImage.position = CGPoint(x: loadingBar.position.x, y: loadingBar.position.y)
        followerImage.size = CGSize(width: 40, height: 40)
        followerImage.zPosition = 3
        followerImage.xScale = -1
        addChild(followerImage)

        startButton = CustomButton(text: "START",
                                   position: CGPoint(x: size.width / 2, y: loadingBarBackground.position.y - 8),
                                   backgroundImage: "bigButtonBG")
        startButton.isHidden = true
        addChild(startButton)

        runLoadingAnimation()
        animateShield()
    }

    func runLoadingAnimation() {
        let duration: TimeInterval = 3.0
        let steps = 100

        for i in 0...steps {
            let wait = SKAction.wait(forDuration: duration / Double(steps) * Double(i))
            let update = SKAction.run {
                let progress = CGFloat(i) / CGFloat(steps)
                self.updateProgressBar(to: progress)
            }
            run(SKAction.sequence([wait, update]))
        }

        let finishLoading = SKAction.run {
            self.loadingBar.isHidden = true
            self.loadingBarBackground.isHidden = true
            self.loadingPercentageLabel.isHidden = true
            self.startButton.isHidden = false
            self.followerImage.isHidden = true
            self.shieldImage.removeAllActions()
        }
        run(SKAction.sequence([SKAction.wait(forDuration: duration), finishLoading]))
    }
    
    func animateShield() {
        let scaleUp = SKAction.scale(by: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(by: 1.0 / 1.1, duration: 1.0)
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        let repeatPulse = SKAction.repeatForever(pulse)
        shieldImage.run(repeatPulse)
    }


    func updateProgressBar(to progress: CGFloat) {
        loadingBar.size.width = loadingBarBackground.size.width * progress
        followerImage.position.x = loadingBar.position.x + loadingBar.size.width
        let percentage = Int(progress * 100)
        loadingPercentageLabel.text = "\(percentage)%"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")

        if startButton.contains(location) && !startButton.isHidden {
            let fadeOut = SKAction.fadeAlpha(to: 0.6, duration: 0.1)
            startButton.run(fadeOut)
            let transition = SKTransition.fade(withDuration: 1.0)
            
            let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
            if !isFirstLaunch {
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                let firstWelcomeScene = FirstWelcomeScene(size: self.size)
                view?.presentScene(firstWelcomeScene, transition: transition)
            } else {
                let menuScene = MenuScene(size: self.size)
                view?.presentScene(menuScene, transition: transition)
            }
        }
    }
}
