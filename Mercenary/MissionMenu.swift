//
//  MissionMenu.swift
//  Mercenary
//
//  Created by Reed Carson on 7/14/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


var missionMenuItems: [SKNode] = []
func missionMenu(scene: SKScene) {
    
    menuActive = true
    pauseLabel.hidden = true
    
    let menuOverlay = SKSpriteNode(imageNamed: "menuOverlay")
    menuOverlay.size = scene.size
    menuOverlay.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    menuOverlay.zPosition = 10
    scene.addChild(menuOverlay)
    
    let menuLabel = SKLabelNode(fontNamed:"Xperia")
    let resumeLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
    let abortLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
    let upgradeSystemsLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
    
    upgradeSystemsLabel.text = "Upgrade Systems"
    upgradeSystemsLabel.position = CGPoint(x: scene.size.width * 0.25, y: scene.size.height * 0.5)
    upgradeSystemsLabel.fontSize = 60
    upgradeSystemsLabel.zPosition = 10
    menuLabel.text = "LoL Snacks"
    menuLabel.fontSize = 100
    menuLabel.alpha = 1
    menuLabel.zPosition = 10
    menuLabel.position = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.75)
    resumeLabel.text = "Resume Mission"
    resumeLabel.fontSize = 60
    resumeLabel.alpha = 1
    resumeLabel.zPosition = 10
    resumeLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.5)
    abortLabel.text = "Abort Mission"
    abortLabel.fontSize = 60
    abortLabel.alpha = 1
    abortLabel.zPosition = 10
    abortLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.25)
    
    scene.addChild(resumeLabel)
    scene.addChild(abortLabel)
    scene.addChild(menuLabel)
    scene.addChild(upgradeSystemsLabel)
    
    abortButton.position = abortLabel.position
    scene.addChild(abortButton)
    resumeButton.position = resumeLabel.position
    scene.addChild(resumeButton)
    upgradeSystemsButton.position = upgradeSystemsLabel.position
    scene.addChild(upgradeSystemsButton)
    

    
    
    missionMenuItems.append(upgradeSystemsButton)
    missionMenuItems.append(abortButton)
    missionMenuItems.append(resumeButton)
    missionMenuItems.append(abortLabel)
    missionMenuItems.append(resumeLabel)
    missionMenuItems.append(menuLabel)
    missionMenuItems.append(menuOverlay)
    missionMenuItems.append(upgradeSystemsLabel)
    
    scene.paused = true

}

