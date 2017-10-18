//
//  BubbleNode.swift
//  Bubble Touch
//
//  Created by Core on 01.10.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import Foundation
import SpriteKit

class SurpriseNode: SKSpriteNode {
    
    var direction: Int32 = 1
    
    func changeDirection() {
        direction = -direction
    }
    
    func nodeMovement(duration: UInt32, frameHeight: CGFloat) -> SKAction {
        var movementChoosing = Int32(arc4random() % UInt32(frameHeight * 1.4))
        if arc4random() % 2 == 0 { movementChoosing = -movementChoosing }
        
        let move = SKAction.moveBy(x: CGFloat(movementChoosing * direction), y: frameHeight * 1.5, duration: TimeInterval(duration))
        let remove = SKAction.removeFromParent()
        let moveRepeater = SKAction.repeatForever(SKAction.sequence([move, remove]))
        return moveRepeater
    }
}
