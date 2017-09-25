
import Foundation
import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            for currentBubble in bubbleObject.children {
                viewTouchLocation = touch.location(in: bubbleObject)
                if currentBubble.contains(viewTouchLocation) {
                    let takeSound = arc4random() % 10
                    run(soundsArray[Int(takeSound)])
                    currentBubble.removeFromParent()
                }
            }
        }
    }
}
