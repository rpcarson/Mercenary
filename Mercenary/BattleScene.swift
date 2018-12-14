//
//  GameScene.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import SpriteKit


var retryOverride: Bool = false


var bulletsFired: Double = 0
var bulletsHit: Double = 0
var enemiesDestroyed: Int = 0


var enemiesCount: Int = 0


var player: SKSpriteNode!

var spawnRandomizer: UInt32 = 0
var minionRandomizer: UInt32 = 0
var jetRandomizer: UInt32 = 0

var playerUp: Bool = false
var playerDown: Bool = false
var gunBool: Bool = false
var playerAlive: Bool = true
var menuActive: Bool = false

var levelComplete: Bool = false



var playerHealth: Int = 0
var currentScore: Int = 0
var oreCount: Int = 0


var touchLocationX: CGFloat!
var touchLocationY: CGFloat!

var moveDown: SKSpriteNode!
var moveUp: SKSpriteNode!
var gunZone: SKSpriteNode!



var beamFX: SKAction!
var gunFX: SKAction!
var playTex: SKTexture!
var rico: SKAction!
var rico1: SKAction!
var rico2: SKAction!
var flashTex: SKTexture!
var can1:  SKTexture!
var can2: SKTexture!
var can3: SKTexture!

var minTex: SKTexture!
var jetTex: SKTexture!
var rockTex: SKTexture!
var strayTex: SKTexture!
var smallAss: SKTexture!
var explodeSFX1: SKAction!
var explodeSFX2: SKAction!
var explodeSFX3: SKAction!



class BattleScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    
    
    override func didMove(to view: SKView) {
        
//        organTruckV2
//        introThemeAughtV2
        
        let music = SKAction.playSoundFileNamed("organTruckV2.mp3", waitForCompletion: true)
        let loopMusic = SKAction.repeatForever(music)
        run(loopMusic)

        
        let exp3 = SKAction.playSoundFileNamed("explosion3.wav", waitForCompletion: false)
      explodeSFX3 = exp3
        let exp1 =  SKAction.playSoundFileNamed("explosion1.wav", waitForCompletion: false)
      explodeSFX1 = exp1
        let exp2 =  SKAction.playSoundFileNamed("explosion2.wav", waitForCompletion: false)
        explodeSFX2 = exp2
        
        
        
        let exCan = SKTexture(imageNamed: "explosiveShot1")
        can3 = exCan
        let norCan = SKTexture(imageNamed: "gunfire3")
        let uraniumShot = SKTexture(imageNamed: "uraniumShot")
        can1 = norCan
        can2 = uraniumShot
        
        let minionTex = SKTexture(imageNamed: "stupidAssMinion1")
        minTex = minionTex
        let fighterTex = SKTexture(imageNamed: "crapEnemy1")
        jetTex = fighterTex
        let rocketTex = SKTexture(imageNamed: "rocket1")
        rockTex = rocketTex
        let strafeTex = SKTexture(imageNamed: "strafeJet")
        strayTex = strafeTex
        let smallroidTex = SKTexture(imageNamed: "asteroid1")
        smallAss = smallroidTex
        
        let gunSFX = SKAction.playSoundFileNamed("bestMachinegun.wav", waitForCompletion: true
        )
        gunFX = gunSFX
        
        let beamsSFX = SKAction.playSoundFileNamed("laserFireV2.wav", waitForCompletion: false)
        beamFX = beamsSFX
        
        let flashTexture = SKTexture(imageNamed: "muzzleFlash2")
        flashTex = flashTexture
        
        let playerTex = SKTexture(imageNamed: "truckNoLoad1")
        playTex = playerTex
        let ric1 = SKAction.playSoundFileNamed("ricochet3.wav", waitForCompletion: false)
        let ric2 = SKAction.playSoundFileNamed("ricochet2.wav", waitForCompletion: false)
        let ric3 = SKAction.playSoundFileNamed("ricochet23.wav", waitForCompletion: false)
        rico = ric1
        rico1 = ric2
        rico2 = ric3
        
        
        nullMove = childNode(withName: "nullMoveZone") as? SKSpriteNode
        nullZone = childNode(withName: "nullGunZone") as? SKSpriteNode
        nullZone.isHidden = true
        nullMove.isHidden = true
        
        
        pauseLabel.isHidden = true
        
        initializeBackground()
        initializeLabels()
        startGame()
        
        let delay = SKAction.wait(forDuration: 4)
        let bloc = SKAction.run( {self.beginGameplay()} )
        
        run(SKAction.sequence([delay,bloc]))
        
        ready()
        
        
//        levelCompleted(self)
        
        print(playerAlive)
        
    }
    
    func ready() {
        let ready = SKLabelNode(fontNamed: "Xperia")
        ready.text = "get ready"
        ready.fontSize = 60
        ready.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height / 2)
        addChild(ready)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        let remove = SKAction.removeFromParent()
        let fadeSeq = SKAction.sequence([fadeOut,fadeIn])
        let fade = SKAction.repeat(fadeSeq, count: 3)
        let fullSeq = SKAction.sequence([fade,fadeOut,remove])
        ready.run(fullSeq)
        
        playerAlive = true
        retryOverride = false
        
        
        totalEllapsed = 0
        strafeJetSpawnDelay = 0
        minionDelay = 0
        fighterWaveTimer = 0
        weakJetTimer = 0
        bargeTimer = 0
        shieldTimer = 0
        levelTime = 0
        singleMinion = 0
        
        retryButton.removeFromParent()
        
        healthLabel.isHidden = false
        oreLabel.isHidden = false
        scoreLabel.isHidden = false
        pauseLabel.isHidden = false
        
        beamEnabled = false
        uraniumBool = false
        explosiveBool = false
        oreCount = 0
        uraniumDam = 0
        explosiveDam = 0
        beamDamage = 0
        
    }
    
    var gameOn: Bool = false
    func beginGameplay() {
        
        gameOn = true
        
        pauseButton.isHidden = false
        pauseLabel.isHidden = false
        
        
        minionDelay = 0
        strafeJetSpawnDelay = 0
        

        
        
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run{
                (SmallAsteroidMechanix(scene: self))
            },
            SKAction.wait(forDuration: 6, withRange: 2)
            ])), withKey: "smallAsteroid")
        
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run{
                (LargeAsteroidMechanix(scene: self))
            },
            SKAction.wait(forDuration: 12, withRange: 5)
            ])), withKey: "largeAsteroid")
        
        
        
    }
    
    func startGame() {
        
    
        
        initializePlayer()
        
        
        playerAlive = true
        
        
        moveDown = childNode(withName: "moveDown") as? SKSpriteNode
        moveUp = childNode(withName: "moveUp") as? SKSpriteNode
        gunZone = childNode(withName: "gunZone") as? SKSpriteNode
        
        
        moveDown.isHidden = true
        moveUp.isHidden = true
        gunZone.isHidden = true
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
    
    
    func reset() {
        
        removeAction(forKey: "smallAsteroid")
        removeAction(forKey: "largeAsteroid")
        removeAction(forKey: "weakJet")
        
    
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
            
            projectile?.physicsBody = nil
            
        }
        
        if player && (secondMask == shieldRunnerCat) || player1 && (firstMask == shieldRunnerCat) {
            
            let playerShip = secondMask == playerCategory ? secondBody : firstBody
            let enemy = secondMask == shieldRunnerCat ? secondBody : firstBody
            
            
            playerHealth = playerHealth - 80
            
            enemy?.physicsBody = nil
            
        }
        
        if player && (secondMask == mineCat) || player1 && (firstMask == mineCat) {
            
            let playerShip = secondMask == playerCategory ? secondBody : firstBody
            let enemy = secondMask == mineCat ? secondBody as? Mine : firstBody as? Mine
            
            
            playerHealth = playerHealth - 70
            
            enemy?.removeFromParent()
            
            enemy?.physicsBody = nil
            
            if let enemy = enemy {
                
                explodeFunc3(scene: self, enemy: enemy)
                
            }
            
        }
        
        
        
        if player && (secondMask == smallRockCat) || player1 && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            
            playerHealth = playerHealth - 20
            
            if let enemy = enemy {
                explodeFunc(scene: self, enemy: enemy)
                
                
                enemy.removeFromParent()
                
                enemy.physicsBody = nil
                
            }
        }
        
        if player && (secondMask == largeRockCat) || player1 && (firstMask == largeRockCat) {
            
            let enemy = secondMask == largeRockCat ? secondBody as? LargeAsteroid : firstBody as? LargeAsteroid
            
            playerHealth = playerHealth - 75
            
            enemy?.physicsBody = nil
            
            
        }
        
        if player && (secondMask == strafeJetCat) || player1 && (firstMask == strafeJetCat) {
            
            let enemy = secondMask == strafeJetCat ? secondBody : firstBody
            
            enemy?.removeFromParent()
            
            enemy?.physicsBody = nil
            
            playerHealth = playerHealth - 25
            
            enemiesCount -= 1
            
        }
        
        
        
        if player && (secondMask == enemyRocketCat) || player1 && (firstMask == enemyRocketCat) {
            
            let enemy = secondMask == enemyRocketCat ? secondBody : firstBody
            
            enemy?.removeFromParent()
            
            enemy?.physicsBody = nil
            
            playerHealth = playerHealth - 50
            
            if bugzOn {
                print("rocket contact")
                print("player health = \(playerHealth)")
            }
            
        }
        
        if player && (secondMask == enemyCategoryOne) || player1 && (firstMask == enemyCategoryOne) {
            
            let enemy = secondMask == enemyCategoryOne ? secondBody : firstBody
            
            enemy?.removeFromParent()
            
            enemy?.physicsBody = nil
            
            playerHealth = playerHealth - 25
            
            
            enemiesCount -= 1
            

        }
        
        func dropOre(scene: SKScene, asteroid: SKSpriteNode) {
            
            let ranNum = arc4random_uniform(3)
            var _: UInt32 = 0
            let orePiece = SKShapeNode(circleOfRadius: 10)
            orePiece.fillColor = UIColor(red:0.25, green:0.92, blue:0.46, alpha:1)
            orePiece.position = asteroid.position
            orePiece.glowWidth = 10
            
            if ranNum == 1 || ranNum == 2 {
                
                scene.addChild(orePiece)
                orePiece.physicsBody = SKPhysicsBody(circleOfRadius: 25)
                orePiece.physicsBody?.collisionBitMask = 0
                orePiece.physicsBody?.contactTestBitMask = playerCategory
                orePiece.physicsBody?.categoryBitMask = oreCategory
                
                
                let move = SKAction.moveTo( x: -scene.size.width, duration: 9)
                let remove = SKAction.removeFromParent()
                
                orePiece.run(SKAction.sequence([move,remove]))
                
                
            }
        }
        
        if player && (secondMask == oreCategory) || player1 && (firstMask == oreCategory) {
            let enemy = secondMask == oreCategory ? secondBody : firstBody
            
            oreCount   += 1
           
            enemy?.physicsBody = nil

            enemy?.removeFromParent()
            
        }
        
        if (firstMask == playerProjectileOne) && (secondMask == smallRockCat) || (secondMask == playerProjectileOne) && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            

            projectile?.physicsBody = nil
            projectile?.removeFromParent()
            bulletsHit   += 1
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health ?? 0 <= 0
                
            {
                
                if let enemy = enemy {
                    
                    dropOre(scene: self, asteroid: enemy)
                    
                    explodeFunc(scene: self, enemy: enemy)
                    
                    enemy.removeFromParent()
                    
                    enemy.physicsBody = nil
                    
                    currentScore = currentScore + 25
                }
                
            }
            
        }
        if (firstMask == playerProjectileOne) && (secondMask == largeRockCat) || (secondMask == playerProjectileOne) && (firstMask == largeRockCat) {
            
            let enemy = secondMask == largeRockCat ? secondBody as? LargeAsteroid : firstBody as? LargeAsteroid
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit   += 1
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health ?? 0 <= 0  {
                
                if let enemy = enemy {
                    
                    dropOre(scene: self, asteroid: enemy)
                    
                    explodeFunc(scene: self, enemy: enemy)
                    
                    enemy.removeFromParent()
                    
                    currentScore = currentScore + 100
                    
                }
            }
        }
        
        let playerBullet = (firstMask == playerProjectileOne)
        let playerBullet1 = (secondMask == playerProjectileOne)
        
        if playerBullet && (secondMask == shieldRunnerCat) || playerBullet1 && (firstMask == shieldRunnerCat) {
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit   += 1
            
        }
        if playerBullet && (secondMask == mineCat) || playerBullet1 && (firstMask == mineCat) {
            
            _ = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == mineCat ? secondBody as? Mine : firstBody as? Mine
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit   += 1
            
            
            let ranNum = arc4random_uniform(2)
            if ranNum == 1 {
                let ranNum2 = arc4random_uniform(2)
                if ranNum2 == 0|1 {
                    run(rico)

                }else{
                    run(rico1)
                    
                }
            }
            
            if let enemy = enemy {
                
                enemy.health = enemy.health - autoCannonDamage
                if enemy.health <= 0 {
                    explodeFunc(scene: self, enemy: enemy)
                    enemy.removeFromParent()
                    currentScore  += 10
                    enemiesDestroyed += 1

                }
            }
            
        }
        
        
        if playerBullet && (secondMask == strafeJetCat) || playerBullet1 && (firstMask == strafeJetCat) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == strafeJetCat ? secondBody as? LittleMinion : firstBody as? LittleMinion
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit  += 1
            
            
            
            let ranNum = arc4random_uniform(2)
            if ranNum == 1 {
                let ranNum2 = arc4random_uniform(2)
                if ranNum2 == 0|1 {
                    run(rico)
                    
                }else{
                    run(rico1)
                    
                }
            }
            
 //~~~~~~~~           //            runAction(rico)
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health ?? 0 <= 0 {
                
                if let enemy = enemy {
                    explodeFunc2(scene: self, enemy: enemy)
                    enemy.removeFromParent()
                    currentScore += 25
                    enemiesCount -= 1
                    enemiesDestroyed += 1
                    
                }
                
            }
            
        }
        
        if playerBullet && (secondMask == strafeJetCat) || playerBullet1 && (firstMask == strafeJetCat) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == strafeJetCat ? secondBody as? StrafeJet : firstBody as? StrafeJet
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit  += 1
            
            let ranNum = arc4random_uniform(2)
            if ranNum == 1 {
                let ranNum2 = arc4random_uniform(2)
                if ranNum2 == 0|1 {
                    run(rico)
                    
                }else{
                    run(rico1)
                    
                }
            }
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health ?? 0 <= 0 {
                
                if let enemy = enemy {
                    explodeFunc2(scene: self, enemy: enemy)
                    enemy.removeFromParent()
                    currentScore += 50
                    enemiesCount -= 1
                    enemiesDestroyed  += 1

                    
                }
                
            }
            
        }
        
        if playerBullet && (secondMask == bargeCat) || playerBullet1 && (firstMask == bargeCat) {
            
            let enemy = secondMask == enemyCategoryOne ? secondBody as? ArtillaryBarge : firstBody as? ArtillaryBarge
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit  += 1
            
            let ranNum = arc4random_uniform(2)
            if ranNum == 1 {
                let ranNum2 = arc4random_uniform(2)
                if ranNum2 == 0|1 {
                    run(rico)
                    
                }else{
                    run(rico1)
                    
                }
            }
            
//~~~~~~~~            //            runAction(rico2)
            
            if let enemy = enemy {
                
                enemy.health = enemy.health - autoCannonDamage
                
                if enemy.health <= 80 {
                    enemy.physicsBody?.allowsRotation = true
                    enemy.physicsBody?.angularVelocity = 0.1
                    
                }
                if enemy.health <= 0 {
                    enemy.removeFromParent()
                    explodeFunc2(scene: self, enemy: enemy)
                    currentScore += 350
                    enemiesCount -= 1
                    enemiesDestroyed  += 1

                    
                }
            }
        }
        
        
        if playerBullet && (secondMask == enemyCategoryOne) || playerBullet1 && (firstMask == enemyCategoryOne) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == enemyCategoryOne ? secondBody as? WeakJet : firstBody as? WeakJet
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit  += 1
            
            
            let ranNum = arc4random_uniform(2)
            if ranNum == 1 {
                let ranNum2 = arc4random_uniform(2)
                if ranNum2 == 0|1 {
                    run(rico)
                    
                }else{
                    run(rico1)
                    
                }
            }
            
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if bugzOn {
                print(enemy?.health)
            }
            
            if enemy?.health ?? 0 <= 10 {
                
                enemy?.physicsBody?.allowsRotation = true
                enemy?.physicsBody?.angularVelocity = 1
                
            }
            if let enemy = enemy {
                
                if enemy.health <= 0 {
                    
                    explodeFunc2(scene: self, enemy: enemy)
                    enemy.removeFromParent()
                    currentScore += 50
                    enemiesDestroyed += 1

                    enemiesCount -= 1
                    
                }
            }
        }
    }
    
    
    var deathScreenItems: [SKNode] = []
    func playerDeathScreen() {
        
        pauseButton.isHidden = true
        pauseLabel.isHidden = true
        
        reset()
        
        let darkOverlay = SKSpriteNode(color: UIColor.black, size: scene!.size)
        darkOverlay.anchorPoint = CGPoint.zero
        darkOverlay.alpha = 0.0
        addChild(darkOverlay)
        let fade = SKAction.fadeAlpha(to: 0.5, duration: 3)
        let textFade = SKAction.fadeIn(withDuration: 3)
        
        
        darkOverlay.run(fade)
        
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
        gameoverLabel.run(textFade)
        tryagainLabel.run(textFade)
        returnMenuLabel.run(textFade)
        
        let goIn = SKAction.fadeOut(withDuration: 2)
        let goOut = SKAction.fadeIn(withDuration: 2)
        gameoverLabel.run(SKAction.repeatForever(SKAction.sequence([goIn,goOut])))
        
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
    
    var bulletDelay = 0
    var bulletDelay1 = 0
    var strafeJetSpawnDelay: UInt32 = 0
    var minionDelay: UInt32 = 0
    var fighterWaveTimer: UInt32 = 0
    var totalEllapsed = 0
    var weakJetTimer: UInt32 = 0
    var bargeTimer: UInt32 = 0
    var shieldTimer: UInt32 = 0
    var levelTime: UInt32 = 0
    var singleMinion: UInt32 = 0
    
    
    
    func finishLevel() {
        
        levelComplete = true
        reset()
        
    }
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        
       levelTime  += 1
        
        if levelTime == 8300 {
            
            levelCompleted(scene: self)
            playerAlive = false
        }
        
        if playerHealth > 500 {
            
            healthLabel.fontColor = UIColor.white
        }
        if playerHealth < 300 {
            healthLabel.fontColor = UIColor.yellow
        }
        if playerHealth < 150 {
            healthLabel.fontColor = UIColor.red
        }
        
        if menuActive == true { return }
        
        
        if (playerUp == true) && (player.position.y < frame.height - 70) {
            player.position.y = player.position.y + 15
        }
        if (playerDown == true) && (player.position.y > frame.height - frame.height + 70) {
            player.position.y = player.position.y - 15
        }
        
        if (gunBool == true) && (bulletDelay > 12) {
            
            
            bulletsFired  += 1
            
            //            if beamEnabled == true {
            //
            //                beamCannon(self)
            //            }
            
            autoCannon(scene: self)
            bulletDelay = 0
            bulletDelay1 = 6
            
        }
        if (gunBool == true) && (bulletDelay1 > 12) {
            autoCannon1(scene: self)
            bulletDelay1 = 0
            
            bulletsFired  += 1

            
        }
        
        bulletDelay  += 1
        bulletDelay1  += 1
        
        if levelComplete == false {
            
            if gameOn == true {
                
                if playerAlive == true {
                    totalEllapsed  += 1
                    strafeJetSpawnDelay  += 1
                    minionDelay  += 1
                    fighterWaveTimer  += 1
                    weakJetTimer += 1
                    bargeTimer += 1
                    shieldTimer += 1
               
                   
                    singleMinion += 1
                    
                } else {
                    totalEllapsed = 0
                    strafeJetSpawnDelay = 0
                    minionDelay = 0
                    fighterWaveTimer = 0
                    weakJetTimer = 0
                    bargeTimer = 0
                    shieldTimer = 0
                    levelTime = 0
                    singleMinion = 0
                }
                
                if levelTime > 8150 {
                    
                    finishLevel()
                    
                }
                
                if totalEllapsed == 200 {
                    
                    bargeSpawn(scene: self)
                }
                
                if totalEllapsed == 7000 {
                    
                    bargeSpawn(scene: self)
                }
                
                if totalEllapsed == 400 || totalEllapsed == 6500 {
                    let point1 = CGPoint(x: frame.size.width + 200, y: (frame.size.height / 2) + 300)
                    let point2 = CGPoint(x: frame.size.width + 180, y: (frame.size.height / 2) + 80)
                    let point3 = CGPoint(x: frame.size.width + 100, y: (frame.size.height / 2) - 100)
                    let point4 = CGPoint(x: frame.size.width + 60, y: (frame.size.height / 2) - 220)
                    let point5 = CGPoint(x: frame.size.width + 40, y: (frame.size.height / 2) - 30)
                    let point6 = CGPoint(x: frame.size.width + 10, y: (frame.size.height / 2) + 120)
                    
                    let mineField: [CGPoint] = [point1,point2,point3,point4,point5,point6]
                    
                    
                    for point in mineField {
                        
                        
                        layMines(scene: self, point: point)
                        
                    }
                }
                
                
                
                if currentScore > 1000 && shieldTimer > 1200 {
                    
                    enemyFighter(scene: self)
                    shieldTimer = 0
                    
                    enemiesCount += 1
                    
                }
                
                if singleMinion > 200 {
                    let rany = CGFloat(arc4random_uniform(300)) - 150
                    let point5 = CGPoint(x: frame.size.width + 30, y: player.position.y + rany)
                    
                    littionMinionSpawn(scene: self, spawnPoint: point5)
                    singleMinion = 0
                    
                    enemiesCount += 1
                    
                }
                
                if bargeTimer > 3500 {
                    let point3 = CGPoint(x: frame.size.width + 30, y: player.position.y - 100)
                    let point4 = CGPoint(x: frame.size.width + 30, y: player.position.y - 200)
                    let point5 = CGPoint(x: frame.size.width + 30, y: player.position.y)
                    let point6 = CGPoint(x: frame.size.width + 30, y: player.position.y + 100)
                    let minionArray: [CGPoint] = [point3,point4,point5,point6]
                    
                    for point in minionArray {
                        
                        littionMinionSpawn(scene: self, spawnPoint: point)
                        
                    }
                    
                    bargeTimer = 0
                    
                    enemiesCount += 4
                    
                }
                
                if (fighterWaveTimer > 2000 + minionRandomizer) && totalEllapsed > 4000 {
                    let point1 = CGPoint(x: frame.size.width + 150, y: frame.size.height)
                    let point2 = CGPoint(x: frame.size.width + 300, y: frame.size.height - 200)
                    let point3 = CGPoint(x: frame.size.width + 450, y: frame.size.height - 400)
                    let pattern1: [CGPoint] = [point1,point2,point3]
                    
                    let ranPointY = arc4random_uniform(100)
                    
                    for points in pattern1 {
                        
                        fighterJetWave(scene: self, spawnPoint: points, movePoint: ranPointY)
                        fighterWaveTimer = 0
                    }
                    enemiesCount += 3
                    
                }
                
                if totalEllapsed > 600 {
                    if weakJetTimer > 200 + jetRandomizer {
                        weakJetSpawn(scene: self)
                        weakJetTimer = 0
                        
                        enemiesCount += 1
                        
                    }
                }
                
                
                
                if totalEllapsed > 2000 {
                    if minionDelay > minionRandomizer + 500 {
                        
                        
                        let point1 = CGPoint(x: frame.size.width + 180, y: player.position.y + 120)
                        let point2 = CGPoint(x: frame.size.width + 180, y: player.position.y - 120)
                        let point3 = CGPoint(x: frame.size.width + 30, y: player.position.y)
                        let pattern1: [CGPoint] = [point1,point2,point3]
                        
                        for points in pattern1 {
                            
                            littionMinionSpawn(scene: self, spawnPoint: points)
                            minionDelay = 0
                            
                            
                            
                        }
                        enemiesCount += 3
                        
                    }
                }
                
                if totalEllapsed > 3000 {
                    if strafeJetSpawnDelay > spawnRandomizer + 600 {
                        
                        strafeJetSpawn(scene: self)
                        strafeJetSpawnDelay = 0
                        
                        enemiesCount += 1
                        
                    }
                }
            }
        }
        
        BGScroll()
        BGScroll2()
        
        healthLabel.text = "Health: \(playerHealth)"
        scoreLabel.text = "\(currentScore)"
        oreLabel.text = "Ore: \(oreCount)"
        
        if playerHealth <= 0 && levelComplete != true {
            
            if playerAlive == false { return }
            
            explodeFunc3(scene: self, enemy: player)
            
            player.removeFromParent()
            
            playerAlive = false
            
            playerDeathScreen()
            
        }

        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in (touches ) {
            
            let location = touch.location(in: self)
            
            if retryButton .contains(location) {
                
                
                
                if playerAlive == true { return }
                
//                if retryOverride == true { return }
                
               
                
                oreCount = 0
                currentScore = 0
                bulletsFired = 0
                bulletsHit = 0
                enemiesDestroyed = 0
                
                for node in levelCompleteArray { node.removeFromParent() }
                for node in deathScreenItems { node.removeFromParent() }
                
                startGame()
                
                let delay = SKAction.wait(forDuration: 4)
                let bloc = SKAction.run( {self.beginGameplay()} )
                
                run(SKAction.sequence([delay,bloc]))
                
                ready()
                
                retryOverride = true
                
            }
            
            if resumeButton.contains(location) {
                
                scene?.isPaused = false
                menuActive = false
                pauseLabel.isHidden = false
                
                for node in missionMenuItems { node.removeFromParent() }
                
                
                
            }
            
            //            if upgradeSystemsButton.containsPoint(location) {
            //
            //                upgradeSystemsMenu(self)
            //
            //            }
            
            
            if pauseButton.contains(location) && (pauseLabel.isHidden != true) {
                
                missionMenu(scene: self)
                
            }
            
            if gunZone .contains(location)  {
                
                touchLocationX = location.x
                touchLocationY = location.y
                
                gunBool = true }
           
            if moveUp .contains(location)   { playerUp = true }
            if moveDown .contains(location) { playerDown = true }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in (touches ) {
            
            let location = touch.location(in: self)
            
            
            
            if gunZone .contains(location) {
                
                touchLocationX = location.x
                touchLocationY = location.y
                
                gunBool = true }
            
            if nullZone.contains(location) { gunBool = false }
            
            if nullMove.contains(location) { playerUp = false; playerDown = false }
            
        }
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            
            let location = touch.location(in: self)
            
            if gunZone .contains(location)  { gunBool = false }
            if moveUp .contains(location)   { playerUp = false }
            if moveDown .contains(location) { playerDown = false }
            if nullMove.contains(location) { playerUp = false; playerDown = false }
            
            
        }
        
        if touches.count == 1 {
            
            //            gunBool = false
            playerUp = false
            playerDown = false
            
        }
    }

    
    let engine = SKEmitterNode(fileNamed: "MyParticle")
    
    func initializePlayer() {
        
        player = SKSpriteNode(texture: playTex, size: playTex.size())
        player.size = CGSize(width: player.size.width, height: player.size.height)
        player.physicsBody = SKPhysicsBody(texture: playTex, size: player.size)
        player.position = CGPoint(x: 0 + (player.size.width / 3), y: frame.height / 2)
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = 3|4|5|6|7|8|9
        player.zPosition = 2
        addChild(player)
        player.physicsBody?.affectedByGravity = false
        playerHealth = 20000 + playerHealthBonus
        
        
        
        //        addChild(engine)
        ////        engine.position = CGPoint(x: player.position.x - 100, y: player.position.y)
        //        engine.targetNode = player
        
        
    }
    
    
    func initializeBackground() {
        
        bg1.anchorPoint = .zero
        bg1.position = CGPoint(x: 0, y: 0)
        bg1.zPosition = -5
        addChild(bg1)
        
        bg2.anchorPoint = .zero
        bg2.position = CGPoint(x: bg1.size.width - 1, y: 0)
        bg2.zPosition = -5
        addChild(bg2)
        
        bgMain.anchorPoint = .zero
        bgMain.position = CGPoint(x: 0, y: 0)
        bgMain.zPosition = -6
        addChild(bgMain)
        
        bgMain1.anchorPoint = .zero
        bgMain1.position = CGPoint(x: bgMain.size.width - 1, y: 0)
        bgMain1.zPosition = -6
        addChild(bgMain1)
        
        
    }
    
    func initializeLabels() {
        
        currentScore = 0
        scoreLabel.text = "\(currentScore)"
        scoreLabel.position = CGPoint(x: scene!.size.width * 0.05, y: scene!.size.height - 40)
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = UIColor.white
        addChild(scoreLabel)
        
        healthLabel.text = "\(playerHealth)"
        healthLabel.fontSize = 50
        healthLabel.position = CGPoint(x: scene!.size.width *  0.25, y: scene!.size.height - 60)

        addChild(healthLabel)
        
      
        oreCount = 0
        oreLabel.text = "Ore:\(oreCount)"
        oreLabel.fontSize = 50
        oreLabel.position = CGPoint(x: scene!.size.width *  0.75, y: scene!.size.height - 60)
        oreLabel.fontColor = UIColor.green
        addChild(oreLabel)
        
        pauseLabel.text = "Menu"
        pauseLabel.fontSize = 40
        pauseLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 60)
        addChild(pauseLabel)
        
        pauseButton.position = pauseLabel.position
        addChild(pauseButton)
        
    }
    
}


