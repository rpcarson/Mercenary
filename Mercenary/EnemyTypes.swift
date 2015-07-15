//
//  EnemyTypes.swift
//  Mercenary
//
//  Created by Reed Carson on 7/2/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit





class WeakJet: SKSpriteNode {
    
    var health = 25
    
    init(scene: SKScene) {
        
        let texture = SKTexture(imageNamed: "crapEnemy1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        size = CGSize(width: 150, height: 150)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = enemyCategoryOne
        physicsBody?.contactTestBitMask = playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.linearDamping = 0
        
        let wait = SKAction.waitForDuration(1)
        let fire = SKAction.runBlock( { weakJetRocket(scene, self) } )
        let sequence = SKAction.sequence([wait,fire])
        let action = SKAction.repeatAction(sequence, count: 2)
        
        
        runAction(action)
        
//        fire = SKAction.runBlock { () -> Void in
//                
//            weakJetRocket(scene)
//                
//        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var fire: SKAction!
    
}


func enemyFighter(scene: SKScene) {
    
    let fighterTex = SKTexture(imageNamed: "crapEnemy1")
    let fighter = SKSpriteNode(texture: fighterTex)
    
    var ranY = CGFloat(arc4random_uniform(500)) - 250
    fighter.size = CGSize(width: 100, height: 100)
    fighter.physicsBody = SKPhysicsBody(circleOfRadius: 50)
    fighter.position = CGPoint(x: scene.size.width + fighter.size.width, y: (scene.size.height / 2) + ranY)
    fighter.physicsBody?.contactTestBitMask = playerCategory
    fighter.physicsBody?.collisionBitMask = 0
    fighter.physicsBody?.categoryBitMask = fighterCategory
    scene.addChild(fighter)
    
    let enemyMove = SKAction.moveToX(-scene.size.width + fighter.size.width, duration: 10)
    let fighterDelay = SKAction.waitForDuration(3)
    let sequence = SKAction.sequence([fighterDelay,enemyMove])
    
    fighter.runAction(sequence)
    
}

//class WeakFighter: SKSpriteNode {
//    init(scene: SKScene) {
//     let fighterTex = SKTexture(imageNamed: "crappyEnemy1")
//        super.init(texture: fighterTex, color: UIColor.clearColor(), size: fighterTex.size())
//
//        size = CGSize(width: 100, height: 100)
//        position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

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




class Bomber: SKSpriteNode {
    
    var health = 100
    
    func rocketAttack1(scene: SKScene) {
        
        let rocketTex = SKTexture(imageNamed: "rocket1")
        let rocket = SKSpriteNode(texture: rocketTex)
        
        rocket.size = CGSize(width: 125, height: 25)
        rocket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 100, height: 50))
        rocket.physicsBody?.collisionBitMask = 0
        rocket.physicsBody?.contactTestBitMask = playerCategory
        rocket.physicsBody?.categoryBitMask = enemyAttackCategory
        rocket.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
        
        rocket.position = Bomber(scene: scene).position
        
        scene.addChild(rocket)
        
        func drop() { rocket.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20)) }
        func forward() { rocket.physicsBody?.applyImpulse(CGVector(dx: -220, dy: 20)) }
        func stop() { rocket.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20)) }
        
        //        var rocket1 = SKAction.runBlock( {scene.addChild(rocket) } )
        
        let stopSeq = SKAction.runBlock(stop)
        let waitQuick = SKAction.waitForDuration(0.2)
        let wait = SKAction.waitForDuration(0.5)
        let dropSeq = SKAction.runBlock(drop)
        let forwardSeq = SKAction.runBlock(forward)
        let fireSequence = SKAction.sequence([dropSeq,wait,stopSeq,waitQuick,forwardSeq])
        rocket.runAction(fireSequence)
        
    }
    
    init(scene: SKScene) {
        
        let bomberTex = SKTexture(imageNamed: "shittyPlane")
        super.init(texture: bomberTex, color: UIColor.clearColor(), size: bomberTex.size())
        
        size = CGSize(width: 300, height: 200)
        physicsBody = SKPhysicsBody(texture: bomberTex, size: size)
        physicsBody?.contactTestBitMask = playerProjectileOne
        physicsBody?.categoryBitMask = bomberCategory
        physicsBody?.collisionBitMask = 0
        
        position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height)
        physicsBody?.linearDamping = 0
        
        scene.addChild(self)
        
        func drop() { physicsBody?.applyImpulse(CGVector(dx: 0, dy: -150)) }
        func slow() { physicsBody?.applyImpulse(CGVector(dx: -20, dy: 150)) }
        func forward() { physicsBody?.applyImpulse(CGVector(dx: -80, dy: 10)) }
        
        let fireRocket = SKAction.runBlock( { self.rocketAttack1(self.scene!) } )
        let waitQuick = SKAction.waitForDuration(0.6)
        let waitOne = SKAction.waitForDuration(1)
        let dropSeq = SKAction.runBlock(drop)
        let slowSeq = SKAction.runBlock(slow)
        let forwardSeq = SKAction.runBlock(forward)
        let moveSequence = SKAction.sequence([dropSeq,waitOne,slowSeq,fireRocket,waitOne,fireRocket,forwardSeq])
        
        runAction(moveSequence)
        
        //        physicsBody?.applyImpulse(CGVector(dx: 0, dy: -100))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func rocketAttack(scene: SKScene) {
    
    let rocketTex = SKTexture(imageNamed: "rocket1")
    let rocket = SKSpriteNode(texture: rocketTex)
    
    rocket.size = CGSize(width: 100, height: 50)
    rocket.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 100, height: 50))
    rocket.physicsBody?.collisionBitMask = 0
    rocket.physicsBody?.contactTestBitMask = playerCategory
    rocket.physicsBody?.categoryBitMask = enemyAttackCategory
    rocket.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    
    rocket.position = Bomber(scene: scene).position
    
    scene.addChild(rocket)
    
    func drop() { rocket.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20)) }
    func forward() { rocket.physicsBody?.applyImpulse(CGVector(dx: -220, dy: 20)) }
    func stop() { rocket.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20)) }
    
    let stopSeq = SKAction.runBlock(stop)
    let waitQuick = SKAction.waitForDuration(0.2)
    let wait = SKAction.waitForDuration(0.5)
    let dropSeq = SKAction.runBlock(drop)
    let forwardSeq = SKAction.runBlock(forward)
    let fireSequence = SKAction.sequence([dropSeq,wait,stopSeq,waitQuick,forwardSeq])
    rocket.runAction(fireSequence)
    
}

