//
//  MissionMenu.swift
//  Mercenary
//
//  Created by Reed Carson on 7/14/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit


class missionMenuOverlay: SKSpriteNode {
    
 

    
    
}


func missionMenuMain(scene: SKScene) {
    
    let mainOverlay = SKSpriteNode(imageNamed: "menuOverlay")

    mainOverlay.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    mainOverlay.size = CGSize(width: scene.size.width, height: scene.size.height)
    mainOverlay.zPosition = 50
    
//    scene.addChild(mainOverlay)
    
    scene.removeAllChildren()
    

}

func missionMenuDismiss(scene: SKScene) {
    
    
}