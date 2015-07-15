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
    
    var ranYLarge = CGFloat(arc4random_uniform(700)) - 350
    let object = LargeAsteroid(scene: scene)
    scene.addChild(object)
    var ranTork = CGFloat(arc4random_uniform(6)) - 3
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
        let tex = SKTexture(imageNamed: "asteroid1")
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
    
    var ranYSmall2 = CGFloat(arc4random_uniform(800)) - 400

    var ranYSmall = CGFloat(arc4random_uniform(800)) - 400
    let object = SmallAsteroid(scene: scene)
    scene.addChild(object)
    var ranTork = CGFloat(arc4random_uniform(6)) - 3
    object.physicsBody?.applyTorque(ranTork)
    object.position = CGPoint(x: scene.size.width + object.size.width, y: (scene.size.height / 2) + ranYSmall)
    
    let moveExp = SKAction.moveBy(CGVector(dx: -1200, dy: -200), duration: 10)
    
    
    let move = SKAction.moveTo(CGPoint(x: -scene.size.width + object.size.width, y: (scene.size.height / 2) + ranYSmall2), duration: 10)
//    let move = SKAction.moveToX(-scene.size.width + object.size.width, duration: 8)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([move,remove])
    object.runAction(sequence)
    
}



class SmallAsteroid: SKSpriteNode {
    var ranYLarge = CGFloat(arc4random_uniform(700)) - 350
    var ranYSmall = CGFloat(arc4random_uniform(500)) - 250

    
    var health = 35
    
    init(scene: SKScene) {
        
        var ranSize = CGFloat(arc4random_uniform(120))
        let tex = SKTexture(imageNamed: "asteroid1")
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

func dropOre(scene: SKScene, asteroid: SmallAsteroid) {
    
    let ranNum = arc4random_uniform(4)
    var oreChance: UInt32 = 3
    
    let orePiece = SKShapeNode(circleOfRadius: 20)
    orePiece.fillColor = UIColor.yellowColor()
    orePiece.physicsBody = SKPhysicsBody(circleOfRadius: 25)
    orePiece.position = asteroid.position
    orePiece.physicsBody?.collisionBitMask = 0

    println(ranNum)
    println(oreChance)
    
    if oreChance == ranNum {
        
        scene.addChild(orePiece)
        orePiece.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0))
        
    }
}

func oreDrop(scene: SKScene) {
    
    let orePiece = SKShapeNode(circleOfRadius: 20)
    orePiece.physicsBody = SKPhysicsBody(circleOfRadius: 25)
    orePiece.fillColor = UIColor.yellowColor()
    orePiece.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    orePiece.physicsBody?.collisionBitMask = 0
    
    
    scene.addChild(orePiece)
    orePiece.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 0))

    
    
    println("ore dropped")
    
}


