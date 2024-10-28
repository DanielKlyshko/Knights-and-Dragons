import SpriteKit

enum SlotType {
    case chest
    case sword
    case lock
}

class GameSlotConstructor: SKSpriteNode {
    private var slotType: SlotType
    private var slotImage: SKSpriteNode
    
    init(type: SlotType) {
        self.slotType = type

        let backgroundImage = SKSpriteNode(imageNamed: "slotBGImage")
        backgroundImage.size = CGSize(width: 70, height: 70)
        backgroundImage.zPosition = -1
        
        slotImage = SKSpriteNode()
        
        super.init(texture: nil, color: .clear, size: CGSize(width: 70, height: 70))

        addChild(backgroundImage)
        
        updateSlotImage()
        addChild(slotImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSlotType() -> SlotType {
        return slotType
    }
    
    func hideIcon() {
        slotImage.isHidden = true
    }
    
    func showIcon() {
        slotImage.isHidden = false
    }
    
    func setType(_ type: SlotType) {
        self.slotType = type
        updateSlotImage()
    }
    
    private func updateSlotImage() {
        slotImage.texture = SKTexture(imageNamed: slotImageName(for: slotType))
        slotImage.size = CGSize(width: 60, height: 60)
        slotImage.position = CGPoint(x: 0, y: 0)
    }
    
    private func slotImageName(for type: SlotType) -> String {
        switch type {
        case .chest:
            return "lootboxIcon"
        case .sword:
            return "swordIcon"
        case .lock:
            return "lockIcon"
        }
    }
}
