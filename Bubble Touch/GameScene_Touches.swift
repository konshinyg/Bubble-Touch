
import Foundation
import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            for currenBlueBall in blueBallObject.children {
                blueBallTouchLocation = touch.location(in: blueBallObject)
                if currenBlueBall.contains(blueBallTouchLocation) {
                    run(SoundBase.sharedInstance.blueBallTouchSound)
                    score += 50
                    burstTextureArray = [SKTexture(imageNamed: "blueBallBurst1.png"), SKTexture(imageNamed: "blueBallBurst2.png"), SKTexture(imageNamed: "blueBallBurst3.png"), SKTexture(imageNamed: "blueBallBurst4.png")]
                    let blueBallAnimation = SKAction.animate(with: burstTextureArray, timePerFrame: 0.05)
                    let blueBallRepeater = SKAction.repeatForever(blueBallAnimation)
                    currenBlueBall.run(blueBallRepeater)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                        currenBlueBall.removeFromParent()
                    })
                    gameViewControllerBridge.scoreLabel.text = "\(score)"
                }
            }
            
            for currentBomb in bombObject.children {
                bombTouchLocation = touch.location(in: bombObject)
                if currentBomb.contains(bombTouchLocation) {
                    run(SoundBase.sharedInstance.bombTouchSound)
                    score -= 50
                    burstTextureArray = [SKTexture(imageNamed: "bombBurst1.png"), SKTexture(imageNamed: "bombBurst2.png"), SKTexture(imageNamed: "bombBurst3.png"), SKTexture(imageNamed: "bombBurst4.png"), SKTexture(imageNamed: "bombBurst5.png")]
                    let bombBurstAnimation = SKAction.animate(with: burstTextureArray, timePerFrame: 0.05)
                    let bombBurstRepeater = SKAction.repeatForever(bombBurstAnimation)
                    currentBomb.run(bombBurstRepeater)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                        currentBomb.removeFromParent()
                    })
                    gameViewControllerBridge.scoreLabel.text = "\(score)"
                }
            }
            
            for currentBubble in bubbleObject.children {
                bubbleTouchLocation = touch.location(in: bubbleObject)
                if currentBubble.contains(bubbleTouchLocation) {
                    let takeSound = arc4random() % 46
                    run(SoundBase.sharedInstance.soundsArray[Int(takeSound)])
                    if currentBubble.name == "blue" {
                        burstTextureArray = [SKTexture(imageNamed: "blueBubbleBurst1.png"), SKTexture(imageNamed: "blueBubbleBurst2.png"), SKTexture(imageNamed: "blueBubbleBurst3.png"), SKTexture(imageNamed: "blueBubbleBurst4.png"), SKTexture(imageNamed: "blueBubbleBurst5.png"), SKTexture(imageNamed: "blueBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "cian" {
                        burstTextureArray = [SKTexture(imageNamed: "cianBubbleBurst1.png"), SKTexture(imageNamed: "cianBubbleBurst2.png"), SKTexture(imageNamed: "cianBubbleBurst3.png"), SKTexture(imageNamed: "cianBubbleBurst4.png"), SKTexture(imageNamed: "cianBubbleBurst5.png"), SKTexture(imageNamed: "cianBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "green" {
                        burstTextureArray = [SKTexture(imageNamed: "greenBubbleBurst1.png"), SKTexture(imageNamed: "greenBubbleBurst2.png"), SKTexture(imageNamed: "greenBubbleBurst3.png"), SKTexture(imageNamed: "greenBubbleBurst4.png"), SKTexture(imageNamed: "greenBubbleBurst5.png"), SKTexture(imageNamed: "greenBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "pink" {
                        burstTextureArray = [SKTexture(imageNamed: "pinkBubbleBurst1.png"), SKTexture(imageNamed: "pinkBubbleBurst2.png"), SKTexture(imageNamed: "pinkBubbleBurst3.png"), SKTexture(imageNamed: "pinkBubbleBurst4.png"), SKTexture(imageNamed: "pinkBubbleBurst5.png"), SKTexture(imageNamed: "pinkBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "purple" {
                        burstTextureArray = [SKTexture(imageNamed: "purpleBubbleBurst1.png"), SKTexture(imageNamed: "purpleBubbleBurst2.png"), SKTexture(imageNamed: "purpleBubbleBurst3.png"), SKTexture(imageNamed: "purpleBubbleBurst4.png"), SKTexture(imageNamed: "purpleBubbleBurst5.png"), SKTexture(imageNamed: "purpleBubbleBurst6.png")]
                        score += 10
                    } else if currentBubble.name == "red" {
                        burstTextureArray = [SKTexture(imageNamed: "redBubbleBurst1.png"), SKTexture(imageNamed: "redBubbleBurst2.png"), SKTexture(imageNamed: "redBubbleBurst3.png"), SKTexture(imageNamed: "redBubbleBurst4.png"), SKTexture(imageNamed: "redBubbleBurst5.png"), SKTexture(imageNamed: "redBubbleBurst6.png")]
                        score -= 20
                    } else if currentBubble.name == "yellow" {
                        burstTextureArray = [SKTexture(imageNamed: "yellowBubbleBurst1.png"), SKTexture(imageNamed: "yellowBubbleBurst2.png"), SKTexture(imageNamed: "yellowBubbleBurst3.png"), SKTexture(imageNamed: "yellowBubbleBurst4.png"), SKTexture(imageNamed: "yellowBubbleBurst5.png"), SKTexture(imageNamed: "yellowBubbleBurst6.png")]
                        score -= 20
                    }
                    let bubbleBurstAnimation = SKAction.animate(with: burstTextureArray, timePerFrame: 0.05)
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
