//
//  EnemyTypes.swift
//  Mercenary
//
//  Created by Reed Carson on 7/2/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


class Mine: SKSpriteNode {
    
    var health = 15
    
    init(scene: SKScene) {
        let tex = SKTexture(imageNamed: "mine1")
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
        physicsBody = SKPhysicsBody(circleOfRadius: 40)
        size = CGSize(width: 75, height: 75)
        physicsBody?.contactTestBitMask = playerCategory | playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = mineCat
        zPosition = 3
        physicsBody?.linearDamping = 0
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ArtillaryBarge: SKSpriteNode {
    
    var health = 300
    
    init(scene: SKScene) {
        let tex = SKTexture(imageNamed: "tankerGreen")
        super.init(texture: tex, color: UIColor.clear, size: tex.size())
        
       

        
        physicsBody = SKPhysicsBody(texture: tex, size: size)
        physicsBody?.contactTestBitMask = playerCategory | playerProjectileOne
        physicsBody?.categoryBitMask = bargeCat
        physicsBody?.collisionBitMask = 0
        zPosition = 3
        
        
        
        let delay = SKAction.wait(forDuration: 2)
        let wait = SKAction.wait(forDuration: 0.2)
        let fire = SKAction.run { bargeBarrage(scene: scene, shotOrigin: self) } 
        let attackBehaviour = SKAction.sequence([delay,fire])
        
        
//        runAction(SKAction.repeatActionForever(attackBehaviour))
        
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class LittleMinion: SKSpriteNode {
    
    var health = 22
    
    init(scene: SKScene) {
        let tex = minTex
        super.init(texture: tex, color: UIColor.clear, size: tex!.size())
        
        size = CGSize(width: 100, height: 60)
        physicsBody = SKPhysicsBody(texture: tex!, size: size)
        physicsBody?.contactTestBitMask = playerCategory | playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = strafeJetCat
        zPosition = 1
        
        let delay = SKAction.wait(forDuration: 0.6)
        _ = SKAction.wait(forDuration: 0.3)
        let fire = SKAction.run { minionShot(scene: scene, enemyShip: self) };
        let attackBehaviour = SKAction.sequence([delay,fire])
    
        
        run(SKAction.repeatForever(attackBehaviour))
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}



class StrafeJet: SKSpriteNode {
    
    var health = 100
    
    init(scene: SKScene) {
        let tex = strayTex
        super.init(texture: tex, color: UIColor.clear, size: tex!.size())
   
        size = CGSize(width: 130, height: 100)
        physicsBody = SKPhysicsBody(texture: tex!, size: size)
        physicsBody?.contactTestBitMask = playerCategory | playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = strafeJetCat
        zPosition = 1
    
        let delay = SKAction.wait(forDuration: 0.3)
        let wait = SKAction.wait(forDuration: 1)
        let fire = SKAction.run { strafeJetProjectile(scene: scene, enemyShip: self) }
        let attackBehaviour = SKAction.sequence([wait,fire,delay,fire,delay,fire])
        run(SKAction.repeat(attackBehaviour, count: 3))
    
    
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class WeakJet: SKSpriteNode {
    
    var health = 50
    
    init(scene: SKScene) {
        
        let texture = jetTex
        super.init(texture: texture, color: UIColor.clear, size: texture!.size())
        
        size = CGSize(width: 150, height: 150)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.categoryBitMask = enemyCategoryOne
        physicsBody?.contactTestBitMask = playerProjectileOne
        physicsBody?.collisionBitMask = 0
        physicsBody?.linearDamping = 0
        
        zPosition = 1
        
        let wait = SKAction.wait(forDuration: 1)
        let fire = SKAction.run { weakJetRocket(scene: scene, enemyShip: self) }
        let sequence = SKAction.sequence([wait,fire])
        let action = SKAction.repeat(sequence, count: 2)
        
        
        run(action)


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


func enemyFighter(scene: SKScene) {
    
    let fighterTex = SKTexture(imageNamed: "shieldRunnerWithShield")
    let fighter = SKSpriteNode(texture: fighterTex)
    
    let ranY = CGFloat(arc4random_uniform(500)) - 250
    fighter.size = CGSize(width: 200, height: 200)
    fighter.physicsBody = SKPhysicsBody(circleOfRadius: 100)
    fighter.position = CGPoint(x: scene.size.width + fighter.size.width, y: (scene.size.height / 2) + ranY)
    fighter.physicsBody?.contactTestBitMask = playerCategory | playerProjectileOne
    fighter.physicsBody?.collisionBitMask = 0
    fighter.physicsBody?.categoryBitMask = shieldRunnerCat
    scene.addChild(fighter)
    
    let enemyMove = SKAction.moveTo(x: -scene.size.width + fighter.size.width, duration: 25)
    let fighterDelay = SKAction.wait(forDuration: 3)
    let sequence = SKAction.sequence([fighterDelay,enemyMove])
    
    fighter.run(sequence)
    
}



class ShittyTank: SKSpriteNode {
    
    init(scene: SKScene) {
        
        let texture = SKTexture(imageNamed: "shittyTank")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        size = CGSize(width: 200, height: 100)
        physicsBody = SKPhysicsBody(rectangleOf: size)
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



class Bomber: SKSpriteNode {
    
    var health = 100
    
    func rocketAttack1(scene: SKScene) {
        
        let rocketTex = SKTexture(imageNamed: "rocket1")
        let rocket = SKSpriteNode(texture: rocketTex)
        
        rocket.size = CGSize(width: 125, height: 25)
        rocket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 50))
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
        
        let stopSeq = SKAction.run(stop)
        let waitQuick = SKAction.wait(forDuration: 0.2)
        let wait = SKAction.wait(forDuration: 0.5)
        let dropSeq = SKAction.run(drop)
        let forwardSeq = SKAction.run(forward)
        let fireSequence = SKAction.sequence([dropSeq,wait,stopSeq,waitQuick,forwardSeq])
        rocket.run(fireSequence)
        
    }
    
    init(scene: SKScene) {
        
        let bomberTex = SKTexture(imageNamed: "shittyPlane")
        super.init(texture: bomberTex, color: UIColor.clear, size: bomberTex.size())
        
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
        
        let fireRocket = SKAction.run { self.rocketAttack1(scene: self.scene!) }
        _ = SKAction.wait(forDuration: 0.6)
        let waitOne = SKAction.wait(forDuration: 1)
        let dropSeq = SKAction.run(drop)
        let slowSeq = SKAction.run(slow)
        let forwardSeq = SKAction.run(forward)
        let moveSequence = SKAction.sequence([dropSeq,waitOne,slowSeq,fireRocket,waitOne,fireRocket,forwardSeq])
        
        run(moveSequence)
        
        //        physicsBody?.applyImpulse(CGVector(dx: 0, dy: -100))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func rocketAttack(scene: SKScene) {
    
    let rocketTex = rockTex
    let rocket = SKSpriteNode(texture: rocketTex)
    
    rocket.size = CGSize(width: 100, height: 50)
    rocket.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 50))
    rocket.physicsBody?.collisionBitMask = 0
    rocket.physicsBody?.contactTestBitMask = playerCategory
    rocket.physicsBody?.categoryBitMask = enemyAttackCategory
    rocket.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    
    rocket.position = Bomber(scene: scene).position
    
    scene.addChild(rocket)
    
    func drop() { rocket.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -20)) }
    func forward() { rocket.physicsBody?.applyImpulse(CGVector(dx: -220, dy: 20)) }
    func stop() { rocket.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20)) }
    
    let stopSeq = SKAction.run(stop)
    let waitQuick = SKAction.wait(forDuration: 0.2)
    let wait = SKAction.wait(forDuration: 0.5)
    let dropSeq = SKAction.run(drop)
    let forwardSeq = SKAction.run(forward)
    let fireSequence = SKAction.sequence([dropSeq,wait,stopSeq,waitQuick,forwardSeq])
    rocket.run(fireSequence)
    
}

