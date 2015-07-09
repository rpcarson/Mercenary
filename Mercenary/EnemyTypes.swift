//
//  EnemyTypes.swift
//  Mercenary
//
//  Created by Reed Carson on 7/2/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit





class ShittyTank: SKSpriteNode {
    
    init(scene: SKScene) {

        let texture = SKTexture(imageNamed: "shittyTank")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        size = CGSize(width: 200, height: 100)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = enemyCategoryOne
        physicsBody?.contactTestBitMask = playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.linearDamping = 0
        position = CGPoint(x: scene.frame.width + size.width, y: 120)
        
        scene.addChild(self)
        
        physicsBody?.applyImpulse(CGVector(dx: -30, dy: 0))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    
    }
    
}


//func shittyTankFunc(scene: SKScene) {
//    
//    
//    let tankText = SKTexture(imageNamed: "shittyTank")
//    let shittyTank = SKSpriteNode(imageNamed: "shittyTank")
//    shittyTank.size = CGSize(width: 200, height: 100)
//    shittyTank.physicsBody = SKPhysicsBody(texture: tankText, size: shittyTank.size)
//    
//    shittyTank.physicsBody?.affectedByGravity = false
//    shittyTank.physicsBody?.categoryBitMask = enemyCategoryOne
//    shittyTank.physicsBody?.contactTestBitMask = playerProjectileOne
//    shittyTank.physicsBody?.collisionBitMask = 0
//    shittyTank.position = CGPoint(x: scene.frame.width + shittyTank.size.width, y: 120)
//    
//    scene.addChild(shittyTank)
//    
//    shittyTank.physicsBody?.applyImpulse(CGVector(dx: -30, dy: 0))
//    shittyTank.physicsBody?.linearDamping = 0
//    
//    
//}







var helicopterOneAlive: Bool = false

var enemySpawnPointOne: CGPoint!
var enemyOneImpulse: CGVector!
var gravBoolEOne: Bool!
var helicopterPosition: CGPoint!



var helicopter1Health: Int = 50
let helicopter1 = SKSpriteNode(imageNamed: "shittyPlane")



class WeakJet: SKSpriteNode {
    
    init(scene: SKScene) {
        
        let texture = SKTexture(imageNamed: "shittyPlane")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        var health = 30
        
        size = CGSize(width: 150, height: 75)
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        position = enemySpawnPointOne
        physicsBody?.categoryBitMask = enemyCategoryOne
        physicsBody?.contactTestBitMask = playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.linearDamping = 0
        scene.addChild(self)
        physicsBody?.affectedByGravity = false
        physicsBody?.applyImpulse(enemyOneImpulse)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//func helicopterEnemy(scene: SKScene) {
//    helicopterOneAlive = true
//    var helicopterTextureOne: SKTexture!
//    var helicopter1Health: Int! = 50
//    
//    helicopterTextureOne = SKTexture(imageNamed: "shittyPlane")
//    helicopter1.physicsBody = SKPhysicsBody(texture: helicopterTextureOne, size: helicopter1.size)
//    helicopter1.position = enemySpawnPointOne
//    helicopter1.physicsBody?.categoryBitMask = enemyCategoryOne
//    helicopter1.physicsBody?.contactTestBitMask = playerProjectileOne
//    helicopter1.physicsBody?.collisionBitMask = 0
//    helicopter1.physicsBody?.usesPreciseCollisionDetection = true
//    helicopter1.physicsBody?.linearDamping = 0
//    
//    scene.addChild(helicopter1)
//    
//    helicopter1.physicsBody?.applyImpulse(enemyOneImpulse)
//
//}

var helicopterBulletDamage: Int! = 5

var bulletCount: Double = 0



    
    
    
    
    
    
    





func helicopterAttack(scene: SKScene) {
    
    var bullets: SKShapeNode!
    bullets = SKShapeNode(circleOfRadius: 7)

    bullets.physicsBody = SKPhysicsBody(circleOfRadius: 7)
    bullets.fillColor = UIColor.whiteColor()
    bullets.physicsBody?.categoryBitMask = enemyAttackCategory
    bullets.physicsBody?.contactTestBitMask = playerCategory
    bullets.physicsBody?.collisionBitMask = 0
//    bullets.position = 
    
    scene.addChild(bullets)

    
    bullets.physicsBody?.affectedByGravity = false
    
    let X = player.position.x - bullets.position.x
    let Y = player.position.y - bullets.position.y
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    bullets.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*7, Y/magnitude*7))
    
    
    
}


