import SpriteKit

class EasyBackground: SKSpriteNode {
    
    init(imageName: String, size: CGSize) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: .clear, size: size)
        
        self.position = CGPoint(x: size.width / 2, y: size.height / 2)
        self.zPosition = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
