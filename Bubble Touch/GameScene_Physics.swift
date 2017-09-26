
import SpriteKit
import Foundation

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == wallsGroup || contact.bodyB.categoryBitMask == wallsGroup {
//            let bubbleNode = contact.bodyA.categoryBitMask == bubbleGroup ? contact.bodyA.node : contact.bodyB.node
//            bubbleNode?.removeFromParent()
            run(bells)
        }
    }
}
