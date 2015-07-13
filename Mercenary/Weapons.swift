//
//  Weapons.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit






var autoCannonDamage: Int = 5
func autoCannon(scene: SKScene) {
    
    let soundDelay = SKAction.waitForDuration(0.02)
    let gunSFX = SKAction.playSoundFileNamed("basicGun.wav", waitForCompletion: false)
    let sfxSequence = SKAction.sequence([gunSFX,soundDelay])
    
    

    var bulletTex: SKTexture!
    var angleX = touchLocationX - player.position.x
    var angleY = touchLocationY - player.position.y
    var nodeAngle = atan2(angleY, angleX)
    bulletTex = SKTexture(imageNamed: "gunfire1")
    timer = NSTimer.scheduledTimerWithTimeInterval(0.12, target:scene, selector: Selector("gunDelay"), userInfo: nil, repeats: false)
    gunReloaded = false
    let projectile = SKSpriteNode(texture: bulletTex)
    projectile.zRotation = nodeAngle
    projectile.size = CGSize(width: 30, height: 10)
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
    projectile.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y)
    projectile.physicsBody?.affectedByGravity = false
    projectile.physicsBody?.linearDamping = 0
    projectile.physicsBody?.categoryBitMask = playerProjectileOne
    projectile.physicsBody?.contactTestBitMask = enemyCategoryOne
    projectile.physicsBody?.collisionBitMask = 0
    projectile.physicsBody?.usesPreciseCollisionDetection = true
  
    scene.addChild(projectile)
    
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
//    muzzleFlash.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y - (player.size.height / 2))

    muzzleFlash.position = CGPoint(x: player.position.x + (player.size.width / 2), y: player.position.y)


    
    
    muzzleFlash.anchorPoint = CGPoint(x: 0, y: 0.5)
    muzzleFlash.zRotation = nodeAngle
//    muzzleFlash.zPosition = 20
    
    let flashBloc = SKAction.runBlock( {scene.addChild(muzzleFlash)})
    
    let waitFlash = SKAction.waitForDuration(0.01)
    let flashRemove = SKAction.sequence([waitFlash,remove])
    
    scene.addChild(muzzleFlash)

    
    let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND
    dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
        
muzzleFlash.runAction(flashRemove)
            muzzleFlash.runAction(sfxSequence)

    })
    
//    muzzleFlash.runAction(flashRemove)

    
    
    
}

class Chaingun: SKSpriteNode {
    
    init(scene: SKScene) {
        
        let texture = SKTexture(imageNamed: "redButton1")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        size = CGSize(width: 20, height: 10)
        
        
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    
}










func basicShotgun(scene: SKScene) {
    
   var ranX = CGFloat(arc4random_uniform(20))
    var ranY = CGFloat(arc4random_uniform(40))
    
//    println(ranX)
//    println(ranY)
    
    
    timer = NSTimer.scheduledTimerWithTimeInterval(1.2, target:scene, selector: Selector("gunDelay"), userInfo: nil, repeats: false)
    gunReloaded = false
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