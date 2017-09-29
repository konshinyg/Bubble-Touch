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
    var score = 0
    var gameViewControllerBridge: GameViewController!
    var sec = 60
    
    // Sprites
    var bg = SKSpriteNode()
    var bubble = SKSpriteNode()
    var wall_left = SKSpriteNode()
    var wall_right = SKSpriteNode()
    
    // Textures
    var bgTexture: SKTexture!
    var bubbleTexture: SKTexture!
    var wallTexture: SKTexture!
    var bubbleBurstTextureArray = [SKTexture]()
    
    // Objects
    var bgObject = SKNode()
    var bubbleObject = SKNode()
    var wallsObject = SKNode()
    
    // Timers
    var bubbleTimer = Timer()
    var gameTimer = Timer()
    var gameTimerUpdater = Timer()
    
    // Bit masks
    var bubbleGroup: UInt32 = 0x1 << 1
    var wallsGroup: UInt32 = 0x1 << 2
    
    // Sounds
    var bells = SKAction.playSoundFileNamed("bells.wav", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        createObjects()
        self.physicsWorld.contactDelegate = self
        createGame()
        if SoundBase.sharedInstance.isPlaying {
            SoundBase.sharedInstance.pauseBackground()
        }
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
    
    func stopGame() {
        bubbleTimer.invalidate()
        gameTimer.invalidate()
        gameTimerUpdater.invalidate()
        
        self.removeAllActions()
        self.removeAllChildren()
        SoundBase.sharedInstance.isPlaying = false
        gameViewControllerBridge.endGame()
    }
    
    func gameTimerUpdate() {
        sec -= 1
        let s = String(format: "00:%02d", sec)
        gameViewControllerBridge.gameTimer.text = "\(s)"
    }
    
    func timersFunc() {
        bubbleTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(createBubble), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 61, target: self, selector: #selector(stopGame), userInfo: nil, repeats: false)
        gameTimerUpdater = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimerUpdate), userInfo: nil, repeats: true)
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
        wallTexture = SKTexture(imageNamed: "panels@2x.png")
        wall_left = SKSpriteNode(texture: wallTexture)
        wall_left.size.width = (view?.frame.size.width)!/10
        wall_left.size.height = (view?.frame.size.height)!
        wall_left.position = CGPoint(x: 0, y: (view?.frame.size.height)!/2)
        wall_left.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall_left.size.width, height: wall_left.size.height))
        wall_left.physicsBody?.isDynamic = false
        wall_left.physicsBody?.categoryBitMask = wallsGroup
        wallsObject.addChild(wall_left)
        
        wall_right = SKSpriteNode(texture: wallTexture)
        wall_right.size.width = (view?.frame.size.width)!/10
        wall_right.size.height = (view?.frame.size.height)!
        wall_right.position = CGPoint(x: (view?.frame.size.width)!, y: (view?.frame.size.height)!/2)
        wall_right.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall_right.size.width, height: wall_right.size.height))
        wall_right.physicsBody?.categoryBitMask = wallsGroup
        wall_right.physicsBody?.isDynamic = false
        wallsObject.addChild(wall_right)
    }
    
    func createBubble() {
        // color choosing
        let bubbleSuperTextureArray = ["bubble_super_red.png", "bubble_super_yellow.png", "bubble_super_green.png", "bubble_super_purple.png", "bubble_super_cian.png", "bubble_super_blue.png", "bubble_super_pink.png", "bubble_super_red.png", "bubble_super_yellow.png"]
        let bubbleColorChoosing = arc4random() % 9
        let bubbleImage = String(describing: bubbleSuperTextureArray[Int(bubbleColorChoosing)])
        bubbleTexture = SKTexture(imageNamed: bubbleImage)
        bubble = SKSpriteNode(texture: bubbleTexture)
        switch bubbleColorChoosing {
        case 0 : bubble.name = "red"
        case 1 : bubble.name = "yellow"
        case 2 : bubble.name = "green"
        case 3 : bubble.name = "purple"
        case 4 : bubble.name = "cian"
        case 5 : bubble.name = "blue"
        case 6 : bubble.name = "pink"
        case 7 : bubble.name = "red"
        case 8 : bubble.name = "yellow"
        default : break
        }
        
        // size & position choosing
        let sizeRand = CGFloat(UInt32(50) + arc4random() % 25)
        bubble.size.width = sizeRand
        bubble.size.height = sizeRand
        let bubblePositionChoosing = arc4random() % 275
        bubble.position = CGPoint(x: sizeRand/2 + CGFloat(bubblePositionChoosing), y: -self.frame.size.height/6)
        
        // physics
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: sizeRand/2)
        bubble.physicsBody?.categoryBitMask = bubbleGroup
        bubble.physicsBody?.contactTestBitMask = wallsGroup
        bubble.physicsBody?.collisionBitMask = wallsGroup
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
