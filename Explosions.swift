//
//  Explosions.swift
//  Mercenary
//
//  Created by Reed Carson on 7/16/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit





func explodeFuncShape(scene: SKScene, enemy: SKShapeNode) {
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion2")
    explosion.position = enemy.position
    explosion.size = CGSize(width: 100, height: 100)
    
    scene.addChild(explosion)
    
    let fade = SKAction.fadeOutWithDuration(0.8)
    
    let remove = SKAction.sequence([SKAction.waitForDuration(0.1),fade,SKAction.removeFromParent()])
    
//    explosion.runAction(remove)
    
    println("exploded")
    
}


func explodeFunc(scene: SKScene, enemy: SKSpriteNode) {
   
    
    
    
    
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion2")
    explosion.position = enemy.position
    explosion.size = CGSize(width: enemy.size.width * 2, height: enemy.size.height * 2)
    
    scene.addChild(explosion)
    
    let fade = SKAction.fadeOutWithDuration(0.8)

    let remove = SKAction.sequence([SKAction.waitForDuration(0.1),fade,SKAction.removeFromParent()])
    
    explosion.runAction(remove)
    
    
    let ranNum = arc4random_uniform(2)
    if ranNum == 2 {
        explosion.runAction(explodeSFX3)
        
    }
    if ranNum == 1 {
        explosion.runAction(explodeSFX2)
        
    }
    if ranNum == 0 {
        explosion.runAction(explodeSFX1)
        
    }
    
}
func explodeFunc2(scene: SKScene, enemy: SKSpriteNode) {
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion1")
    explosion.position = enemy.position
    explosion.size = CGSize(width: enemy.size.width * 2, height: enemy.size.height * 2)
    
    scene.addChild(explosion)
    
    let fade = SKAction.fadeOutWithDuration(0.8)
    let remove = SKAction.sequence([SKAction.waitForDuration(0.1),fade,SKAction.removeFromParent()])
    
    let ranNum = arc4random_uniform(2)
    if ranNum == 2 {
        explosion.runAction(explodeSFX3)

    }
    if ranNum == 1 {
        explosion.runAction(explodeSFX2)
        
    }
    if ranNum == 0 {
        explosion.runAction(explodeSFX1)
        
    }
    println(ranNum)
    
    explosion.runAction(remove)
    
}

func explodeFunc3(scene: SKScene, enemy: SKSpriteNode) {
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion1")
    explosion.position = enemy.position
    explosion.size = CGSize(width: enemy.size.width * 3, height: enemy.size.height * 3)
    
    scene.addChild(explosion)
    
    let remove = SKAction.removeFromParent()
    let fadeOut = SKAction.fadeOutWithDuration(2)
    let seq = SKAction.sequence([fadeOut,remove])
    explosion.runAction(seq)
    
    let ranNum = arc4random_uniform(2)
    if ranNum == 2 {
        explosion.runAction(explodeSFX3)
        
    }
    if ranNum == 1 {
        explosion.runAction(explodeSFX2)
        
    }
    if ranNum == 0 {
        explosion.runAction(explodeSFX1)
        
    }
    
}