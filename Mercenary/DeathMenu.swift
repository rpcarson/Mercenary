//
//  DeathMenu.swift
//  Mercenary
//
//  Created by Reed Carson on 7/17/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


func autoCannonOrig(scene: SKScene) {
    
    let soundDelay = SKAction.waitForDuration(0.02)
    let gunSFX = SKAction.playSoundFileNamed("basicGun.wav", waitForCompletion: false)
    let sfxSequence = SKAction.sequence([gunSFX,soundDelay])
    
    var bulletTex: SKTexture!
    var angleX = touchLocationX - player.position.x
    var angleY = touchLocationY - player.position.y
    var nodeAngle = atan2(angleY, angleX)
    
    bulletTex = SKTexture(imageNamed: "gunfire1")
    let projectile = SKSpriteNode(texture: bulletTex)
    projectile.zRotation = nodeAngle
    projectile.size = CGSize(width: 30, height: 10)
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
    projectile.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y)
    projectile.physicsBody?.linearDamping = 0
    projectile.physicsBody?.categoryBitMask = playerProjectileOne
    projectile.physicsBody?.contactTestBitMask = enemyCategoryOne
    projectile.physicsBody?.collisionBitMask = 0
    projectile.physicsBody?.usesPreciseCollisionDetection = true
    
    
    scene.addChild(projectile)
    
    projectile.runAction(SKAction.playSoundFileNamed("basicGunV2.wav", waitForCompletion: false))
    
    
    let X = touchLocationX - player.position.x
    let Y = touchLocationY - player.position.y
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    projectile.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*9, Y/magnitude*9))
    
    let remove = SKAction.removeFromParent()
    let wait = SKAction.waitForDuration(1.0)
    let removeSequence = SKAction.sequence([wait,remove])
    projectile.runAction(removeSequence)
    
    var muzzleFlashTex = SKTexture(imageNamed: "muzzleFlashPixel")
    let muzzleFlash = SKSpriteNode(texture: muzzleFlashTex)
    muzzleFlash.size = CGSize(width: 60, height: 75)
    muzzleFlash.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y)
    muzzleFlash.anchorPoint = CGPoint(x: 0, y: 0.5)
    muzzleFlash.zRotation = nodeAngle
    
    let flashBloc = SKAction.runBlock( {scene.addChild(muzzleFlash)})
    let waitFlash = SKAction.waitForDuration(0.01)
    let flashRemove = SKAction.sequence([waitFlash,remove])
    
    //    scene.addChild(muzzleFlash)
    
    
    //    let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND
    //    dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
    //
    //
    //        muzzleFlash.runAction(flashRemove)
    //
    //            muzzleFlash.runAction(sfxSequence)
    //
    //    })
    
    //    muzzleFlash.runAction(flashRemove)
    
    //    muzzleFlash.runAction(flashRemove)
    //
    //    muzzleFlash.runAction(sfxSequence)
    
    
}
