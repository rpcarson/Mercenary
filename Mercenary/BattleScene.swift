//
//  GameScene.swift
//  Mercenary
//
//  Created by Reed Carson on 6/30/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import SpriteKit



var bulletsFired: Double = 0
var bulletsHit: Double = 0
var enemiesDestroyed: Int = 0
var accuracy: Double = bulletsHit / bulletsFired


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

var minTex: SKTexture!
var jetTex: SKTexture!
var rockTex: SKTexture!
var strayTex: SKTexture!
var smallAss: SKTexture!

let music = SKAction.playSoundFileNamed("IntroThemeAughtV2.mp3", waitForCompletion: true)
let loopMusic = SKAction.repeatActionForever(music)

class BattleScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        
        //        runAction(loopMusic)
        
        
        let norCan = SKTexture(imageNamed: "gunfire3")
        let urCan = SKTexture(imageNamed: "uraniumCannon")
        can1 = norCan
        can2 = urCan
        
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
        
        let gunSFX = SKAction.playSoundFileNamed("basicGun.wav", waitForCompletion: false)
        gunFX = gunSFX
        
        let beamsSFX = SKAction.playSoundFileNamed("laserFireV2.wav", waitForCompletion: false)
        beamFX = beamsSFX
        
        let flashTexture = SKTexture(imageNamed: "muzzleFlash2")
        flashTex = flashTexture
        
        let playerTex = SKTexture(imageNamed: "truckNoLoad1")
        playTex = playerTex
        let ric1 = SKAction.playSoundFileNamed("ricochet1.wav", waitForCompletion: false)
        let ric2 = SKAction.playSoundFileNamed("ricochet2.wav", waitForCompletion: false)
        let ric3 = SKAction.playSoundFileNamed("shortRicochet.wav", waitForCompletion: false)
        rico = ric1
        rico1 = ric2
        rico2 = ric3
        
        
        nullMove = childNodeWithName("nullMoveZone") as? SKSpriteNode
        nullZone = childNodeWithName("nullGunZone") as? SKSpriteNode
        nullZone.hidden = true
        nullMove.hidden = true
        
        
        pauseLabel.hidden = true
        
        initializeBackground()
        initializeLabels()
        startGame()
        
        let delay = SKAction.waitForDuration(4)
        let bloc = SKAction.runBlock( {self.beginGameplay()} )
        
        runAction(SKAction.sequence([delay,bloc]))
        
        ready()
        
playerHealth = 2000
        
        
        
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
        
        
        
    }
    
    func startGame() {
        
        //        runAction(SKAction.playSoundFileNamed("LevelOneMainLoopV2.mp3", waitForCompletion: true))
        
        initializePlayer()
        
        
        playerAlive = true
        
        
        //                        runAction(loopMusic)
        
        
        
        moveDown = childNodeWithName("moveDown") as? SKSpriteNode
        moveUp = childNodeWithName("moveUp") as? SKSpriteNode
        gunZone = childNodeWithName("gunZone") as? SKSpriteNode
        
        
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
                
                explodeFunc3(self, enemy)
                
            }
            
        }
        
        
        
        if player && (secondMask == smallRockCat) || player1 && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            
            playerHealth = playerHealth - 20
            
            if let enemy = enemy {
                explodeFunc(self, enemy)
                
                
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
                println("rocket contact")
                println("player health = \(playerHealth)")
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
            var oreChance: UInt32 = 0|1
            let orePiece = SKShapeNode(circleOfRadius: 10)
            orePiece.fillColor = UIColor(red:0.25, green:0.92, blue:0.46, alpha:1)
            orePiece.position = asteroid.position
            orePiece.glowWidth = 10
            
            if oreChance == ranNum {
                
                scene.addChild(orePiece)
                orePiece.physicsBody = SKPhysicsBody(circleOfRadius: 25)
                orePiece.physicsBody?.collisionBitMask = 0
                orePiece.physicsBody?.contactTestBitMask = playerCategory
                orePiece.physicsBody?.categoryBitMask = oreCategory
                
                
                let move = SKAction.moveToX( -scene.size.width, duration: 9)
                let remove = SKAction.removeFromParent()
                
                orePiece.runAction(SKAction.sequence([move,remove]))
                
                
            }
        }
        
        if player && (secondMask == oreCategory) || player1 && (firstMask == oreCategory) {
            let enemy = secondMask == oreCategory ? secondBody : firstBody
            
            enemy?.removeFromParent()
            enemy?.physicsBody = nil
            oreCount++
            
        }
        
        if (firstMask == playerProjectileOne) && (secondMask == smallRockCat) || (secondMask == playerProjectileOne) && (firstMask == smallRockCat) {
            
            let enemy = secondMask == smallRockCat ? secondBody as? SmallAsteroid : firstBody as? SmallAsteroid
            

            projectile?.physicsBody = nil
            projectile?.removeFromParent()
            bulletsHit++
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0
                
            {
                
                if let enemy = enemy {
                    
                    dropOre(self, enemy)
                    
                    explodeFunc(self, enemy)
                    
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
            bulletsHit++
            
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
        
        if playerBullet && (secondMask == shieldRunnerCat) || playerBullet1 && (firstMask == shieldRunnerCat) {
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit++
            
        }
        if playerBullet && (secondMask == mineCat) || playerBullet1 && (firstMask == mineCat) {
            
            let playerShip = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == mineCat ? secondBody as? Mine : firstBody as? Mine
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit++
            
            if let enemy = enemy {
                
                enemy.health = enemy.health - autoCannonDamage
                if enemy.health <= 0 {
                    explodeFunc(self, enemy)
                    enemy.removeFromParent()
                    currentScore += 10
                    enemiesDestroyed++

                }
            }
            
        }
        
        
        if playerBullet && (secondMask == strafeJetCat) || playerBullet1 && (firstMask == strafeJetCat) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == strafeJetCat ? secondBody as? LittleMinion : firstBody as? LittleMinion
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit++
            
 //~~~~~~~~           //            runAction(rico)
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0 {
                
                if let enemy = enemy {
                    explodeFunc2(self, enemy)
                    enemy.removeFromParent()
                    currentScore += 25
                    enemiesCount -= 1
                    enemiesDestroyed++
                    
                }
                
            }
            
        }
        
        if playerBullet && (secondMask == strafeJetCat) || playerBullet1 && (firstMask == strafeJetCat) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == strafeJetCat ? secondBody as? StrafeJet : firstBody as? StrafeJet
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit++
            
            enemy?.health = enemy!.health - autoCannonDamage
            
            if enemy?.health <= 0 {
                
                if let enemy = enemy {
                    explodeFunc2(self, enemy)
                    enemy.removeFromParent()
                    currentScore += 50
                    enemiesCount -= 1
                    enemiesDestroyed++

                    
                }
                
            }
            
        }
        
        if playerBullet && (secondMask == bargeCat) || playerBullet1 && (firstMask == bargeCat) {
            
            let enemy = secondMask == enemyCategoryOne ? secondBody as? ArtillaryBarge : firstBody as? ArtillaryBarge
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit++
            
//~~~~~~~~            //            runAction(rico2)
            
            if let enemy = enemy {
                
                enemy.health = enemy.health - autoCannonDamage
                
                if enemy.health <= 80 {
                    enemy.physicsBody?.allowsRotation = true
                    enemy.physicsBody?.angularVelocity = 0.1
                    
                }
                if enemy.health <= 0 {
                    enemy.removeFromParent()
                    explodeFunc2(self, enemy)
                    currentScore += 350
                    enemiesCount -= 1
                    enemiesDestroyed++

                    
                }
            }
        }
        
        
        if playerBullet && (secondMask == enemyCategoryOne) || playerBullet1 && (firstMask == enemyCategoryOne) {
            
            let projectile = secondMask == playerProjectileOne ? secondBody : firstBody
            let enemy = secondMask == enemyCategoryOne ? secondBody as? WeakJet : firstBody as? WeakJet
            
            projectile?.removeFromParent()
            projectile?.physicsBody = nil
            bulletsHit++
            
//~~~~~~~~~~~~            //            runAction(rico1)
            
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
                    enemiesDestroyed++

                    enemiesCount -= 1
                    
                    
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
    
    
    
    override func update(currentTime: CFTimeInterval) {
        
       levelTime++
        
        if levelTime == 8300 {
            
            levelCompleted(self)
            
        }
        
        
        if playerHealth < 300 {
            healthLabel.fontColor = UIColor.yellowColor()
        }
        if playerHealth < 150 {
            healthLabel.fontColor = UIColor.redColor()
        }
        
        if menuActive == true { return }
        
        
        if (playerUp == true) && (player.position.y < frame.height - 70) {
            player.position.y = player.position.y + 15
        }
        if (playerDown == true) && (player.position.y > frame.height - frame.height + 70) {
            player.position.y = player.position.y - 15
        }
        
        if (gunBool == true) && (bulletDelay > 12) {
            
            
            bulletsFired++
            
            //            if beamEnabled == true {
            //
            //                beamCannon(self)
            //            }
            
            autoCannon(self)
            bulletDelay = 0
            bulletDelay1 = 6
            
        }
        if (gunBool == true) && (bulletDelay1 > 12) {
            autoCannon1(self)
            bulletDelay1 = 0
            
            bulletsFired++

            
        }
        
        bulletDelay++
        bulletDelay1++
        
        if levelComplete == false {
            
            if gameOn == true {
                
                if playerAlive == true {
                    totalEllapsed++
                    strafeJetSpawnDelay++
                    minionDelay++
                    fighterWaveTimer++
                    weakJetTimer++
                    bargeTimer++
                    shieldTimer++
               
                   
                    singleMinion++
                    
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
                    
                    bargeSpawn(self)
                }
                
                if totalEllapsed == 7000 {
                    
                    bargeSpawn(self)
                }
                
                if totalEllapsed == 400 || totalEllapsed == 6500 {
                    var point1 = CGPoint(x: frame.size.width + 200, y: (frame.size.height / 2) + 300)
                    var point2 = CGPoint(x: frame.size.width + 180, y: (frame.size.height / 2) + 80)
                    var point3 = CGPoint(x: frame.size.width + 100, y: (frame.size.height / 2) - 100)
                    var point4 = CGPoint(x: frame.size.width + 60, y: (frame.size.height / 2) - 220)
                    var point5 = CGPoint(x: frame.size.width + 40, y: (frame.size.height / 2) - 30)
                    var point6 = CGPoint(x: frame.size.width + 10, y: (frame.size.height / 2) + 120)
                    
                    var mineField: [CGPoint] = [point1,point2,point3,point4,point5,point6]
                    
                    
                    for point in mineField {
                        
                        
                        layMines(self, point)
                        
                    }
                }
                
                
                
                if currentScore > 1000 && shieldTimer > 1200 {
                    
                    enemyFighter(self)
                    shieldTimer = 0
                    
                    enemiesCount++
                    
                }
                
                if singleMinion > 350 {
                    var rany = CGFloat(arc4random_uniform(300)) - 150
                    var point5 = CGPoint(x: frame.size.width + 30, y: player.position.y + rany)
                    
                    littionMinionSpawn(self, point5)
                    singleMinion = 0
                    
                    enemiesCount++
                    
                }
                
                if bargeTimer > 3500 {
                    var point3 = CGPoint(x: frame.size.width + 30, y: player.position.y - 100)
                    var point4 = CGPoint(x: frame.size.width + 30, y: player.position.y - 200)
                    var point5 = CGPoint(x: frame.size.width + 30, y: player.position.y)
                    var point6 = CGPoint(x: frame.size.width + 30, y: player.position.y + 100)
                    var minionArray: [CGPoint] = [point3,point4,point5,point6]
                    
                    for point in minionArray {
                        
                        littionMinionSpawn(self, point)
                        
                    }
                    
                    bargeTimer = 0
                    
                    enemiesCount += 4
                    
                }
                
                if (fighterWaveTimer > 2000 + minionRandomizer) && totalEllapsed > 4000 {
                    var point1 = CGPoint(x: frame.size.width + 150, y: frame.size.height)
                    var point2 = CGPoint(x: frame.size.width + 300, y: frame.size.height - 200)
                    var point3 = CGPoint(x: frame.size.width + 450, y: frame.size.height - 400)
                    let pattern1: [CGPoint] = [point1,point2,point3]
                    
                    var ranPointY = arc4random_uniform(100)
                    
                    for points in pattern1 {
                        
                        fighterJetWave(self, points, ranPointY)
                        fighterWaveTimer = 0
                    }
                    enemiesCount += 3
                    
                }
                
                if totalEllapsed > 600 {
                    if weakJetTimer > 200 + jetRandomizer {
                        weakJetSpawn(self)
                        weakJetTimer = 0
                        
                        enemiesCount++
                        
                    }
                }
                
                
                
                if totalEllapsed > 2000 {
                    if minionDelay > minionRandomizer + 500 {
                        
                        
                        var point1 = CGPoint(x: frame.size.width + 180, y: player.position.y + 120)
                        var point2 = CGPoint(x: frame.size.width + 180, y: player.position.y - 120)
                        var point3 = CGPoint(x: frame.size.width + 30, y: player.position.y)
                        let pattern1: [CGPoint] = [point1,point2,point3]
                        
                        for points in pattern1 {
                            
                            littionMinionSpawn(self, points)
                            minionDelay = 0
                            
                            
                            
                        }
                        enemiesCount += 3
                        
                    }
                }
                
                if totalEllapsed > 3000 {
                    if strafeJetSpawnDelay > spawnRandomizer + 600 {
                        
                        strafeJetSpawn(self)
                        strafeJetSpawnDelay = 0
                        
                        enemiesCount++
                        
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
            
            explodeFunc3(self, player)
            
            player.removeFromParent()
            
            playerAlive = false
            
            playerDeathScreen()
            
        }

        
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            if retryButton .containsPoint(location) {
                
                if playerAlive == true { return }
                
                beamEnabled = false
                uraniumBool = false
                explosiveBool = false
                
                oreCount = 0
                currentScore = 0
                bulletsFired = 0
                bulletsHit = 0
                enemiesDestroyed = 0
                
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
                
            }
            
            if gunZone .containsPoint(location)  {
                
                touchLocationX = location.x
                touchLocationY = location.y
                
                gunBool = true }
           
            if moveUp .containsPoint(location)   { playerUp = true }
            if moveDown .containsPoint(location) { playerDown = true }
            
        }
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            
            
            if gunZone .containsPoint(location) {
                
                touchLocationX = location.x
                touchLocationY = location.y
                
                gunBool = true }
            
            if nullZone.containsPoint(location) { gunBool = false }
            
            if nullMove.containsPoint(location) { playerUp = false; playerDown = false }
            
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            if gunZone .containsPoint(location)  { gunBool = false }
            if moveUp .containsPoint(location)   { playerUp = false }
            if moveDown .containsPoint(location) { playerDown = false }
            if nullMove.containsPoint(location) { playerUp = false; playerDown = false }
            
            
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
        playerHealth = 500 + playerHealthBonus
        
        
        
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
        scoreLabel.position = CGPoint(x: scene!.size.width * 0.05, y: scene!.size.height - 40)
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = UIColor.whiteColor()
        addChild(scoreLabel)
        
        healthLabel.text = "\(playerHealth)"
        healthLabel.fontSize = 50
        healthLabel.position = CGPoint(x: scene!.size.width *  0.25, y: scene!.size.height - 60)

        addChild(healthLabel)
        
      
        oreCount = 0
        oreLabel.text = "Ore:\(oreCount)"
        oreLabel.fontSize = 50
        oreLabel.position = CGPoint(x: scene!.size.width *  0.75, y: scene!.size.height - 60)
        oreLabel.fontColor = UIColor.greenColor()
        addChild(oreLabel)
        
        pauseLabel.text = "Menu"
        pauseLabel.fontSize = 40
        pauseLabel.position = CGPoint(x: scene!.size.width / 2, y: scene!.size.height - 60)
        addChild(pauseLabel)
        
        pauseButton.position = pauseLabel.position
        addChild(pauseButton)
        
    }
    
}


