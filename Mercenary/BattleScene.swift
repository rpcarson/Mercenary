//
//  GameScene.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import SpriteKit


var timer: NSTimer!

var gunReloaded: Bool = true
var gunBool: Bool = false

var player: SKSpriteNode!

var touchLocationX: CGFloat!
var touchLocationY: CGFloat!


class BattleScene: SKScene, SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
       
         initializePlayer()
        initializeBackground()
        
        
        
        
        enemySpawnPointOne = CGPoint(x: frame.width + 300, y: frame.height - 200)
        enemyOneImpulse = CGVectorMake(-100, 10)
        WeakJet(scene: self)
        
       
        
//        ShittyTank(scene: self)
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
        
    func didBeginContact(contact: SKPhysicsContact) {

        var firstBody = contact.bodyA.node
        var secondBody = contact.bodyB.node
       
        var firstMask = contact.bodyA.categoryBitMask
        var secondMask = contact.bodyB.categoryBitMask
        
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
    
    var bulletDelay = 0
    
    override func update(currentTime: CFTimeInterval) {
        
        BGScroll()

        bulletDelay++
        
        
        if helicopterOneAlive == true && bulletDelay > 15 {
            
            helicopterAttack(self)
            
            bulletDelay = 0

        }
        
        if (gunBool == true) && (gunReloaded == true) {
            
            autoCannon(self)
            
            //            basicShotgun(self)
            
        }
        
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            touchLocationX = location.x
            touchLocationY = location.y
            
            gunBool = true
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            touchLocationX = location.x
            touchLocationY = location.y
            
            gunBool = true
            
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            gunBool = false
            
        }
        
    }
    
    func gunDelay() {
        
        gunReloaded = true
        
    }


    
    
    func BGScroll() {
        
        
        let bg1 = SKSpriteNode(imageNamed: "cloudoverlay")
        let bg2 = SKSpriteNode(imageNamed: "cloudoverlay")
        
        bg1.position = CGPointMake(bg1.position.x - 2, bg1.position.y)
        bg2.position = CGPointMake(bg2.position.x - 2, bg2.position.y)
        
        
        if(bg1.position.x < -bg1.size.width)
            
        {
            
            bg1.position = CGPointMake(bg2.position.x + bg1.size.width, bg2.position.y)
            
        }
        
        if(bg2.position.x < -bg2.size.width)
            
        {
            
            bg2.position = CGPointMake(bg1.position.x + bg2.size.width, bg1.position.y)
            
        }
    }
    

    func initializePlayer() {
        
        
        var playerTex: SKTexture!
        playerTex = SKTexture(imageNamed: "shittyPlayer")
        player = SKSpriteNode(texture: playerTex)
        player.physicsBody = SKPhysicsBody(texture: playerTex, size: player.size)
        player.size = CGSize(width: 220, height: 120)
        player.position = CGPoint(x: 120, y: 190)
        player.physicsBody?.collisionBitMask = 0
        player.zPosition = 2
        addChild(player)
        player.physicsBody?.affectedByGravity = false
        
        
    }


    func initializeBackground() {
        
        
        let bg1 = SKSpriteNode(imageNamed: "cloudoverlay")
        let bg2 = SKSpriteNode(imageNamed: "cloudoverlay")

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

    }

}