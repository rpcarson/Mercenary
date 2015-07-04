//
//  EnemyTypes.swift
//  Mercenary
//
//  Created by Reed Carson on 7/2/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


class Enemy {
    
    var health: Int!
    
}



var helicopterOneAlive: Bool = false

var enemySpawnPointOne: CGPoint!
var enemyOneImpulse: CGVector!
var gravBoolEOne: Bool!
var helicopterPosition: CGPoint!



var helicopter1Health: Int = 50
let helicopter1 = SKSpriteNode(imageNamed: "shittyHelicopter")



func helicopterEnemy(scene: SKScene) {
    
    helicopterOneAlive = true
    
    var helicopterTextureOne: SKTexture!
    var helicopter1Health: Int! = 50
    helicopterTextureOne = SKTexture(imageNamed: "shittyHelicopter")
    helicopter1.physicsBody = SKPhysicsBody(texture: helicopterTextureOne, size: helicopter1.size)

    
    helicopter1.position = enemySpawnPointOne
    
//    helicopter1.position = CGPoint(x: scene.frame.size.width / 2, y: scene.frame.size.height / 2)
//    helicopter1.zPosition = 1
    
    helicopter1.physicsBody?.categoryBitMask = enemyCategoryOne
    helicopter1.physicsBody?.contactTestBitMask = playerProjectileOne
    helicopter1.physicsBody?.collisionBitMask = 0
    helicopter1.physicsBody?.usesPreciseCollisionDetection = true
    helicopter1.physicsBody?.linearDamping = 0
    
    scene.addChild(helicopter1)
    
    helicopter1.physicsBody?.applyImpulse(enemyOneImpulse)
    helicopter1.physicsBody?.affectedByGravity = gravBoolEOne

}

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
    bullets.position = helicopter1.position
    
    

    
    
    scene.addChild(bullets)

    
    bullets.physicsBody?.affectedByGravity = false
    
    
    
    let X = player.position.x - bullets.position.x
    let Y = player.position.y - bullets.position.y
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    bullets.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*7, Y/magnitude*7))
    
    
    
}







let wait = SKAction.waitForDuration(1.0)
let enemyAttackRate = SKAction.runBlock {

    
}



