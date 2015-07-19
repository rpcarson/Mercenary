//
//  UpgradeMenu.swift
//  Mercenary
//
//  Created by Reed Carson on 7/17/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit

func upgradeSystemsMenu(scene: SKScene) {
    
    for node in missionMenuItems { node.removeFromParent() }
    
    
    
    
    
    let menuOverlay = SKSpriteNode(imageNamed: "menuOverlay")
    menuOverlay.size = scene.size
    menuOverlay.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    menuOverlay.zPosition = 10
    scene.addChild(menuOverlay)
    
    let menuLabel = SKLabelNode(fontNamed:"Xperia")
    let previousScreen = SKLabelNode(fontNamed:"ZrnicRg-Regular")
    let abortLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
    let upgradeSystemsLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
    
    upgradeSystemsLabel.text = "Upgrade Weapon Stuff"
    upgradeSystemsLabel.position = CGPoint(x: scene.size.width * 0.25, y: scene.size.height * 0.5)
    upgradeSystemsLabel.fontSize = 50
    upgradeSystemsLabel.zPosition = 10
    menuLabel.text = "Ship Systems"
    menuLabel.fontSize = 75
    menuLabel.alpha = 1
    menuLabel.zPosition = 10
    menuLabel.position = CGPoint(x: scene.size.width / 2, y: scene.size.height * 0.75)
    previousScreen.text = "Previous Menu"
    previousScreen.fontSize = 40
    previousScreen.alpha = 1
    previousScreen.zPosition = 10
    previousScreen.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.5)
    abortLabel.text = "Abort Mission"
    abortLabel.fontSize = 60
    abortLabel.alpha = 1
    abortLabel.zPosition = 10
    abortLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.25)
    
    scene.addChild(previousScreen)
    scene.addChild(abortLabel)
    scene.addChild(menuLabel)
    scene.addChild(upgradeSystemsLabel)
    
    
    
}