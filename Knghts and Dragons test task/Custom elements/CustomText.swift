import SpriteKit

class CustomText: SKNode {
    
    private var background: SKSpriteNode!
    private var labelNode: SKLabelNode!
    
    init(text: String, position: CGPoint, backgroundWidth: CGFloat) {
        super.init()
        
        labelNode = SKLabelNode(text: text)
        labelNode.fontName = "BigShouldersStencilDisplay-Bold"
        labelNode.fontSize = 36
        labelNode.numberOfLines = 0
        labelNode.fontColor = .white
        labelNode.zPosition = 2
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        
        let labelHeight = labelNode.frame.height
        let backgroundSize = CGSize(width: backgroundWidth, height: labelHeight + 20)
        
        background = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.25), size: backgroundSize)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = 1
        addChild(background)
        
        labelNode.position = CGPoint(x: 0, y: 0)
        addChild(labelNode)
        
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
