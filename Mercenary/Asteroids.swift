//
//  Asteroids.swift
//  Mercenary
//
//  Created by Reed Carson on 7/13/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit

func LargeAsteroidMechanix(scene: SKScene) {
    
    let ranYLarge = CGFloat(arc4random_uniform(700)) - 350
    let object = LargeAsteroid(scene: scene)
    scene.addChild(object)
    
    let ranTork = CGFloat(arc4random_uniform(6)) - 3
    object.physicsBody?.applyTorque(ranTork)
    object.position = CGPoint(x: scene.size.width + object.size.width, y: (scene.size.height / 2) + ranYLarge)
    
    let move = SKAction.moveToX(-scene.size.width + object.size.width, duration: 20)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([move,remove])
    object.runAction(sequence)
    
}

class LargeAsteroid: SKSpriteNode {
    
    var health = 100
    
    init(scene: SKScene) {
        let tex = smallAss
        super.init(texture: tex, color: UIColor.clearColor(), size: tex.size())
        
        physicsBody = SKPhysicsBody(circleOfRadius: 100)
        size = CGSize(width: 300, height: 300)
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = playerProjectileOne | playerCategory
        physicsBody?.categoryBitMask = largeRockCat
        physicsBody?.linearDamping = 0
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func SmallAsteroidMechanix(scene: SKScene) {
    
    let ranYSmall2 = CGFloat(arc4random_uniform(800)) - 400

    let ranYSmall = CGFloat(arc4random_uniform(800)) - 400
    let object = SmallAsteroid(scene: scene)
    scene.addChild(object)
    
    let ranTork = CGFloat(arc4random_uniform(6)) - 3
    object.physicsBody?.applyTorque(ranTork)
    object.position = CGPoint(x: scene.size.width + object.size.width, y: (scene.size.height / 2) + ranYSmall)
    
    let move = SKAction.moveTo(CGPoint(x: -scene.size.width + object.size.width, y: (scene.size.height / 2) + ranYSmall2), duration: 10)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([move,remove])
    object.runAction(sequence)
    
}



class SmallAsteroid: SKSpriteNode {
    var ranYLarge = CGFloat(arc4random_uniform(700)) - 350
    var ranYSmall = CGFloat(arc4random_uniform(500)) - 250

    
    var health = 35
    
    init(scene: SKScene) {
        
        let ranSize = CGFloat(arc4random_uniform(120))
        let tex = smallAss
        super.init(texture: tex, color: UIColor.clearColor(), size: tex.size())
        
        physicsBody = SKPhysicsBody(circleOfRadius: 35)
        size = CGSize(width: 75 + ranSize, height: 75 + ranSize)
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = playerCategory | playerProjectileOne
        physicsBody?.categoryBitMask = smallRockCat
        physicsBody?.linearDamping = 0
        physicsBody?.mass = 5
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



