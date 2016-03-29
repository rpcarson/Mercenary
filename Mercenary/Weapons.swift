//
//  Weapons.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


var cannonColor: UIColor = UIColor.yellowColor()
var normalCannnon = UIColor.yellowColor()
var uraniumDam: Int = 0
var explosiveDam: Int = 0
var doubleShotBool: Bool = true
var tripleShotBool: Bool = false
var uraniumBool: Bool = false
var explosiveBool: Bool = false

var beamEnabled: Bool = false
var beamDamage: Int = 0


var autoCannonDamage: Int = 0
var autoBaseDamage: Int = 5


var cannonTexture: SKTexture!

func autoCannon(scene: SKScene) {
    
    
    let angleX = touchLocationX - player.position.x
    let angleY = touchLocationY - (player.position.y + 20)
    let nodeAngle = atan2(angleY, angleX)
    
    
    
    if oreCount > 3 { uraniumBool = true }
    if oreCount > 9 { beamEnabled = true }
    if oreCount > 6 { explosiveBool =  true }
    
    print("AC Dam = \(autoCannonDamage)")

    
    let projectile = SKSpriteNode(texture: cannonTexture)
   let normalCannon = can1
    let uraniumCannon = can2
    cannonTexture = normalCannon
    
    if uraniumBool ==  true {
        
        uraniumDam = 2
        cannonTexture = can2
        projectile.size = CGSize(width: 50, height: 16)
        
    }
    
    if explosiveBool == true {
        
        explosiveDam = 2

        cannonTexture = can3
        projectile.size = CGSize(width: 100, height: 60)
        
    }

 
    
    
    autoCannonDamage = autoBaseDamage + uraniumDam + explosiveDam + beamDamage
    
    
  
   

    
    projectile.zRotation = nodeAngle
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
    projectile.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y + 20)
    projectile.physicsBody?.linearDamping = 0
    projectile.physicsBody?.categoryBitMask = playerProjectileOne
    projectile.physicsBody?.contactTestBitMask = enemyCategoryOne
    projectile.physicsBody?.collisionBitMask = 0
    projectile.physicsBody?.usesPreciseCollisionDetection = true
  
    if uraniumBool == true {
        uraniumDam = 2
        
    }
        
        scene.addChild(projectile)
    
    projectile.runAction(gunFX)
    
    
    let X = touchLocationX - player.position.x
    let Y = touchLocationY - (player.position.y + 20)
    let magnitude: CGFloat = sqrt(X*X+Y*Y)
    projectile.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
    
    let remove = SKAction.removeFromParent()
    let wait = SKAction.waitForDuration(1.0)
    let removeSequence = SKAction.sequence([wait,remove])
    projectile.runAction(removeSequence)
    
    
    var muzzleFlashTex = flashTex
    let muzzleFlash = SKSpriteNode(texture: flashTex)
    muzzleFlash.size = CGSize(width: 60, height: 75)
    muzzleFlash.position = CGPoint(x: player.position.x + (player.size.width / 2) - 20, y: player.position.y + 20)
    muzzleFlash.anchorPoint = CGPoint(x: 0, y: 0.5)
    muzzleFlash.zRotation = nodeAngle
    
    
    let waitFlash = SKAction.waitForDuration(0.01)
    let flashRemove = SKAction.sequence([waitFlash,remove])
    
    scene.addChild(muzzleFlash)
    muzzleFlash.runAction(flashRemove)


    if beamEnabled ==  true {
        
//        projectile.runAction(beamFX)
        beamDamage = 3
        
//        var beamSize = CGSize(width: 60, height: 2)
//        
//        let beam = SKShapeNode(rectOfSize: beamSize, cornerRadius: 5)
//        
//        beam.physicsBody = SKPhysicsBody(rectangleOfSize: beamSize)
//        beam.fillColor = UIColor(red:0.13, green:0.45, blue:0.93, alpha:1)
//        beam.strokeColor = UIColor(red:0.24, green:0.81, blue:0.96, alpha:1)
//        beam.glowWidth = 6
//        beam.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y + 20)
//        beam.physicsBody?.collisionBitMask = 0
//        beam.physicsBody?.categoryBitMask = playerProjectileOne
//        beam.physicsBody?.contactTestBitMask = enemyCategoryOne
//        beam.zRotation = nodeAngle
//        
//        
//        scene.addChild(beam)
//        
//        beam.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
//        
//        let remove = SKAction.removeFromParent()
//        let wait = SKAction.waitForDuration(1.0)
//        let removeSequence = SKAction.sequence([wait,remove])
//        beam.runAction(removeSequence)
        
        
    }




}


func beamCannon(scene: SKScene) {
    
    
    
    let X = touchLocationX - player.position.x
    let Y = touchLocationY - player.position.y
    let nodeAngle = atan2(Y, X)
    
    
    let beamSize = CGSize(width: 60, height: 2)
    
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
    
    
    
   
  
    let magnitude: CGFloat = sqrt(X*X+Y*Y)
    
    
    beam.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
    
    
    let wait = SKAction.waitForDuration(1.5)
    let remove = SKAction.removeFromParent()
    let seq = SKAction.sequence([wait,remove])
    
    beam.runAction(seq)
    
    beam.runAction(beamFX)
    
    
    
}

