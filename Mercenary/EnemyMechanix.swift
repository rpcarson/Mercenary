//
//  EnemyMechanix.swift
//  Mercenary
//
//  Created by Reed Carson on 7/13/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit




func weakJetSpawn(scene: SKScene) {
    
    let ranPointY2 = CGFloat(arc4random_uniform(100))
    let ranPointY = CGFloat(arc4random_uniform(100))

    let enemy = WeakJet(scene: scene)
    
    enemy.position = CGPoint(x: scene.size.width + enemy.size.width, y: scene.size.height * (ranPointY2 / 100))
    scene.addChild(enemy)
    
    let move = SKAction.moveTo(CGPoint(x: -scene.size.width + enemy.size.width, y: scene.size.height * (ranPointY / 100)), duration: 10)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([move,remove])
    
    enemy.runAction(sequence)
    
}

func weakJetRocket(scene: SKScene, enemyShip: WeakJet) {
    
    let rocketTex = SKTexture(imageNamed: "rocket1")
    let rocket = SKSpriteNode(texture: rocketTex)
    
    rocket.size = CGSize(width: 100, height: 30)
    rocket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 90, height: 25))
    rocket.physicsBody?.collisionBitMask = 0
    rocket.physicsBody?.contactTestBitMask = playerCategory
    rocket.physicsBody?.categoryBitMask = enemyRocketCat
    rocket.position = enemyShip.position
//    rocket.zPosition = 100
    
    scene.addChild(rocket)
    
    rocket.physicsBody?.applyImpulse(CGVector(dx: -100, dy: 0))
}




