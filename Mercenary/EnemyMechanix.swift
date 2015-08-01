//
//  EnemyMechanix.swift
//  Mercenary
//
//  Created by Reed Carson on 7/13/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit






func layMines(scene: SKScene, point: CGPoint) {
    
    let mine = Mine(scene: scene)
    mine.position = point
    
    scene.addChild(mine)
    
    mine.physicsBody?.applyTorque(1.2)
    mine.physicsBody?.applyImpulse(CGVector(dx: -30, dy: 0))
    
    let wait = SKAction.waitForDuration(25, withRange: 5)
    let explode = SKAction.runBlock(  { explodeFunc3(scene, mine) } )
    let remove = SKAction.removeFromParent()
    mine.runAction(SKAction.sequence([wait,explode,remove]))
}






func bargeBarrage(scene: SKScene, shotOrigin: ArtillaryBarge) {
    
    let shot = SKShapeNode(circleOfRadius: 15)
    
    shot.position = shotOrigin.position
    shot.fillColor = UIColor.yellowColor()
    shot.physicsBody = SKPhysicsBody(circleOfRadius: 15)
    shot.physicsBody?.contactTestBitMask = playerCategory
    shot.physicsBody?.categoryBitMask = enemyBulletCat
    shot.physicsBody?.collisionBitMask = 0
    shot.position = shotOrigin.position
    shot.physicsBody?.linearDamping = 0
    shot.glowWidth = 5
    
    scene.addChild(shot)
        
//    for point in barrageArray { println(point.hashValue) }
//    for point in barrageArray { println(point.position) }
    
    let X = player.position.x - shotOrigin.position.x
    let Y = player.position.y - shotOrigin.position.y
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    shot.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*5, Y/magnitude*5))
    
    
shot.runAction(SKAction.sequence([SKAction.waitForDuration(3),SKAction.removeFromParent()]))
    
//    for point in barrageArray {
//        
//        let explosion = SKSpriteNode(imageNamed: "crappyExplosion2")
//
//        explosion.position = point.position
//        explosion.size = CGSize(width: 100, height: 100)
//        
//    let shotLife = SKAction.waitForDuration(2)
//    let explode = SKAction.runBlock( { scene.addChild(explosion) } )
//    let remove =  SKAction.removeFromParent()
//        
//    shot.runAction(explode)
//    }
}


func bargeSpawn(scene: SKScene) {
    
    let enemy = ArtillaryBarge(scene: scene)
    enemy.position = CGPoint(x: scene.size.width + enemy.size.width, y: enemy.size.height)
    
    scene.addChild(enemy)
    
    enemy.physicsBody?.linearDamping = 1
    let delay = SKAction.waitForDuration(1)
    let flup = SKAction.runBlock({enemy.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 15))})
    let flud = SKAction.runBlock({enemy.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -15))})
    let floatSequence = SKAction.sequence([flup,delay,flud,flud,delay,flup])
    
//    enemy.runAction(SKAction.repeatActionForever(floatSequence))
    
    let move = SKAction.moveToX( -scene.size.width + enemy.size.width, duration: 12)
    let remove = SKAction.removeFromParent()
    
    enemy.runAction(SKAction.sequence([move,remove]))
    
    
}


func fighterJetWave(scene: SKScene, spawnPoint: CGPoint, movePoint: UInt32) {
    
    let enemy = WeakJet(scene: scene)
    
    let ranPointY = CGFloat(arc4random_uniform(100))
    
    
    enemy.position = spawnPoint
    scene.addChild(enemy)
    
    let move = SKAction.moveTo(CGPoint(x: -scene.size.width + enemy.size.width, y: scene.size.height * (CGFloat(movePoint) / 100)), duration: 12)
    let remove = SKAction.removeFromParent()
    let sequence = SKAction.sequence([move,remove])
    
    enemy.runAction(sequence)
    
    
    
}




func littionMinionSpawn(scene: SKScene, spawnPoint: CGPoint) {
    
   
    
    
    var randomizer = arc4random_uniform(250)
    minionRandomizer = randomizer
    
    let enemy = LittleMinion(scene: scene)
    enemy.position = spawnPoint
    
    scene.addChild(enemy)
    
    
    let move = SKAction.moveToX( -scene.size.width + enemy.size.width, duration: 9)
    let remove = SKAction.removeFromParent()
    
    enemy.runAction(SKAction.sequence([move,remove]))
    
    
}



func minionShot(scene: SKScene, enemyShip: LittleMinion) {
   
    
    let shot = SKShapeNode(rectOfSize: CGSize(width: 15, height: 4))
    
    shot.position = enemyShip.position
    shot.fillColor = UIColor.yellowColor()
    shot.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 15, height: 4))
    shot.physicsBody?.contactTestBitMask = playerCategory
    shot.physicsBody?.categoryBitMask = enemyBulletCat
    shot.physicsBody?.collisionBitMask = 0
    
    scene.addChild(shot)
    
    let movement = SKAction.moveToX(-scene.size.width, duration: 5)
    let remove = SKAction.removeFromParent()
    shot.runAction(SKAction.sequence([movement,remove]))  
    
    
    
}

func strafeJetSpawn(scene: SKScene) {
    
    var randomizerStrafe = arc4random_uniform(350)
    spawnRandomizer = randomizerStrafe
    
    let ranY = CGFloat(arc4random_uniform(50)) - 25
    
    let enemy = StrafeJet(scene: scene)
    enemy.position = CGPoint(x: scene.size.width + enemy.size.width, y: scene.size.height - (enemy.size.height * 2) + ranY)
    
    scene.addChild(enemy)
    
    
    let move = SKAction.moveToX( -scene.size.width + enemy.size.width, duration: 16)
    let remove = SKAction.removeFromParent()
    
    enemy.runAction(SKAction.sequence([move,remove]))
    

    
}


func strafeJetProjectile(scene: SKScene, enemyShip: StrafeJet) {
    
 
    let bullet = SKShapeNode(circleOfRadius: 5)
    
    bullet.physicsBody = SKPhysicsBody(circleOfRadius: 10)
    bullet.physicsBody?.collisionBitMask = 0
    bullet.physicsBody?.contactTestBitMask = playerCategory
    bullet.physicsBody?.categoryBitMask = enemyBulletCat
    bullet.position = CGPoint(x: enemyShip.position.x - 20, y: enemyShip.position.y - 10)
    bullet.fillColor = UIColor.yellowColor()
    bullet.strokeColor = UIColor.redColor()
    bullet.glowWidth = 3
    
    scene.addChild(bullet)
    
    
    let X = player.position.x - bullet.position.x
    let Y = player.position.y - bullet.position.y
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    bullet.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*5, Y/magnitude*5))
    
  
    let remove = SKAction.removeFromParent()
    let wait = SKAction.waitForDuration(4.0)
    bullet.runAction(SKAction.sequence([wait,remove]))
    
    
}



func weakJetSpawn(scene: SKScene) {
    
    var randomizer = arc4random_uniform(300)
    jetRandomizer = randomizer
    
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
    
    rocket.physicsBody?.applyImpulse(CGVector(dx: -75, dy: 0))
    
    let remove = SKAction.removeFromParent()
    let wait = SKAction.waitForDuration(2.0)
        rocket.runAction(SKAction.sequence([wait,remove]))
    
}




