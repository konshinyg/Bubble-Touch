//
//  GameScene.swift
//  Bubble Touch
//
//  Created by Core on 22.09.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewTouchLocation = CGPoint()
    
    // Sprites
    var bg = SKSpriteNode()
    var bubble = SKSpriteNode()
    
    // Textures
    var bgTexture: SKTexture!
    var bubbleTexture: SKTexture!
    
    // Objects
    var bgObject = SKNode()
    var bubbleObject = SKNode()
    var wallsObject = SKNode()
    
    // Timers
    var bubbleTimer = Timer()
    
    // Bit masks
    var bubbleGroup: UInt32 = 0x1 << 1
    var wallsGroup: UInt32 = 0x1 << 2
    
    // Sounds
    var bubbleTouchSound1 = SKAction()
    var bubbleTouchSound2 = SKAction()
    var bubbleTouchSound3 = SKAction()
    var bubbleTouchSound4 = SKAction()
    var bubbleTouchSound5 = SKAction()
    var bubbleTouchSound6 = SKAction()
    var bubbleTouchSound7 = SKAction()
    var bubbleTouchSound8 = SKAction()
    var bubbleTouchSound9 = SKAction()
    var bubbleTouchSound0 = SKAction()
    var soundsArray = [SKAction]()
    
    override func didMove(to view: SKView) {
        createObjects()
        self.physicsWorld.contactDelegate = self
        createGame()
        
        bubbleTouchSound1 = SKAction.playSoundFileNamed("burp1", waitForCompletion: false)
        bubbleTouchSound2 = SKAction.playSoundFileNamed("burp2", waitForCompletion: false)
        bubbleTouchSound3 = SKAction.playSoundFileNamed("burp3", waitForCompletion: false)
        bubbleTouchSound4 = SKAction.playSoundFileNamed("pu1", waitForCompletion: false)
        bubbleTouchSound5 = SKAction.playSoundFileNamed("pu2", waitForCompletion: false)
        bubbleTouchSound6 = SKAction.playSoundFileNamed("pu3", waitForCompletion: false)
        bubbleTouchSound7 = SKAction.playSoundFileNamed("pu4", waitForCompletion: false)
        bubbleTouchSound8 = SKAction.playSoundFileNamed("pu5", waitForCompletion: false)
        bubbleTouchSound9 = SKAction.playSoundFileNamed("pu6", waitForCompletion: false)
        bubbleTouchSound0 = SKAction.playSoundFileNamed("pu7", waitForCompletion: false)
        
        soundsArray = [bubbleTouchSound1, bubbleTouchSound2, bubbleTouchSound3, bubbleTouchSound4, bubbleTouchSound5, bubbleTouchSound6, bubbleTouchSound7, bubbleTouchSound8, bubbleTouchSound9, bubbleTouchSound0]
    }
    
    func createObjects() {
        self.addChild(bgObject)
        self.addChild(bubbleObject)
        self.addChild(wallsObject)
    }
    
    func createGame() {
        createBackground()
        createBubble()
        createWalls()
        timersFunc()
    }
    
    func timersFunc() {
        bubbleTimer.invalidate()
        bubbleTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(createBubble), userInfo: nil, repeats: true)
    }
    
    func createBackground() {
        bgTexture = SKTexture(imageNamed: "backboard.jpg")
        
        let moveBg = SKAction.moveBy(x: 0, y: -bgTexture.size().height, duration: 30)
        let replaceBg = SKAction.moveBy(x: 0, y: bgTexture.size().height, duration: 0)
        let moveBgForever = SKAction.repeatForever(SKAction.sequence([moveBg, replaceBg]))
        
        for i in 0..<3 {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: size.width/2, y: size.height/4 + bgTexture.size().height * CGFloat(i))
            bg.run(moveBgForever)
            bg.zPosition = -1
            bgObject.addChild(bg)
        }
    }
    
    func createWalls() {
        let wall_left = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 10, height: 667))
        wall_left.strokeColor = SKColor.white
        wall_left.fillColor = SKColor.black
        wall_left.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall_left.frame.size.width, height: wall_left.frame.size.height), center: CGPoint(x: 5, y: 333))
        wall_left.physicsBody?.isDynamic = false
        wall_left.physicsBody?.categoryBitMask = wallsGroup
        wallsObject.addChild(wall_left)

        let wall_right = SKShapeNode(rect: CGRect(x: 365, y: 0, width: 10, height: 667))
        wall_right.strokeColor = SKColor.white
        wall_right.fillColor = SKColor.black
        wall_right.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall_right.frame.size.width, height: wall_right.frame.size.height), center: CGPoint(x: 370, y: 333))
        wall_right.physicsBody?.categoryBitMask = wallsGroup
        wall_right.physicsBody?.isDynamic = false
        wallsObject.addChild(wall_right)
        
    }
    
    func createBubble() {
        // color choosing
        let bubbleTextureArray = ["bubble_blue.png", "bubble_gray.png", "bubble_green.png", "bubble_purple.png", "bubble_red.png", "bubble_yellow.png"]
        let bubbleColorChoosing = arc4random() % 6
        let bubbleImage = String(describing: bubbleTextureArray[Int(bubbleColorChoosing)])
        bubbleTexture = SKTexture(imageNamed: bubbleImage)
        bubble = SKSpriteNode(texture: bubbleTexture)
        
        // size & position choosing
        let sizeRand = CGFloat(UInt32(50) + arc4random() % 25)
        bubble.size.width = sizeRand
        bubble.size.height = sizeRand
        let bubblePositionChoosing = arc4random() % 275
        let bubbleCenter = CGPoint(x: 50 + CGFloat(bubblePositionChoosing), y: -self.frame.size.height/6)
        bubble.position = bubbleCenter
        
        // physics
        bubble.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bubble.size.width, height: bubble.size.height))
        bubble.physicsBody?.categoryBitMask = bubbleGroup
        bubble.physicsBody?.contactTestBitMask = wallsGroup
        bubble.physicsBody?.isDynamic = true
        bubble.physicsBody?.affectedByGravity = false
        bubble.physicsBody?.allowsRotation = true
        
        // movement choosing
        let bubbleDirectionChoosing = arc4random() % 2
        var bubbleMovementChoosing = Int32(arc4random() % 275)
        if bubbleDirectionChoosing == 0 { bubbleMovementChoosing *= -1 }
        let bubbleDuration = (arc4random() % 3) + 5
        let moveBubble = SKAction.moveBy(x: CGFloat(bubbleMovementChoosing), y: self.frame.size.height + self.frame.size.height/2, duration: TimeInterval(bubbleDuration))
        let removeBubble = SKAction.removeFromParent()
        let moveBubbleRepeater = SKAction.repeatForever(SKAction.sequence([moveBubble, removeBubble]))
        bubble.run(moveBubbleRepeater)
                
        bubbleObject.addChild(bubble)        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
