import SpriteKit

class BankBalance: SKNode {
    
    private var balanceLabel: SKLabelNode!
    private var backgroundImage: SKSpriteNode!
    private var iconImage: SKSpriteNode!
    
    override init() {
        super.init()

        backgroundImage = SKSpriteNode(imageNamed: "bankCountBG")
        backgroundImage.zPosition = 1
        addChild(backgroundImage)
        
        iconImage = SKSpriteNode(imageNamed: "coinIcon")
        iconImage.size = CGSize(width: 40, height: 40)
        iconImage.position = CGPoint(x: -backgroundImage.size.width / 2 + 10, y: 0)
        iconImage.zPosition = 2
        addChild(iconImage)
        
        balanceLabel = SKLabelNode(fontNamed: "BigShouldersStencilDisplay-Bold")
        balanceLabel.fontSize = 16
        balanceLabel.fontColor = .white
        balanceLabel.position = CGPoint(x: -backgroundImage.size.width / 5, y: -8)
        balanceLabel.zPosition = 2
        updateBalance()
        addChild(balanceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateBalance() {
        balanceLabel.text = "\(GameData.shared.balance)"
    }
    
    func setBalance(newBalance: Int) {
        GameData.shared.balance = newBalance
        updateBalance()
    }
}
