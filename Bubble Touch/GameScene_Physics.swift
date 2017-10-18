
import SpriteKit
import Foundation

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == bubbleGroup && contact.bodyB.categoryBitMask == wallsGroup) ||
            (contact.bodyA.categoryBitMask == wallsGroup && contact.bodyB.categoryBitMask == bubbleGroup) {
            let bubbleNode = contact.bodyA.categoryBitMask == bubbleGroup ? contact.bodyA.node : contact.bodyB.node
            bubbleNode?.removeFromParent()
            run(bells)
        }
        
//        if (contact.bodyA.categoryBitMask == surpriseGroup && contact.bodyB.categoryBitMask == wallsGroup) ||
//            (contact.bodyA.categoryBitMask == wallsGroup && contact.bodyB.categoryBitMask == surpriseGroup) {
//            let surpriseNode = contact.bodyA.categoryBitMask == surpriseGroup ? contact.bodyA.node as! SurpriseNode : contact.bodyB.node as! SurpriseNode
//            surpriseNode.changeDirection()
//            run(bells)
//        }
    }
}
