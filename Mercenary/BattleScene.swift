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
var scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-UltraLight")



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


class BattleScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        
        initializePlayer()
        initializeBackground()
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (randomObject(self))
                },
            SKAction.waitForDuration(3, withRange: 2)
            ])))
        
        moveDown = childNodeWithName("moveDown") as? SKSpriteNode
        moveUp = childNodeWithName("moveUp") as? SKSpriteNode
        gunZone = childNodeWithName("gunZone") as? SKSpriteNode
        
        moveDown.hidden = true
        moveUp.hidden = true
        gunZone.hidden = true
        
        
        
        //        enemySpawnPointOne = CGPoint(x: frame.width + 300, y: frame.height - 200)
        //        enemyOneImpulse = CGVectorMake(-100, 10)
        //        WeakJet(scene: self)
        
        
        
        //        ShittyTank(scene: self)
        
        
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
        
        bulletDelay++
        
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
            
            if gunZone .containsPoint(location) {
                gunBool = true
            }
            if moveUp .containsPoint(location) {
                playerUp = true
            }
            if moveDown .containsPoint(location) {
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
        playerTex = SKTexture(imageNamed: "shittyPlayer")
        player = SKSpriteNode(texture: playerTex)
        player.physicsBody = SKPhysicsBody(texture: playerTex, size: player.size)
        player.size = CGSize(width: 220, height: 120)
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
        
        var bg = SKSpriteNode(imageNamed: "starryRedMoon")
        bg.size = CGSize(width: frame.width, height: frame.height)
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        bg.zPosition = -10
        addChild(bg)
        
        bg1.anchorPoint = CGPointZero
        bg1.position = CGPoint(x: 0, y: 0)
        bg1.zPosition = -5
        addChild(bg1)
        
        bg2.anchorPoint = CGPointZero
        bg2.position = CGPoint(x: bg1.size.width - 1, y: 0)
        bg2.zPosition = -5
        addChild(bg2)
        
        scoreLabel.text = "\(currentScore)"
        scoreLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 60)
        scoreLabel.zPosition = 10
        scoreLabel.fontSize = 75
        
        addChild(scoreLabel)
    
    
    }
    
}