//
//  Weapons.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


let uraniumShot = SKTexture(imageNamed: "uraniumShot")
var cannonColor: UIColor = UIColor.yellowColor()
var normalCannnon = UIColor.yellowColor()
//var uraniumCannon = UIColor(red:0.25, green:0.92, blue:0.46, alpha:1)
var uraniumDam: Int = 0
var explosiveDam: Int = 0
var doubleShotBool: Bool = true
var tripleShotBool: Bool = false
var uraniumBool: Bool = true
var explosiveBool: Bool = false

var beamEnabled: Bool = false
var beamDamage: Int = 0


var autoCannonDamage: Int = 0
var autoBaseDamage: Int = 5


var cannonTexture: SKTexture!

func autoCannon(scene: SKScene) {
    
    if bugzOn {
    println("AC Dam = \(autoCannonDamage)")
    }
    
    
    let projectile = SKSpriteNode(texture: cannonTexture)
    let projectile1 = SKSpriteNode(texture: cannonTexture)

    
//    let projectile = SKShapeNode(rectOfSize: CGSize(width: 25, height: 2))
//    let projectile1 = SKShapeNode(rectOfSize: CGSize(width: 25, height: 2))
   let normalCannon = SKTexture(imageNamed: "gunfire3")
    let uraniumCannon = SKTexture(imageNamed: "uraniumCannon")
    
    cannonTexture = normalCannon
    
    if uraniumBool ==  true {
        
        cannonTexture = uraniumShot
        projectile1.size = CGSize(width: 50, height: 16)
        projectile.size = CGSize(width: 50, height: 16)
        
    }
    
//    let projectile = SKSpriteNode(imageNamed: "gunfire3")
//    let projectile1 = SKSpriteNode(imageNamed: "gunfire3")
    if beamEnabled ==  true {
        
        beamDamage = 2
    }
    
    
    autoCannonDamage = autoBaseDamage + uraniumDam + explosiveDam + beamDamage
    
    
    let soundDelay = SKAction.waitForDuration(0.02)
    let sfxSequence = SKAction.sequence([gunFX,soundDelay])
    
    var bulletTex = SKTexture(imageNamed: "gunfire2")
    var bulletTex1 = SKTexture(imageNamed: "gunfire1")
    var angleX = touchLocationX - player.position.x
    var angleY = touchLocationY - player.position.y
    var nodeAngle = atan2(angleY, angleX)
   

//
//    
//    projectile.fillColor = cannonColor
//    projectile.strokeColor = cannonColor
//    projectile.lineWidth = 0.5
//    projectile1.lineWidth = 0.5
//    
//    projectile1.fillColor = cannonColor
//    projectile1.strokeColor = cannonColor
    
    projectile.zRotation = nodeAngle
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
    projectile.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y + 55)
    projectile.physicsBody?.linearDamping = 0
    projectile.physicsBody?.categoryBitMask = playerProjectileOne
    projectile.physicsBody?.contactTestBitMask = enemyCategoryOne
    projectile.physicsBody?.collisionBitMask = 0
    projectile.physicsBody?.usesPreciseCollisionDetection = true
  
    if uraniumBool == true {
        uraniumDam = 2
//        cannonColor = uraniumCannon
        
    }
    
    if (doubleShotBool == false) && (tripleShotBool == false) {
    
            scene.addChild(projectile)
    }
    
    
    if doubleShotBool == true {
        
        projectile.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y + 55)

        let shotDelay = SKAction.waitForDuration(0.3)
        let fire = SKAction.runBlock({ scene.addChild(projectile) } )
        
//        projectile.runAction(SKAction.sequence([shotDelay,fire]))
        
        scene.addChild(projectile)
        
        projectile1.zRotation = nodeAngle
        projectile1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
        projectile1.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y - 55)
        projectile1.physicsBody?.linearDamping = 0
        projectile1.physicsBody?.categoryBitMask = playerProjectileOne
        projectile1.physicsBody?.contactTestBitMask = enemyCategoryOne
        projectile1.physicsBody?.collisionBitMask = 0
        projectile1.physicsBody?.usesPreciseCollisionDetection = true
        
        
        let fire1 = SKAction.runBlock( { scene.addChild(projectile1) } )
        
        
//        scene.addChild(projectile1)
        
        
        
    }
    
    
    projectile.runAction(SKAction.playSoundFileNamed("basicGunV2.wav", waitForCompletion: false))
    
    
    let X = touchLocationX - player.position.x
    let Y = touchLocationY - (player.position.y + 55)
    let Y2 = touchLocationY - (player.position.y - 55)
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    projectile.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
    projectile1.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y2/magnitude*11))
    
    
    
    let remove = SKAction.removeFromParent()
    let wait = SKAction.waitForDuration(1.0)
    let removeSequence = SKAction.sequence([wait,remove])
    projectile.runAction(removeSequence)
    projectile1.runAction(removeSequence)
    
    var muzzleFlashTex = SKTexture(imageNamed: "muzzleFlash2")
    let muzzleFlash = SKSpriteNode(texture: muzzleFlashTex)
    muzzleFlash.size = CGSize(width: 60, height: 75)
    muzzleFlash.position = CGPoint(x: player.position.x + (player.size.width / 2) - 20, y: player.position.y + 55)
    muzzleFlash.anchorPoint = CGPoint(x: 0, y: 0.5)
    muzzleFlash.zRotation = nodeAngle
    
    
//    let muzzleFlash1 = SKSpriteNode(texture: muzzleFlashTex)
//    muzzleFlash1.size = CGSize(width: 60, height: 75)
//    muzzleFlash1.position = CGPoint(x: player.position.x + (player.size.width / 2) - 20, y: player.position.y - 55)
//    muzzleFlash1.anchorPoint = CGPoint(x: 0, y: 0.5)
//    muzzleFlash1.zRotation = nodeAngle
    
    
    
    
    
    
    let waitFlash = SKAction.waitForDuration(0.01)
    let flashRemove = SKAction.sequence([waitFlash,remove])
    
//    scene.addChild(muzzleFlash1)
    scene.addChild(muzzleFlash)

//    muzzleFlash1.runAction(flashRemove)

    muzzleFlash.runAction(flashRemove)


    
    
}

var beamCannonDamage: Int = 10
func beamCannon(scene: SKScene) {
    
    
    var angleX = touchLocationX - player.position.x
    var angleY = touchLocationY - player.position.y
    var nodeAngle = atan2(angleY, angleX)
    
    
    var beamSize = CGSize(width: 60, height: 2)
    
    let beam = SKShapeNode(rectOfSize: beamSize, cornerRadius: 5)
    
    beam.physicsBody = SKPhysicsBody(rectangleOfSize: beamSize)
    beam.fillColor = UIColor(red:0.13, green:0.45, blue:0.93, alpha:1)
    beam.strokeColor = UIColor(red:0.24, green:0.81, blue:0.96, alpha:1)
    beam.glowWidth = 6
    beam.position = player.position
    beam.physicsBody?.collisionBitMask = 0
    beam.physicsBody?.categoryBitMask = playerProjectileOne
    beam.physicsBody?.contactTestBitMask = enemyCategoryOne
    beam.zRotation = nodeAngle
    
    
    scene.addChild(beam)
    
    
    
    
    let X = touchLocationX - player.position.x
    let Y = touchLocationY - player.position.y
  
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    
    
    beam.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
    
    
//    beam.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 0))
    
    
    let wait = SKAction.waitForDuration(2)
    let remove = SKAction.removeFromParent()
    let seq = SKAction.sequence([wait,remove])
    
    beam.runAction(seq)
    
    beam.runAction(SKAction.playSoundFileNamed("laserFireV2.wav", waitForCompletion: false))
    
    
    
}











func basicShotgun(scene: SKScene) {
    
   var ranX = CGFloat(arc4random_uniform(20))
    var ranY = CGFloat(arc4random_uniform(40))
    
    
    let pellet = SKShapeNode(circleOfRadius: 6)
    pellet.fillColor = UIColor(red:0.98, green:0.41, blue:0.06, alpha:1)
    pellet.physicsBody = SKPhysicsBody(circleOfRadius: 6)
    pellet.physicsBody?.affectedByGravity = false
    pellet.physicsBody?.linearDamping = 0
    pellet.position = player.position
    pellet.physicsBody?.collisionBitMask = 0
    scene.addChild(pellet)
    pellet.physicsBody?.applyImpulse(CGVectorMake((touchLocationX - player.position.x) / 100, (touchLocationY - player.position.y) / 100))
    
    let pellet1 = SKShapeNode(circleOfRadius: 6)
    pellet1.fillColor = UIColor(red:0.88, green:0.41, blue:0.06, alpha:1)
    pellet1.physicsBody = SKPhysicsBody(circleOfRadius: 6)
    pellet1.physicsBody?.affectedByGravity = false
    pellet1.physicsBody?.linearDamping = 0
    pellet1.position = CGPoint(x: player.position.x + 15, y: player.position.y - 15)
    pellet1.physicsBody?.collisionBitMask = 0
    scene.addChild(pellet1)
    pellet1.physicsBody?.applyImpulse(CGVectorMake((touchLocationX - player.position.x) / 100, (touchLocationY - player.position.y) / 100))
    
    let pellet2 = SKShapeNode(circleOfRadius: 6)
    pellet2.fillColor = UIColor(red:0.88, green:0.41, blue:0.06, alpha:1)
    pellet2.physicsBody = SKPhysicsBody(circleOfRadius: 6)
    pellet2.physicsBody?.affectedByGravity = false
    pellet2.physicsBody?.linearDamping = 0
    pellet2.position = CGPoint(x: player.position.x + 30, y: player.position.y + 30)
    pellet2.physicsBody?.collisionBitMask = 0
    scene.addChild(pellet2)
    pellet2.physicsBody?.applyImpulse(CGVectorMake((touchLocationX - player.position.x) / 100, (touchLocationY - player.position.y) / 100))
    
    let pellet3 = SKShapeNode(circleOfRadius: 6)
    pellet3.fillColor = UIColor(red:0.88, green:0.41, blue:0.06, alpha:1)
    pellet3.physicsBody = SKPhysicsBody(circleOfRadius: 6)
    pellet3.physicsBody?.affectedByGravity = false
    pellet3.physicsBody?.linearDamping = 0
    pellet3.position = CGPoint(x: player.position.x - 15, y: player.position.y + 15)
    pellet3.physicsBody?.collisionBitMask = 0
    scene.addChild(pellet3)
    pellet3.physicsBody?.applyImpulse(CGVectorMake((touchLocationX - player.position.x) / 100, (touchLocationY - player.position.y) / 100))
    
    let pellet4 = SKShapeNode(circleOfRadius: 6)
    pellet4.fillColor = UIColor(red:0.88, green:0.41, blue:0.06, alpha:1)
    pellet4.physicsBody = SKPhysicsBody(circleOfRadius: 6)
    pellet4.physicsBody?.affectedByGravity = false
    pellet4.physicsBody?.linearDamping = 0
    pellet4.position = CGPoint(x: player.position.x + 30, y: player.position.y)
    pellet4.physicsBody?.collisionBitMask = 0
    scene.addChild(pellet4)
    pellet4.physicsBody?.applyImpulse(CGVectorMake((touchLocationX - player.position.x) / 100, (touchLocationY - player.position.y) / 100))
    
    
    
    
    
}