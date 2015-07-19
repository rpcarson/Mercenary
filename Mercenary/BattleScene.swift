//
//  GameScene.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import SpriteKit


var player: SKSpriteNode!

var spawnRandomizer: UInt32 = 0
var minionRandomizer: UInt32 = 0

var playerUp: Bool = false
var playerDown: Bool = false
var gunBool: Bool = false
var playerAlive: Bool = true
var menuActive: Bool = false


var playerHealth: Int = 0
var currentScore: Int = 0
var oreCount: Int = 0


var touchLocationX: CGFloat!
var touchLocationY: CGFloat!

var moveDown: SKSpriteNode!
var moveUp: SKSpriteNode!
var gunZone: SKSpriteNode!


var masterEnemyArray: [SKNode] = []



let music = SKAction.playSoundFileNamed("IntroThemeAughtV2.mp3", waitForCompletion: true)
let loopMusic = SKAction.repeatActionForever(music)

class BattleScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        //        runAction(loopMusic)
        
        
        pauseLabel.hidden = true
        
        initializeBackground()
        initializeLabels()
        startGame()
        
        let delay = SKAction.waitForDuration(4)
        let bloc = SKAction.runBlock( {self.beginGameplay()} )
        
        runAction(SKAction.sequence([delay,bloc]))
        
        ready()
        
        
        
        
    }
    
    func ready() {
        let ready = SKLabelNode(fontNamed: "Xperia")
        ready.text = "get ready"
        ready.fontSize = 60
        ready.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height / 2)
        addChild(ready)
        let fadeOut = SKAction.fadeOutWithDuration(1)
        let fadeIn = SKAction.fadeInWithDuration(0.2)
        let remove = SKAction.removeFromParent()
        let fadeSeq = SKAction.sequence([fadeOut,fadeIn])
        let fade = SKAction.repeatAction(fadeSeq, count: 3)
        let fullSeq = SKAction.sequence([fade,fadeOut,remove])
        ready.runAction(fullSeq)
        
        playerAlive = true
        
        
        if bugzOn {
            playerHealth = 100000
        }
        
        
    }
    
    var gameOn: Bool = false
    func beginGameplay() {
        
        gameOn = true
        
        pauseButton.hidden = false
        pauseLabel.hidden = false
        
        
        minionDelay = 0
        strafeJetSpawnDelay = 0
        
        
        
        
        
        
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (SmallAsteroidMechanix(self))
            },
            SKAction.waitForDuration(6, withRange: 2)
            ])), withKey: "smallAsteroid")
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (LargeAsteroidMechanix(self))
            },
            SKAction.waitForDuration(12, withRange: 5)
            ])), withKey: "largeAsteroid")
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.runBlock{
                (weakJetSpawn(self))
            },
            SKAction.waitForDuration(6, withRange: 4)
            ])), withKey: "weakJet")
        
    }
    
    func startGame() {
        
        //        runAction(SKAction.playSoundFileNamed("LevelOneMainLoopV2.mp3", waitForCompletion: true))
        
        initializePlayer()
        
        
        playerAlive = true
        
        
        //                        runAction(loopMusic)
        
        
        
        nullZone = childNodeWithName("nullGunZone") as? SKSpriteNode
        moveDown = childNodeWithName("moveDown") as? SKSpriteNode
        moveUp = childNodeWithName("moveUp") as? SKSpriteNode
        gunZone = childNodeWithName("gunZone") as? SKSpriteNode
        
        nullZone.hidden = true
        
        moveDown.hidden = true
        moveUp.hidden = true
        gunZone.hidden = true
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
    
    
    func reset() {
        
        removeActionForKey("smallAsteroid")
        removeActionForKey("largeAsteroid")
        removeActionForKey("weakJet")
        for asteroid in asteroidArray { asteroid.removeFromParent() }
        for jet in weakjetArray { jet.removeFromParent() }
        
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
        
        if player && (secondMask == enemyBulletCat) || player1 && (firstMask == enemyBulletCat) {
            
            
            let projectile = secondMask == enemyBulletCat ? secondBody : firstBody
            
            playerHealth = playerHealth - 5
            projectile?.removeFromParent()
            if debugz == true{
                println("bullet contact")
            }
        }
        
        
        
        
        
        
        
        if player && (secondMask == smallRockCat) || player1 && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            
            if debugz == true {
                println("small rock impact")
                println("player health = \(playerHealth)")
            }
            
            playerHealth = playerHealth - 20
            
            if let enemy = enemy {
                explodeFunc(self, enemy)
            }
            enemy?.removeFromParent()
            
        }
        if player && (secondMask == largeRockCat) || player1 && (firstMask == largeRockCat) {
            
            let enemy = secondMask == largeRockCat ? secondBody as? LargeAsteroid : firstBody as? LargeAsteroid
            
            playerHealth = playerHealth - 100
            
            if bugzOn {
                println("large rock impact")
                println("player health = \(playerHealth)")
            }
            
            
        }
        
        if player && (secondMask == enemyRocketCat) || player1 && (firstMask == enemyRocketCat) {
            
            let enemy = secondMask == enemyRocketCat ? secondBody : firstBody
            
            enemy?.removeFromParent()
            playerHealth = playerHealth - 50
            
            if bugzOn {
                println("rocket contact")
                println("player health = \(playerHealth)")
            }
            
        }
        
        if player && (secondMask == enemyCategoryOne) || player1 && (firstMask == enemyCategoryOne) {
            
            let enemy = secondMask == enemyCategoryOne ? secondBody : firstBody
            
            enemy?.removeFromParent()
            playerHealth = playerHealth - 50
            
            if bugzOn {
                println("enemy jet contact")
                println("player health = \(playerHealth)")
            }
        }
        
        func dropOre(scene: SKScene, asteroid: SKSpriteNode) {
            
            let ranNum = arc4random_uniform(2)
            var oreChance: UInt32 = 1
            let orePiece = SKShapeNode(circleOfRadius: 10)
            orePiece.fillColor = UIColor.yellowColor()
            orePiece.position = asteroid.position
            orePiece.glowWidth = 10
            
            if oreChance == ranNum {
                
                scene.addChild(orePiece)
                orePiece.physicsBody = SKPhysicsBody(circleOfRadius: 25)
                orePiece.physicsBody?.applyImpulse(CGVector(dx: -15, dy: 0))
                orePiece.physicsBody?.collisionBitMask = 0
                orePiece.physicsBody?.contactTestBitMask = playerCategory
                orePiece.physicsBody?.categoryBitMask = oreCategory
                
            }
        }
        
        if player && (secondMask == oreCategory) || player1 && (firstMask == oreCategory) {
            let enemy = secondMask == oreCategory ? secondBody : firstBody
            
            enemy?.removeFromParent()
            
            oreCount = oreCount + 1
            
        }
        
        if (firstMask == playerProjectileOne) && (secondMask == smallRockCat) || (secondMask == playerProjectileOne) && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            
            if bugzOn {
                println(enemy?.health)
            }
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0
                
            {
                
                if let enemy = enemy {
                    
                    dropOre(self, enemy)
                    
                    explodeFunc(self, enemy)
                    
                    enemy.removeFromParent()
                    
                    currentScore = currentScore + 25
                }
                
            }
            
        }
        if (firstMask == playerProjectileOne) && (secondMask == largeRockCat) || (secondMask == playerProjectileOne) && (firstMask == largeRockCat) {
            
            let enemy = secondMask == largeRockCat ? secondBody as? LargeAsteroid : firstBody as? LargeAsteroid
            
            if bugzOn {
                println(enemy?.health)
            }
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0  {
                
                if let enemy = enemy {
                    
                    dropOre(self, enemy)
                    
                    explodeFunc(self, enemy)
                    
                    enemy.removeFromParent()
                    
                    currentScore = currentScore + 100
                    
                }
            }
        }
        
        let playerBullet = (firstMask == playerProjectileOne)
        let playerBullet1 = (secondMask == playerProjectileOne)
        
        if playerBullet && (secondMask == strafeJetCat) || playerBullet1 && (firstMask == strafeJetCat) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == strafeJetCat ? secondBody as? LittleMinion : firstBody as? LittleMinion
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if bugzOn {
                println("minion health \(enemy?.health)")
                
            }
            
            if enemy?.health <= 0 {
                
                if let enemy = enemy {
                    explodeFunc2(self, enemy)
                    enemy.removeFromParent()
                    currentScore += 25
                    
                    
                }
                
            }
            
        }
        
        
        
        
        
        if playerBullet && (secondMask == strafeJetCat) || playerBullet1 && (firstMask == strafeJetCat) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == strafeJetCat ? secondBody as? StrafeJet : firstBody as? StrafeJet
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0 {
                
                if let enemy = enemy {
                    explodeFunc2(self, enemy)
                    enemy.removeFromParent()
                    currentScore += 50
                    
                    
                }
                
            }
            
        }
        
        
        
        if playerBullet && (secondMask == enemyCategoryOne) || playerBullet1 && (firstMask == enemyCategoryOne) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == enemyCategoryOne ? secondBody as? WeakJet : firstBody as? WeakJet
            
            projectile?.removeFromParent()
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if bugzOn {
                println(enemy?.health)
            }
            
            if enemy?.health <= 10 {
                
                enemy?.physicsBody?.allowsRotation = true
                enemy?.physicsBody?.angularVelocity = 1
                
            }
            if let enemy = enemy {
                
                if enemy.health <= 0 {
                    
                    explodeFunc2(self, enemy)
                    enemy.removeFromParent()
                    currentScore += 50
                }
            }
        }
    }
    
    
    var deathScreenItems: [SKNode] = []
    
    func playerDeathScreen() {
        
        pauseButton.hidden = true
        pauseLabel.hidden = true
        
        reset()
        
        
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
        
        retryButton.position = tryagainLabel.position
        addChild(retryButton)
        
        returnButton.position = returnMenuLabel.position
        addChild(returnButton)
        
        deathScreenItems.append(returnButton)
        deathScreenItems.append(retryButton)
        deathScreenItems.append(gameoverLabel)
        deathScreenItems.append(tryagainLabel)
        deathScreenItems.append(returnMenuLabel)
        deathScreenItems.append(darkOverlay)
        
    }
    
    var bulletsFired: Int = 0
    var bulletDelay = 0
    var strafeJetSpawnDelay: UInt32 = 0
    var minionDelay: UInt32 = 0
    override func update(currentTime: CFTimeInterval) {
        
        
        if menuActive == true { return }
        
        
        if gameOn == true {
            
            if playerAlive == true {
                strafeJetSpawnDelay++
                minionDelay++
                
            } else {
                strafeJetSpawnDelay = 0
                minionDelay = 0
            }
            
            if minionDelay > minionRandomizer + 200 {
                
                var point1 = CGPoint(x: frame.size.width, y: player.position.y + 30)
                var point2 = CGPoint(x: frame.size.width, y: player.position.y - 30)
                minionPattern.append(point1)
                minionPattern.append(point2)
                
                for points in minionPattern {
                    
                    littionMinionSpawn(self, points)
                    minionDelay = 0
                
                }
                
                minionPattern.removeAll(keepCapacity: false)
                
            }
            
            if strafeJetSpawnDelay > spawnRandomizer + 350 {
                
                strafeJetSpawn(self)
                strafeJetSpawnDelay = 0
            
            }
       
        }
        
        
        
        BGScroll()
        BGScroll2()
        
        bulletDelay++
        
        healthLabel.text = "\(playerHealth)"
        scoreLabel.text = "\(currentScore)"
        oreLabel.text = "\(oreCount)"
        
        if playerHealth <= 0 {
            
            if playerAlive == false { return }
            
            
            if bugzOn {
                println("player death \(playerAlive)")
            }
            
            explodeFunc3(self, player)
            
            
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
        
        if (gunBool == true) && (bulletDelay > 5) {
            
            bulletsFired++
            //            beamCannon(self)
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
            
            if retryButton .containsPoint(location) {
                
                if playerAlive == true { return }
                
                for node in deathScreenItems { node.removeFromParent() }
                
                startGame()
                
                let delay = SKAction.waitForDuration(4)
                let bloc = SKAction.runBlock( {self.beginGameplay()} )
                
                runAction(SKAction.sequence([delay,bloc]))
                
                ready()
                
                
            }
            
            if resumeButton.containsPoint(location) {
                
                scene?.paused = false
                menuActive = false
                pauseLabel.hidden = false
                
                for node in missionMenuItems { node.removeFromParent() }
                
                
                
            }
            
            //            if upgradeSystemsButton.containsPoint(location) {
            //
            //                upgradeSystemsMenu(self)
            //
            //            }
            
            
            if pauseButton.containsPoint(location) && (pauseLabel.hidden != true) {
                
                missionMenu(self)
                
                //                if scene!.view!.paused == false {
                //                    scene!.view!.paused = true
                //
                //                }
                //                else if scene!.view!.paused == true { scene!.view!.paused = false }
                //
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
            if nullZone.containsPoint(location) { gunBool = false }
            
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
    
    
    let engine = SKEmitterNode(fileNamed: "MyParticle")
    
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
        playerHealth = 200 + playerHealthBonus
        
        
        
        //        addChild(engine)
        ////        engine.position = CGPoint(x: player.position.x - 100, y: player.position.y)
        //        engine.targetNode = player
        
        
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
        
        pauseLabel.text = "Menu"
        pauseLabel.fontSize = 40
        pauseLabel.position = CGPoint(x: scene!.size.width * 0.12, y: scene!.size.height - 60)
        addChild(pauseLabel)
        
        pauseButton.position = pauseLabel.position
        addChild(pauseButton)
        
    }
    
    override func removeAllChildren() {
        
    }
    override func removeAllActions() {
        
        
    }
}


