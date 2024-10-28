import SpriteKit

class CustomButton: SKSpriteNode {
    
    private var labelNode: SKLabelNode?
    private var imageNode: SKSpriteNode?
    
    var fontSize: CGFloat
    
    init(text: String? = nil, image: String? = nil, position: CGPoint, backgroundImage: String, fontSize: CGFloat = 20) {
        let texture = SKTexture(imageNamed: backgroundImage)
        let buttonSize = texture.size()
        
        self.fontSize = fontSize
        super.init(texture: texture, color: .clear, size: buttonSize)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if let text = text {
            setupText(text)
        } else if let image = image {
            setupImage(image)
        }
        
        self.position = position
    }
    
    private func setupText(_ text: String) {
        labelNode = SKLabelNode(text: text)
        labelNode?.fontName = "BigShouldersStencilDisplay-Bold"
        labelNode?.fontSize = fontSize
        labelNode?.fontColor = .white
        labelNode?.zPosition = 1
        labelNode?.position = CGPoint(x: 0, y: -8)
        if let labelNode = labelNode {
            addChild(labelNode)
        }
    }
    
    private func setupImage(_ imageName: String) {
        imageNode = SKSpriteNode(imageNamed: imageName)
        imageNode?.zPosition = 1
        imageNode?.position = CGPoint(x: 0, y: 0)
        if let imageNode = imageNode {
            addChild(imageNode)
        }
    }
    
    func getText() -> String? {
        return labelNode?.text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
