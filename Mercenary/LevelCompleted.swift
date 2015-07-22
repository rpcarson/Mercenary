//
//  LevelCompleted.swift
//  Mercenary
//
//  Created by Reed Carson on 7/20/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit



var levelCompleteArray: [SKNode] = []
func levelCompleted(scene: SKScene) {
    
    player.removeFromParent()
    
    completeLabel.text = "Mission Complete!"
    completeLabel.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.75)
    completeLabel.fontSize = 100
    completeLabel.zPosition = 10
    scene.addChild(completeLabel)
    levelCompleteArray.append(completeLabel)
    
    accuracyLabel.text = "Accuracy: %\(accuracy)"
    accuracyLabel.fontSize = 50
    accuracyLabel.zPosition = 10
    accuracyLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.5)
    scene.addChild(accuracyLabel)
    levelCompleteArray.append(accuracyLabel)
    
    shotsLabel.text = "Shots Fired: \(bulletsFired)"
    shotsLabel.fontSize = 50
    shotsLabel.zPosition = 10
    shotsLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.6)
    scene.addChild(shotsLabel)
    levelCompleteArray.append(shotsLabel)
    
    enemiesLabel.text = "Pirates Wasted: \(enemiesDestroyed)"
    enemiesLabel.fontSize = 50
    enemiesLabel.zPosition = 10
    enemiesLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.4)
    scene.addChild(enemiesLabel)
    levelCompleteArray.append(enemiesLabel)
    
    totalLabel.text = "Total Score: \(currentScore)"
    totalLabel.fontSize = 50
    totalLabel.zPosition = 10
    totalLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.3)
    scene.addChild(totalLabel)
    levelCompleteArray.append(totalLabel)
 
    endOreLabel.text = "Ore Collected: \(oreCount)"
    endOreLabel.fontSize = 50
    endOreLabel.zPosition = 10
    endOreLabel.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.2)
    scene.addChild(endOreLabel)
    levelCompleteArray.append(endOreLabel)
    
    continueLabel.text = "Continue"
    continueLabel.fontSize = 50
    continueLabel.zPosition = 10
    continueLabel.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.1)
    scene.addChild(continueLabel)
    levelCompleteArray.append(continueLabel)
    
    
    healthLabel.hidden = true
    oreLabel.hidden = true
    scoreLabel.hidden = true
    pauseLabel.hidden = true
    
    let fullTruck = SKSpriteNode(imageNamed: "truck1")
    fullTruck.position = CGPoint(x: scene.size.width * 0.3, y: scene.size.height / 2)
    scene.addChild(fullTruck)
    levelCompleteArray.append(fullTruck)
    
    
    // CREATE CONTINUE BUTTON FUNCTIONALITY -  return to main menu ..... finalize temp main menu
    
    // continue will also need to dismiss the background and scorelabels
    
    
    
}