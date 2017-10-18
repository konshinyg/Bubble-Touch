//
//  GameScene.swift
//  Bubble Touch
//
//  Created by Core on 22.09.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bubbleTouchLocation = CGPoint()
    var blueBallTouchLocation = CGPoint()
    var bombTouchLocation = CGPoint()
    var score = 0
    var gameViewControllerBridge: GameViewController!
    var sec = 60
    
    // Sprites
    var bg = SKSpriteNode()
    var bubble = SKSpriteNode()
    var wall_left = SKSpriteNode()
    var wall_right = SKSpriteNode()
    var blueBall = SKSpriteNode()
    var bomb = SKSpriteNode()
    
    // Textures
    var bgTexture: SKTexture!
    var bubbleTexture: SKTexture!
    var wallTexture: SKTexture!
    var burstTextureArray = [SKTexture]()
    var bombTextureArray = [SKTexture]()
    var blueBallTexture: SKTexture!
    
    // Objects
    var bgObject = SKNode()
    var bubbleObject = SKNode()
    var blueBallObject = SKNode()
    var bombObject = SKNode()
    var wallsObject = SKNode()
    
    // Timers
    var bubbleTimer = Timer()
    var surpriseTimer = Timer()
    var gameTimer = Timer()
    var gameTimerUpdater = Timer()
    
    
    // Bit masks
    var bubbleGroup: UInt32 = 0x1 << 1
    var wallsGroup: UInt32 = 0x1 << 2
    var surpriseGroup: UInt32 = 0x1 << 3
    
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
        self.addChild(blueBallObject)
        self.addChild(bombObject)
    }
    
    func createGame() {
        createBackground()
        createBubble()
        createWalls()
        timersFunc()
    }
    
    func stopGame() {
        bubbleTimer.invalidate()
        surpriseTimer.invalidate()
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
        surpriseTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(createSurprise), userInfo: nil, repeats: true)
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
        let sizeRand = CGFloat(UInt32(self.frame.size.width/7.5) + arc4random() % UInt32(self.frame.size.width/15))
        bubble.size.width = sizeRand
        bubble.size.height = sizeRand
        let bubblePositionChoosing = arc4random() % UInt32(self.frame.size.width * 0.7)
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
        var movement = Int32(arc4random() % UInt32(self.frame.size.height * 0.4))
        if arc4random() % 2 == 0 { movement = -movement }
        let bubbleDuration = (arc4random() % 3) + 5
        let move = SKAction.moveBy(x: CGFloat(movement), y: self.frame.size.height * 1.5, duration: TimeInterval(bubbleDuration))
        let remove = SKAction.removeFromParent()
        let moveBubbleRepeater = SKAction.repeatForever(SKAction.sequence([move, remove]))
        bubble.run(moveBubbleRepeater)
        
        bubbleObject.addChild(bubble)
    }
    
    func createSurprise() {
        let surprise = arc4random() % 2
        if surprise == 0 {
            createBlueBall()
        } else {
            createBomb()
        }
    }
    
    func createBlueBall() {
        blueBallTexture = SKTexture(imageNamed: "blueBall.png")
        blueBall = SurpriseNode(texture: blueBallTexture)
        
        // sizing & position
        let sizeRand = CGFloat(self.frame.size.width/7.5)
        blueBall.size.width = sizeRand
        blueBall.size.height = sizeRand
        let blueBallPositionChoosing = arc4random() % UInt32(self.frame.size.width * 0.7)
        blueBall.position = CGPoint(x: sizeRand/2 + CGFloat(blueBallPositionChoosing), y: -self.frame.size.height/6)
        
        // physics
        blueBall.physicsBody = SKPhysicsBody(circleOfRadius: sizeRand/2)
        blueBall.physicsBody?.categoryBitMask = surpriseGroup
        blueBall.physicsBody?.contactTestBitMask = wallsGroup
        blueBall.physicsBody?.collisionBitMask = wallsGroup
        blueBall.physicsBody?.isDynamic = true
        blueBall.physicsBody?.affectedByGravity = false
        blueBall.physicsBody?.allowsRotation = true
        
        // movement & direction
        var movement = Int32(arc4random() % UInt32(self.frame.size.height * 0.4))
        let blueBallDuration = (arc4random() % 3) + 3
        if arc4random() % 2 == 0 { movement = -movement }
        let move = SKAction.moveBy(x: CGFloat(movement), y: self.frame.size.height * 1.5, duration: TimeInterval(blueBallDuration))
        let remove = SKAction.removeFromParent()
        let moveBlueBallRepeater = SKAction.repeatForever(SKAction.sequence([move, remove]))

//        let moveBlueBallRepeater = bomb.nodeMovement(duration: bombDuration, frameHeight: self.frame.size.height)
        blueBall.run(moveBlueBallRepeater)
        
        blueBallObject.addChild(blueBall)
    }
    
    func createBomb() {
        bombTextureArray = [SKTexture(imageNamed: "bomb.png"),SKTexture(imageNamed: "bomb2.png"),SKTexture(imageNamed: "bomb3.png"),SKTexture(imageNamed: "bomb4.png")]
        let bombAnimation = SKAction.animate(with: bombTextureArray, timePerFrame: 0.05)
        let bombRepeater = SKAction.repeatForever(bombAnimation)
        bomb.run(bombRepeater)
        
        // sizing & position
        let sizeRand = CGFloat(self.frame.size.width/7.5)
        bomb.size.width = sizeRand
        bomb.size.height = sizeRand*1.35
        let bombPositionChoosing = arc4random() % UInt32(self.frame.size.width * 0.7)
        bomb.position = CGPoint(x: sizeRand/2 + CGFloat(bombPositionChoosing), y: -self.frame.size.height/6)
        
        // physics
        bomb.physicsBody = SKPhysicsBody(circleOfRadius: sizeRand/2)
        bomb.physicsBody?.categoryBitMask = surpriseGroup
        bomb.physicsBody?.contactTestBitMask = wallsGroup
        bomb.physicsBody?.collisionBitMask = wallsGroup
        bomb.physicsBody?.isDynamic = true
        bomb.physicsBody?.affectedByGravity = false
        bomb.physicsBody?.allowsRotation = true
        
        // movement & direction
        var movement = Int32(arc4random() % UInt32(self.frame.size.height * 0.4))
        let bombDuration = (arc4random() % 3) + 7
        if arc4random() % 2 == 0 { movement = -movement }
        let move = SKAction.moveBy(x: CGFloat(movement), y: self.frame.size.height * 1.5, duration: TimeInterval(bombDuration))
        let remove = SKAction.removeFromParent()
        let moveBombRepeater = SKAction.repeatForever(SKAction.sequence([move, remove]))

//        let moveBombRepeater = bomb.nodeMovement(duration: bombDuration, frameHeight: self.frame.size.height)
        bomb.run(moveBombRepeater)
        
        bombObject.addChild(bomb)
    }
    
    
    
    
    
    
    
    
    
    
    
}
