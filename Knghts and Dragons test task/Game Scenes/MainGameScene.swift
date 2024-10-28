import SpriteKit
import UIKit

class MainGameScene: SKScene {
    
    private var backgroundImage: EasyBackground!
    private var closeButton: CustomButton!
    private var bankBalance: BankBalance!
    private var bankLabel: SKLabelNode!
    private var bankCountLabel: CustomButton!
    private var finishButton: CustomButton!
    private var selectedBet: String?
    private var gameSlotsBGImage: SKSpriteNode!
    private var coefficientLabels: [SKLabelNode] = []
    private var winLabel: CustomText!
    private var winCountLabel: SKLabelNode!
    private var loseLabel: CustomText!
    private var resultBGImage: SKSpriteNode!
    private var goToMenuButton: CustomButton!
    private let backgroundImageName: String
    private var gameSlots: [[GameSlotConstructor]] = []
    private var isSlotSelected: Bool = false
    private var rowsRevealed: Int = 0

    init(size: CGSize, selectedBet: String = "0", backgroundImageName: String) {
        self.selectedBet = selectedBet
        self.backgroundImageName = backgroundImageName
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setupUI()
        setupSlots()
    }
    
    private func setupUI() {
        backgroundImage = EasyBackground(imageName: backgroundImageName, size: self.size)
        addChild(backgroundImage)
        
        closeButton = CustomButton(image: "exitIcon",
                                   position: CGPoint(x: size.width / 10, y: size.height * 0.82),
                                   backgroundImage: "smallButtonBG")
        addChild(closeButton)
        
        bankBalance = BankBalance()
        bankBalance.position = CGPoint(x: size.width * 0.85, y: size.height * 0.82)
        addChild(bankBalance)
        
        bankCountLabel = CustomButton(text: selectedBet,
                                      position: CGPoint(x: size.width * 0.85, y: size.height * 0.52),
                                      backgroundImage: "bankCountBG",
                                      fontSize: 16)
        addChild(bankCountLabel)
        
        bankLabel = SKLabelNode(text: "BANK")
        bankLabel.fontName = "BigShouldersStencilDisplay-Bold"
        bankLabel.fontSize = 24
        bankLabel.position = CGPoint(x: size.width * 0.85, y: size.height * 0.58)
        addChild(bankLabel)
        
        finishButton = CustomButton(text: "FINISH",
                                    position: CGPoint(x: size.width * 0.88, y: size.height * 0.2),
                                    backgroundImage: "middleButtonBG")
        finishButton.isHidden = true
        addChild(finishButton)
        
        let coefficientValues = ["X 0.50", "X 0.75", "X 1.00", "X 1.50"]
        let coefficientPositions: [CGPoint] = [
            CGPoint(x: size.width / 4, y: size.height * 0.15),
            CGPoint(x: size.width / 4, y: size.height * 0.35),
            CGPoint(x: size.width / 4, y: size.height * 0.55),
            CGPoint(x: size.width / 4, y: size.height * 0.75)
        ]
        
        for (index, value) in coefficientValues.enumerated() {
            let label = SKLabelNode(text: value)
            label.position = coefficientPositions[index]
            label.fontName = "BigShouldersStencilDisplay-Bold"
            label.fontSize = 28
            coefficientLabels.append(label)
            addChild(label)
        }
        
        gameSlotsBGImage = SKSpriteNode(imageNamed: "slotsBG")
        gameSlotsBGImage.size = CGSize(width: 330, height: 330)
        gameSlotsBGImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(gameSlotsBGImage)
        
        winLabel = CustomText(text: "YOU WIN!",
                              position: CGPoint(x: size.width / 2, y: size.height * 0.8),
                              backgroundWidth: 400)
        winLabel.isHidden = true
        winLabel.zPosition = 4
        addChild(winLabel)
        
        winCountLabel = SKLabelNode(text: "\((Double(selectedBet!) ?? 100.0) / 2)")
        winCountLabel.fontName = "BigShouldersStencilDisplay-Bold"
        winCountLabel.fontSize = 36
        winCountLabel.fontColor = .white
        winCountLabel.zPosition = 4
        winCountLabel.isHidden = true
        winCountLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(winCountLabel)
        
        loseLabel = CustomText(text: "YOU LOSE!",
                              position: CGPoint(x: size.width / 2, y: size.height / 2),
                              backgroundWidth: 400)
        loseLabel.isHidden = true
        loseLabel.zPosition = 4
        addChild(loseLabel)
        
        goToMenuButton = CustomButton(text: "GO TO MENU",
                                      position: CGPoint(x: size.width / 2, y: size.height * 0.2),
                                      backgroundImage: "bigButtonBG")
        goToMenuButton.isHidden = true
        goToMenuButton.zPosition = 4
        addChild(goToMenuButton)
        
        resultBGImage = SKSpriteNode(color: .black, size: self.size)
        resultBGImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        resultBGImage.zPosition = 3
        resultBGImage.alpha = 0.7
        resultBGImage.isHidden = true
        addChild(resultBGImage)
    }
    
    private func setupSlots() {
        let rows = 4
        let columns = 4
        let slotSize = CGSize(width: 70, height: 70)
        let spacing: CGFloat = 10
        
        let gridWidth = CGFloat(columns) * (slotSize.width + spacing) - spacing
        let gridHeight = CGFloat(rows) * (slotSize.height + spacing) - spacing
        
        let startX = (size.width - gridWidth) / 2
        let startY = (size.height - gridHeight) / 2
        
        for row in 0..<rows {
            var slotRow: [GameSlotConstructor] = []
            for column in 0..<columns {
                let slotPosition = CGPoint(
                    x: startX + CGFloat(column) * (slotSize.width + spacing) + slotSize.width / 2,
                    y: startY + CGFloat(row) * (slotSize.height + spacing) + slotSize.height / 2
                )
                
                let slotType: SlotType
                if row == 0 {
                    slotType = Bool.random() ? .chest : .sword
                } else {
                    slotType = .lock
                }
                
                let slot = GameSlotConstructor(type: slotType)
                slot.position = slotPosition
                addChild(slot)
                
                if row == 0 { slot.hideIcon() }
                slotRow.append(slot)
            }
            gameSlots.append(slotRow)
        }
    }
    
    private func revealRow(_ rowIndex: Int) {
        guard rowIndex < gameSlots.count else { return }
        
        for slot in gameSlots[rowIndex] {
            let randomType: SlotType = Bool.random() ? .chest : .sword
            slot.setType(randomType)
            slot.hideIcon()
        }
    }
    
    private func handleSlotSelection(_ selectedSlot: GameSlotConstructor) {
        if !isSlotSelected {
            isSlotSelected = true
            for (rowIndex, row) in gameSlots.enumerated() {
                for slot in row {
                    if rowIndex == 0 {
                        if slot == selectedSlot {
                            slot.alpha = 1
                            slot.isUserInteractionEnabled = true
                        } else {
                            slot.alpha = 0.5
                            slot.isUserInteractionEnabled = false
                        }
                    } else {
                        slot.isUserInteractionEnabled = false
                    }
                    
                    slot.showIcon()
                }
            }
            
            switch selectedSlot.getSlotType() {
            case .chest:
                revealRow(1)
                rowsRevealed = 1
                finishButton.isHidden = false
                AudioManager.shared.playSoundEffect(named: "winSound.wav")
            case .sword:
                loseLabel.isHidden = false
                goToMenuButton.isHidden = false
                resultBGImage.isHidden = false
                AudioManager.shared.playVibration()
                AudioManager.shared.playSoundEffect(named: "failureSound.wav")
            case .lock:
                break
            }
        } else {
            let currentRowIndex = gameSlots.firstIndex(where: { $0.contains(selectedSlot) })!
            
            for (rowIndex, row) in gameSlots.enumerated() {
                for slot in row {
                    if rowIndex == currentRowIndex {
                        if slot == selectedSlot {
                            slot.alpha = 1
                            slot.isUserInteractionEnabled = true
                        } else {
                            slot.alpha = 0.5
                            slot.isUserInteractionEnabled = false
                        }
                    } else {
                        slot.isUserInteractionEnabled = false
                    }
                    
                    slot.showIcon()
                }
            }
            
            switch selectedSlot.getSlotType() {
            case .chest:
                if currentRowIndex == 1 {
                    revealRow(2)
                    rowsRevealed = 2
                } else if currentRowIndex == 2 {
                    revealRow(3)
                    rowsRevealed = 3
                } else if currentRowIndex == 3 {
                    winLabel.isHidden = false
                    resultBGImage.isHidden = false
                    goToMenuButton.isHidden = false
                    winCountLabel.isHidden = false
                    rowsRevealed = 4
                }
                updateWinCountLabel()
                AudioManager.shared.playSoundEffect(named: "winSound.wav")
                finishButton.isHidden = false
            case .sword:
                loseLabel.isHidden = false
                goToMenuButton.isHidden = false
                resultBGImage.isHidden = false
                AudioManager.shared.playVibration()
                AudioManager.shared.playSoundEffect(named: "failureSound.wav")
            case .lock:
                break
            }
        }
    }
    
    private func updateWinCountLabel() {
        guard let bet = Double(selectedBet ?? "0") else { return }
        let coefficient: Double
        
        switch rowsRevealed {
        case 1:
            coefficient = 0.50
        case 2:
            coefficient = 0.75
        case 3:
            coefficient = 1.00
        case 4:
            coefficient = 1.50
        default:
            coefficient = 0.00
        }
        
        let winAmount = bet * coefficient
        winCountLabel.text = String(format: "%.2f", winAmount)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        AudioManager.shared.playSoundEffect(named: "clickSound.wav")
        
        if closeButton.contains(location) || goToMenuButton.contains(location) {
            let transition = SKTransition.fade(withDuration: 1.0)
            let menuScene = MenuScene(size: self.size)
            view?.presentScene(menuScene, transition: transition)
            return
        }
        
        if finishButton.contains(location) {
            winLabel.isHidden = false
            resultBGImage.isHidden = false
            goToMenuButton.isHidden = false
            winCountLabel.isHidden = false
        }
        
        for (rowIndex, row) in gameSlots.enumerated() {
            for slot in row {
                if slot.contains(location) {
                    if rowIndex == 0 && !isSlotSelected {
                        handleSlotSelection(slot)
                    } else if rowIndex > 0 && isSlotSelected {
                        handleSlotSelection(slot)
                    }
                    return
                }
            }
        }
    }
}
