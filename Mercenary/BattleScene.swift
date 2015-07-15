//
//  GameScene.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import SpriteKit



var playerAlive: Bool = true
var playerHealth: Int!
var currentScore: Int = 0
var oreCount: Int = 0
var scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
let healthLabel = SKLabelNode(fontNamed:"HelveticaNeue-Light")
let oreLabel = SKLabelNode(fontNamed:"HelveticaNeue-Light")


var pauseButton: SKSpriteNode!

var timer: NSTimer!

var gunReloaded: Bool = true
var gunBool: Bool = false

var player: SKSpriteNode!

var touchLocationX: CGFloat!
var touchLocationY: CGFloat!

var moveDown: SKSpriteNode!
var moveUp: SKSpriteNode!
var gunZone: SKSpriteNode!

var playerUp: Bool = false
var playerDown: Bool = false


//let intro = SKAction.playSoundFileNamed("LevelOneIntroLoop.mp3", waitForCompletion: true)
//let mainLoop = SKAction.playSoundFileNamed("LevelOneMainLoop.mp3", waitForCompletion: true)
//let loopMain = SKAction.repeatActionForever(mainLoop)
//let musicSequence = SKAction.sequence([intro,mainLoop])
//

let music = SKAction.playSoundFileNamed("IntroThemeAughtV2.mp3", waitForCompletion: true)
let loopMusic = SKAction.repeatActionForever(music)


class BattleScene: SKScene, SKPhysicsContactDelegate {
   

    
    override func didMoveToView(view: SKView) {
        
        
        
        initializePlayer()
        initializeBackground()
        initializeLabels()
        
        playerHealth = 10000

        
        
        //                runAction(loopMusic)
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (SmallAsteroidMechanix(self))
            },
            SKAction.waitForDuration(6, withRange: 2)
            ])))
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (LargeAsteroidMechanix(self))
            },
            SKAction.waitForDuration(12, withRange: 5)
            ])))
        
        
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (weakJetSpawn(self))
            },
            SKAction.waitForDuration(6, withRange: 4)
            ])))
        
                
        enemyFighter(self)
        
        
        moveDown = childNodeWithName("moveDown") as? SKSpriteNode
        moveUp = childNodeWithName("moveUp") as? SKSpriteNode
        gunZone = childNodeWithName("gunZone") as? SKSpriteNode
        
        moveDown.hidden = true
        moveUp.hidden = true
        gunZone.hidden = true
        
        pauseButton = childNodeWithName("pauseButton") as? SKSpriteNode
        pauseButton.zPosition = 10
        pauseButton.hidden = true
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
    
    
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        
        var firstBody = contact.bodyA.node
        var secondBody = contact.bodyB.node
        
        var firstMask = contact.bodyA.categoryBitMask
        var secondMask = contact.bodyB.categoryBitMask
        
        let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
        let enemy = secondMask == smallRockCat ? secondBody : firstBody
        
        let player = (firstMask == playerCategory)
        let player1 = (secondMask == playerCategory)
        
        if player && (secondMask == smallRockCat) || player1 && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody : firstBody

            println("small rock impact")
            playerHealth = playerHealth - 20
            println("player health = \(playerHealth)")
            enemy?.removeFromParent()
            
        }
        if player && (secondMask == largeRockCat) || player1 && (firstMask == largeRockCat) {
            
            let enemy = secondMask == largeRockCat ? secondBody : firstBody

            oreDrop(self)
            
            println("large rock impact")
            playerHealth = playerHealth - 100
            println("player health = \(playerHealth)")
        
        }
        
        if player && (secondMask == enemyRocketCat) || player1 && (firstMask == enemyRocketCat) {
            
            let enemy = secondMask == enemyRocketCat ? secondBody : firstBody

            
            println("rocket contact")
            enemy?.removeFromParent()
            playerHealth = playerHealth - 50
            println("player health = \(playerHealth)")
        }
        
        if player && (secondMask == enemyCategoryOne) || player1 && (firstMask == enemyCategoryOne) {
            
            let enemy = secondMask == enemyCategoryOne ? secondBody : firstBody

            
            println("enemy jet contact")
            enemy?.removeFromParent()
            playerHealth = playerHealth - 50
            println("player health = \(playerHealth)")
        }
        
        
        
        if (firstMask == playerProjectileOne) && (secondMask == smallRockCat) || (secondMask == playerProjectileOne) && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            
//            oreDrop(theScene)
            
            println(enemy?.health)
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0
                
            {
                
//                oreDrop(self.scene!)
//                dropOre(self, enemy!)
                
                enemy?.removeFromParent()
                
                currentScore = currentScore + 25
                
            }
            
        }
        if (firstMask == playerProjectileOne) && (secondMask == largeRockCat) || (secondMask == playerProjectileOne) && (firstMask == largeRockCat) {
            
            let enemy = secondMask == largeRockCat ? secondBody as? LargeAsteroid : firstBody as? LargeAsteroid
            
            println(enemy?.health)
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0
                
            {
                
                
                
                enemy?.removeFromParent()
                
                currentScore = currentScore + 100
                
           
            }
        }
        
       
        if (firstMask == playerProjectileOne) && (secondMask == enemyCategoryOne) || (secondMask == playerProjectileOne) && (firstMask == enemyCategoryOne) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == enemyCategoryOne ? secondBody as? WeakJet : firstBody as? WeakJet
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            println(enemy?.health)
            
            if enemy?.health <= 10 {
                
//                enemy?.physicsBody?.applyImpulse(CGVectorMake(-40, -200))
                enemy?.physicsBody?.allowsRotation = true
                enemy?.physicsBody?.angularVelocity = 1
                
            }
            
            if enemy?.health <= 0 {

                enemy?.removeFromParent()
                currentScore += 50

            }
        }
    }
    
    func gunDelay() { gunReloaded = true }
    
    
    
    
    func playerDeathScreen() {
        
        
        let darkOverlay = SKSpriteNode(color: UIColor.blackColor(), size: scene!.size)
        darkOverlay.anchorPoint = CGPointZero
        darkOverlay.alpha = 0.0
        addChild(darkOverlay)
        let fade = SKAction.fadeAlphaTo(0.5, duration: 3)
        let textFade = SKAction.fadeInWithDuration(3)
        
        darkOverlay.runAction(fade)
        
        let gameoverLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
        let tryagainLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
        let returnMenuLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
        
        gameoverLabel.text = "Game Over"
        gameoverLabel.fontSize = 100
        gameoverLabel.alpha = 0.0
        gameoverLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.75)
        tryagainLabel.text = "Restart Mission"
        tryagainLabel.fontSize = 60
        tryagainLabel.alpha = 0.0
        tryagainLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.5)
        returnMenuLabel.text = "Main Menu"
        returnMenuLabel.fontSize = 60
        returnMenuLabel.alpha = 0.0
        returnMenuLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height * 0.25)
        
        addChild(tryagainLabel)
        addChild(returnMenuLabel)
        addChild(gameoverLabel)
        gameoverLabel.runAction(textFade)
        tryagainLabel.runAction(textFade)
        returnMenuLabel.runAction(textFade)
        
        let goIn = SKAction.fadeOutWithDuration(2)
        let goOut = SKAction.fadeInWithDuration(2)
        gameoverLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([goIn,goOut])))
        
         let retryButton = SKSpriteNode(color: UIColor.yellowColor(), size: CGSize(width: 250, height: 100))
        retryButton.position = tryagainLabel.position
//        addChild(retryButton)
        
        
        let abortButton = SKSpriteNode(color: UIColor.yellowColor(), size: CGSize(width: 250, height: 100))
        abortButton.position = returnMenuLabel.position
//        addChild(abortButton)
        
        
        
        
//        let pause = SKAction.runBlock( {self.scene?.paused = true} )
//        let delay = SKAction.waitForDuration(3)
//        let pauseSequence = SKAction.sequence([delay,pause])
        
//        runAction(pauseSequence)
        

    }
    
    var bulletDelay = 0
    override func update(currentTime: CFTimeInterval) {
        
        BGScroll()
        BGScroll2()
        
        bulletDelay++
        
        healthLabel.text = "\(playerHealth)"
        scoreLabel.text = "\(currentScore)"

        
        if playerHealth <= 0 {
            
            if playerAlive == false { return }
            
//            scene?.paused = true
            
            println("u dide really bad")

            player.removeFromParent()
            
            playerAlive = false
            
            playerDeathScreen()

        }
        
        
        if (playerUp == true) && (player.position.y < frame.height - 70) {
            player.position.y = player.position.y + 15
        }
        if (playerDown == true) && (player.position.y > frame.height - frame.height + 70) {
            player.position.y = player.position.y - 15
        }
        
//        if helicopterOneAlive == true && bulletDelay > 15 {
//            helicopterAttack(self)
//            bulletDelay = 0
//            
//        }
//        if (gunBool == true) && (gunReloaded == true) {
//            autoCannon(self)
//        }
        
        if (gunBool == true) && (bulletDelay > 2) {
            
            autoCannon(self)
            bulletDelay = 0
            
        }
        
    }
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//\/\/\//\/\/\//\//\/\/\//\/\/\\
    
    // touches stuff
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            touchLocationX = location.x
            touchLocationY = location.y
            
            if pauseButton .containsPoint(location) {
                
//                let sceneNext = MainGameMenu.unarchiveFromFile("MainGameMenu") as? MainGameMenu
//                let transition = SKTransition.crossFadeWithDuration(2)
//                self.scene?.view?.presentScene(sceneNext, transition: transition)
                
//            if scene!.view!.paused == false {
//                scene!.view!.paused = true
//                
//               
//            }
//            else if scene!.view!.paused == true { scene!.view!.paused = false }
            
            }
            
            if gunZone .containsPoint(location)  { gunBool = true }
            if moveUp .containsPoint(location)   { playerUp = true }
            if moveDown .containsPoint(location) { playerDown = true }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            touchLocationX = location.x
            touchLocationY = location.y
            
            if gunZone .containsPoint(location) { gunBool = true }
            
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            if gunZone .containsPoint(location)  { gunBool = false }
            if moveUp .containsPoint(location)   { playerUp = false }
            if moveDown .containsPoint(location) { playerDown = false }
            
        }
        
        if touches.count == 1 {
            
            gunBool = false
            playerUp = false
            playerDown = false
            
        }
        
    }
    
    
    //touches stuff ends
    
    
    //~~~~~~~~~~~\//\/\/\//\/\\//\
    
    
    func initializePlayer() {
        
        var playerTex: SKTexture!
        playerTex = SKTexture(imageNamed: "betterShittyPlayer")
        player = SKSpriteNode(texture: playerTex)
        player.size = (CGSize(width: 200, height: 75))
        player.physicsBody = SKPhysicsBody(texture: playerTex, size: player.size)
        player.position = CGPoint(x: frame.width * 0.15, y: frame.height / 2)
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = 3|4|5|6|7|8|9
        player.zPosition = 2
        addChild(player)
        player.physicsBody?.affectedByGravity = false
        playerHealth = 100 + playerHealthBonus
        
    }
    
    
    func initializeBackground() {
        
        bg1.anchorPoint = CGPointZero
        bg1.position = CGPoint(x: 0, y: 0)
        bg1.zPosition = -5
        addChild(bg1)
        
        bg2.anchorPoint = CGPointZero
        bg2.position = CGPoint(x: bg1.size.width - 1, y: 0)
        bg2.zPosition = -5
        addChild(bg2)
        
        bgMain.anchorPoint = CGPointZero
        bgMain.position = CGPoint(x: 0, y: 0)
        bgMain.zPosition = -6
        addChild(bgMain)
        
        bgMain1.anchorPoint = CGPointZero
        bgMain1.position = CGPoint(x: bgMain.size.width - 1, y: 0)
        bgMain1.zPosition = -6
        addChild(bgMain1)
        
        
        }
    
    func initializeLabels() {
        
        currentScore = 0
        scoreLabel.text = "\(currentScore)"
        scoreLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 60)
        scoreLabel.zPosition = 10
        scoreLabel.fontSize = 60
        
        addChild(scoreLabel)
        
        
        healthLabel.text = "\(playerHealth)"
        healthLabel.fontSize = 50
        healthLabel.position = CGPoint(x: scene!.size.width *  0.25, y: scene!.size.height - 60)
        addChild(healthLabel)
        
        oreCount = 0
        oreLabel.text = "Ore: \(oreCount)"
        oreLabel.fontSize = 50
        oreLabel.position = CGPoint(x: scene!.size.width *  0.75, y: scene!.size.height - 60)
        addChild(oreLabel)
        
    }

    override func removeAllChildren() {
        
    }
    override func removeAllActions() {
        
        
    }
}


