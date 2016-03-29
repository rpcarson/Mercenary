//
//  AC2.swift
//  Mercenary
//
//  Created by Reed Carson on 7/20/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit






func autoCannon1(scene: SKScene) {
    

    
    let projectile = SKSpriteNode(texture: cannonTexture)
    let normalCannon = SKTexture(imageNamed: "gunfire3")
    let uraniumCannon = SKTexture(imageNamed: "uraniumCannon")
    
    
    
    cannonTexture = normalCannon
    
    if uraniumBool ==  true {
        
        cannonTexture = can2
        projectile.size = CGSize(width: 50, height: 16)
        
    }
    if explosiveBool == true {
        
        
        cannonTexture = can3
        projectile.size = CGSize(width: 100, height: 60)

    }

    
    

    let angleX = touchLocationX - player.position.x
    let angleY = touchLocationY - (player.position.y - 64)
    let nodeAngle = atan2(angleY, angleX)

    
    projectile.zRotation = nodeAngle
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
    projectile.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y - 64)
    projectile.physicsBody?.linearDamping = 0
    projectile.physicsBody?.categoryBitMask = playerProjectileOne
    projectile.physicsBody?.contactTestBitMask = enemyCategoryOne
    projectile.physicsBody?.collisionBitMask = 0
    projectile.physicsBody?.usesPreciseCollisionDetection = true
    



        scene.addChild(projectile)
        
    
    

    let X = touchLocationX - player.position.x
    let Y = touchLocationY - (player.position.y - 64)
    let magnitude: CGFloat = sqrt(X*X+Y*Y)
    projectile.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
    
    
    if beamEnabled ==  true {
        
//        projectile.runAction(beamFX)
        
        
//        var beamSize = CGSize(width: 60, height: 2)
//        
//        let beam = SKShapeNode(rectOfSize: beamSize, cornerRadius: 5)
//        
//        beam.physicsBody = SKPhysicsBody(rectangleOfSize: beamSize)
//        beam.fillColor = UIColor(red:0.13, green:0.45, blue:0.93, alpha:1)
//        beam.strokeColor = UIColor(red:0.24, green:0.81, blue:0.96, alpha:1)
//        beam.glowWidth = 6
//        beam.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y - 64)
//        beam.physicsBody?.collisionBitMask = 0
//        beam.physicsBody?.categoryBitMask = playerProjectileOne
//        beam.physicsBody?.contactTestBitMask = enemyCategoryOne
//        beam.zRotation = nodeAngle
//        
//        
//        scene.addChild(beam)
//        
//        beam.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*11, Y/magnitude*11))
//        let remove = SKAction.removeFromParent()
//        let wait = SKAction.waitForDuration(1.0)
//        let removeSequence = SKAction.sequence([wait,remove])
//        beam.runAction(removeSequence)
        
        
        
        
    }
    
    
    let remove = SKAction.removeFromParent()
    let wait = SKAction.waitForDuration(1.0)
    let removeSequence = SKAction.sequence([wait,remove])
    projectile.runAction(removeSequence)
    
    
    
    let muzzleFlashTex = SKTexture(imageNamed: "muzzleFlash2")

    let muzzleFlash1 = SKSpriteNode(texture: muzzleFlashTex)
    muzzleFlash1.size = CGSize(width: 60, height: 75)
    muzzleFlash1.position = CGPoint(x: player.position.x + (player.size.width / 2) - 20, y: player.position.y - 64)
    muzzleFlash1.anchorPoint = CGPoint(x: 0, y: 0.5)
    muzzleFlash1.zRotation = nodeAngle
    
    let waitFlash = SKAction.waitForDuration(0.01)
    let flashRemove = SKAction.sequence([waitFlash,remove])
    
    scene.addChild(muzzleFlash1)
    
    
    muzzleFlash1.runAction(flashRemove)
    
    
    
}