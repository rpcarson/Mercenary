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
    
    var bulletTex: SKTexture!
    var angleX = touchLocationX - player.position.x
    var angleY = touchLocationY - player.position.y
    var nodeAngle = atan2(angleY, angleX)
    bulletTex = SKTexture(imageNamed: "button1red")
    timer = NSTimer.scheduledTimerWithTimeInterval(0.20, target:scene, selector: Selector("gunDelay"), userInfo: nil, repeats: false)
    gunReloaded = false
    let projectile = SKShapeNode(rectOfSize: CGSize(width: 16, height: 8), cornerRadius: 2)
    projectile.zRotation = nodeAngle
    projectile.fillColor = UIColor.yellowColor()
    projectile.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 16, height: 8))
    projectile.position = CGPoint(x: player.position.x + 50, y: player.position.y + 40)
    projectile.physicsBody?.affectedByGravity = false
    projectile.physicsBody?.linearDamping = 0
    projectile.fillTexture = bulletTex
    projectile.glowWidth = 3
    projectile.physicsBody?.categoryBitMask = playerProjectileOne
    projectile.physicsBody?.contactTestBitMask = enemyCategoryOne
    projectile.physicsBody?.collisionBitMask = 0
    projectile.physicsBody?.usesPreciseCollisionDetection = true
  
    scene.addChild(projectile)
    
    let X = touchLocationX - player.position.x
    let Y = touchLocationY - player.position.y
    var magnitude: CGFloat = sqrt(X*X+Y*Y)
    projectile.physicsBody?.applyImpulse(CGVectorMake(X/magnitude*7, Y/magnitude*7))
    
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