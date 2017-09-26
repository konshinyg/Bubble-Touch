
import Foundation
import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            for currentBubble in bubbleObject.children {
                viewTouchLocation = touch.location(in: bubbleObject)
                if currentBubble.contains(viewTouchLocation) {
                    let takeSound = arc4random() % 42
                    run(SoundBase.sharedInstance().soundsArray[Int(takeSound)])
                    if currentBubble.name == "red" || currentBubble.name == "yellow" {
                        score -= 20
                    } else {
                        score += 10
                    }
                    currentBubble.removeFromParent()
                    gameViewControllerBridge.scoreLabel.text = "\(score)"
                }
            }
        }
    }
}
