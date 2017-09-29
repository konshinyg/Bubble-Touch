
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
                    if currentBubble.name == "blue" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "blueBubbleBurst1.png"), SKTexture(imageNamed: "blueBubbleBurst2.png"), SKTexture(imageNamed: "blueBubbleBurst3.png"), SKTexture(imageNamed: "blueBubbleBurst4.png"), SKTexture(imageNamed: "blueBubbleBurst5.png"), SKTexture(imageNamed: "blueBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "cian" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "cianBubbleBurst1.png"), SKTexture(imageNamed: "cianBubbleBurst2.png"), SKTexture(imageNamed: "cianBubbleBurst3.png"), SKTexture(imageNamed: "cianBubbleBurst4.png"), SKTexture(imageNamed: "cianBubbleBurst5.png"), SKTexture(imageNamed: "cianBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "green" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "greenBubbleBurst1.png"), SKTexture(imageNamed: "greenBubbleBurst2.png"), SKTexture(imageNamed: "greenBubbleBurst3.png"), SKTexture(imageNamed: "greenBubbleBurst4.png"), SKTexture(imageNamed: "greenBubbleBurst5.png"), SKTexture(imageNamed: "greenBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "pink" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "pinkBubbleBurst1.png"), SKTexture(imageNamed: "pinkBubbleBurst2.png"), SKTexture(imageNamed: "pinkBubbleBurst3.png"), SKTexture(imageNamed: "pinkBubbleBurst4.png"), SKTexture(imageNamed: "pinkBubbleBurst5.png"), SKTexture(imageNamed: "pinkBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "purple" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "purpleBubbleBurst1.png"), SKTexture(imageNamed: "purpleBubbleBurst2.png"), SKTexture(imageNamed: "purpleBubbleBurst3.png"), SKTexture(imageNamed: "purpleBubbleBurst4.png"), SKTexture(imageNamed: "purpleBubbleBurst5.png"), SKTexture(imageNamed: "purpleBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "red" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "redBubbleBurst1.png"), SKTexture(imageNamed: "redBubbleBurst2.png"), SKTexture(imageNamed: "redBubbleBurst3.png"), SKTexture(imageNamed: "redBubbleBurst4.png"), SKTexture(imageNamed: "redBubbleBurst5.png"), SKTexture(imageNamed: "redBubbleBurst6.png")]
                        score -= 20
                    } else if currentBubble.name == "yellow" {
                        bubbleBurstTextureArray = [SKTexture(imageNamed: "yellowBubbleBurst1.png"), SKTexture(imageNamed: "yellowBubbleBurst2.png"), SKTexture(imageNamed: "yellowBubbleBurst3.png"), SKTexture(imageNamed: "yellowBubbleBurst4.png"), SKTexture(imageNamed: "yellowBubbleBurst5.png"), SKTexture(imageNamed: "yellowBubbleBurst6.png")]
                        score -= 20
                    }
                    let bubbleBurstAnimation = SKAction.animate(with: bubbleBurstTextureArray, timePerFrame: 0.05)
                    let bubbleBurstRepeater = SKAction.repeatForever(bubbleBurstAnimation)
                    currentBubble.run(bubbleBurstRepeater)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                        currentBubble.removeFromParent()
                    })
                    gameViewControllerBridge.scoreLabel.text = "\(score)"
                }
            }
        }
    }
}
