//
//  GameScene.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import SpriteKit

var obstacleHealth: Int!
var playerHealth: Int!
var currentScore: Int = 0
var scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")

var pauseButton: SKSpriteNode!

var timer: NSTimer!

var gunReloaded: Bool = true
var gunBool: Bool = false

var player: SKSpriteNode!

var touchLocationX: CGFloat!
var touchLocationY: CGFloat!

var moveDown: SKSpriteNode!
var moveUp: SKSpriteNode!
var gunZone: SKSpriteNode!

var playerUp: Bool = false
var playerDown: Bool = false


//let intro = SKAction.playSoundFileNamed("LevelOneIntroLoop.mp3", waitForCompletion: true)
//let mainLoop = SKAction.playSoundFileNamed("LevelOneMainLoop.mp3", waitForCompletion: true)
//let loopMain = SKAction.repeatActionForever(mainLoop)
//let musicSequence = SKAction.sequence([intro,mainLoop])
//

let music = SKAction.playSoundFileNamed("LevelOneMainLoop.mp3", waitForCompletion: true)
let loopMusic = SKAction.repeatActionForever(music)


class BattleScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        
        initializePlayer()
        initializeBackground()
//        runAction(musicSequence)
        runAction(loopMusic)
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (randomObject(self))
            },
            SKAction.waitForDuration(3, withRange: 2)
            ])))
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (largeAssteroid(self))
            },
            SKAction.waitForDuration(10, withRange: 5)
            ])))
        

        
        
        enemyFighter(self)
        
        
        moveDown = childNodeWithName("moveDown") as? SKSpriteNode
        moveUp = childNodeWithName("moveUp") as? SKSpriteNode
        gunZone = childNodeWithName("gunZone") as? SKSpriteNode
        
        moveDown.hidden = true
        moveUp.hidden = true
        gunZone.hidden = true
        
        pauseButton = childNodeWithName("pauseButton") as? SKSpriteNode
        pauseButton.zPosition = 10
        pauseButton.hidden = true
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
    
    
    
    
    
    
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody = contact.bodyA.node
        var secondBody = contact.bodyB.node
        
        var firstMask = contact.bodyA.categoryBitMask
        var secondMask = contact.bodyB.categoryBitMask
        
        let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
        let enemy = secondMask == obstacleCategory ? secondBody : firstBody
        
        if (firstMask == playerCategory) && (secondMask == obstacleCategory) || (secondMask == playerCategory) && (firstMask == obstacleCategory) {
            
            println("u suck")
            playerHealth = playerHealth - 25
            enemy?.removeFromParent()
            
        }
        if (firstMask == playerProjectileOne) && (secondMask == obstacleCategory) || (secondMask == playerProjectileOne) && (firstMask == obstacleCategory) {
            
            println(obstacleHealth)
            
            projectile?.removeFromParent()
            
            obstacleHealth = obstacleHealth - autoCannonDamage
            
            if obstacleHealth <= 0
                
            {
                enemy?.removeFromParent()
                
                currentScore = currentScore + 100
                
                scoreLabel.text = "\(currentScore)"
            }
            
        }
        
        if (firstMask == playerProjectileOne) && (secondMask == enemyCategoryOne) || (secondMask == playerProjectileOne) && (firstMask == enemyCategoryOne) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == enemyCategoryOne ? secondBody : firstBody
            
            projectile?.removeFromParent()
            
            helicopter1Health = helicopter1Health - autoCannonDamage
            
            println(helicopter1Health)
            
            if helicopter1Health <= 25 {
                
                enemy?.physicsBody?.applyImpulse(CGVectorMake(-40, -200))
                enemy?.physicsBody?.allowsRotation = true
                enemy?.physicsBody?.angularVelocity = 1
                
            }
            
            if helicopter1Health <= 0 {
                
                helicopterOneAlive = false
                
                enemy?.removeFromParent()
                
            }
            
        }
        
    }
    
    
    func gunDelay() { gunReloaded = true }
    
    
    var bulletDelay = 0
    override func update(currentTime: CFTimeInterval) {
        
        BGScroll()
        BGScroll2()
        
        bulletDelay++
        //        player.physicsBody.
        
        
        
        if (playerUp == true) && (player.position.y < frame.height - 70) {
            player.position.y = player.position.y + 15
        }
        if (playerDown == true) && (player.position.y > frame.height - frame.height + 70) {
            player.position.y = player.position.y - 15
        }
        
        if helicopterOneAlive == true && bulletDelay > 15 {
            helicopterAttack(self)
            bulletDelay = 0
            
        }
        if (gunBool == true) && (gunReloaded == true) {
            autoCannon(self)
        }
        
    }
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//\/\/\//\/\/\//\//\/\/\//\/\/\\
    
    // touches stuff
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            touchLocationX = location.x
            touchLocationY = location.y
            
            if pauseButton .containsPoint(location) {
                
                if scene!.view!.paused == false {
                    scene!.view!.paused = true
                    
                } else if scene!.view!.paused == true {
                    
                    scene!.view!.paused = false
                }
            }
            if gunZone .containsPoint(location) {
                gunBool = true
            }
            if moveUp .containsPoint(location) {
                
//                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//                
//                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
                
                
                
                                playerUp = true
            }
            if moveDown .containsPoint(location) {
               
//                player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//                
//                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -60))
//                
                
                                playerDown = true
            }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            touchLocationX = location.x
            touchLocationY = location.y
            
            if gunZone .containsPoint(location) {
                gunBool = true
                
            }
//            if moveDown .containsPoint(location) {
//                
//                player.position.y = player.position.y - 6
//                
//            }
//            if moveUp .containsPoint(location) {
//                
//                player.position.y = player.position.y + 6
//                
//            }
            
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            if gunZone .containsPoint(location) {
                gunBool = false
            }
            if moveUp .containsPoint(location) {
                                playerUp = false
            }
            if moveDown .containsPoint(location) {
                                playerDown = false
            }
            
        }
        
    }
    
    
    //touches stuff ends
    
    
    //~~~~~~~~~~~\//\/\/\//\/\\//\
    
    
    func initializePlayer() {
        
        var playerTex: SKTexture!
        playerTex = SKTexture(imageNamed: "betterShittyPlayer")
        player = SKSpriteNode(texture: playerTex)
        player.size = (CGSize(width: 200, height: 75))
        
        
        player.physicsBody = SKPhysicsBody(texture: playerTex, size: player.size)
        player.position = CGPoint(x: frame.width * 0.15, y: frame.height / 2)
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody?.contactTestBitMask = 5
        player.zPosition = 2
        addChild(player)
        player.physicsBody?.affectedByGravity = false
        playerHealth = 100
        
        
    }
    
    
    func initializeBackground() {
        
        //        let bg1 = SKSpriteNode(imageNamed: "cloudoverlay")
        //        let bg2 = SKSpriteNode(imageNamed: "cloudoverlay")
        
        //        var bg = SKSpriteNode(imageNamed: "starryRedMoon")
        //        bg.size = CGSize(width: frame.width, height: frame.height)
        //        bgMain.anchorPoint = CGPoint(x: 0, y: 0)
        //        bgMain.zPosition = -10
        //        addChild(bgMain)
        
        bg1.anchorPoint = CGPointZero
        bg1.position = CGPoint(x: 0, y: 0)
        bg1.zPosition = -5
        addChild(bg1)
        
        bg2.anchorPoint = CGPointZero
        bg2.position = CGPoint(x: bg1.size.width - 1, y: 0)
        bg2.zPosition = -5
        addChild(bg2)
        
        bgMain.anchorPoint = CGPointZero
        bgMain.position = CGPoint(x: 0, y: 0)
        bgMain.zPosition = -6
        addChild(bgMain)
        
        bgMain1.anchorPoint = CGPointZero
        bgMain1.position = CGPoint(x: bgMain.size.width - 1, y: 0)
        bgMain1.zPosition = -6
        addChild(bgMain1)
        
        
        scoreLabel.text = "\(currentScore)"
        scoreLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 60)
        scoreLabel.zPosition = 10
        scoreLabel.fontSize = 75
        
        addChild(scoreLabel)
        
        
    }
    
}