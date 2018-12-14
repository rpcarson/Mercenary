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
    
    let fade = SKAction.fadeOut(withDuration: 0.8)
    
    _ = SKAction.sequence([SKAction.wait(forDuration: 0.1),fade,SKAction.removeFromParent()])
    
//    explosion.runAction(remove)
    
    print("exploded")
    
}


func explodeFunc(scene: SKScene, enemy: SKSpriteNode) {
   
    
    
    
    
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion2")
    explosion.position = enemy.position
    explosion.size = CGSize(width: enemy.size.width * 2, height: enemy.size.height * 2)
    
    scene.addChild(explosion)
    
    let fade = SKAction.fadeOut(withDuration: 0.8)

    let remove = SKAction.sequence([SKAction.wait(forDuration: 0.1),fade,SKAction.removeFromParent()])
    
    explosion.run(remove)
    
    
    let ranNum = arc4random_uniform(2)
    if ranNum == 2 {
        explosion.run(explodeSFX3)
        
    }
    if ranNum == 1 {
        explosion.run(explodeSFX2)
        
    }
    if ranNum == 0 {
        explosion.run(explodeSFX1)
        
    }
    
}
func explodeFunc2(scene: SKScene, enemy: SKSpriteNode) {
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion1")
    explosion.position = enemy.position
    explosion.size = CGSize(width: enemy.size.width * 2, height: enemy.size.height * 2)
    
    scene.addChild(explosion)
    
    let fade = SKAction.fadeOut(withDuration: 0.8)
    let remove = SKAction.sequence([SKAction.wait(forDuration: 0.1),fade,SKAction.removeFromParent()])
    
    let ranNum = arc4random_uniform(2)
    if ranNum == 2 {
        explosion.run(explodeSFX3)

    }
    if ranNum == 1 {
        explosion.run(explodeSFX2)
        
    }
    if ranNum == 0 {
        explosion.run(explodeSFX1)
        
    }
    print(ranNum)
    
    explosion.run(remove)
    
}

func explodeFunc3(scene: SKScene, enemy: SKSpriteNode) {
    let explosion = SKSpriteNode(imageNamed: "crappyExplosion1")
    explosion.position = enemy.position
    explosion.size = CGSize(width: enemy.size.width * 3, height: enemy.size.height * 3)
    
    scene.addChild(explosion)
    
    let remove = SKAction.removeFromParent()
    let fadeOut = SKAction.fadeOut(withDuration: 2)
    let seq = SKAction.sequence([fadeOut,remove])
    explosion.run(seq)
    
    let ranNum = arc4random_uniform(2)
    if ranNum == 2 {
        explosion.run(explodeSFX3)
        
    }
    if ranNum == 1 {
        explosion.run(explodeSFX2)
        
    }
    if ranNum == 0 {
        explosion.run(explodeSFX1)
        
    }
    
}
