//
//  MainGameMenu.swift
//  Mercenary
//
//  Created by Reed Carson on 7/4/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import UIKit
import SpriteKit


var demoButton: SKSpriteNode!

class MainGameMenu: SKScene {
   
    override func didMoveToView(view: SKView) {
        size.width = 1334
        size.height = 750
        backgroundColor = UIColor.blackColor()
        
        let starsBG = SKSpriteNode(imageNamed: "justStars")
        starsBG.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        starsBG.size = CGSize(width: frame.width, height: frame.height)
        addChild(starsBG)
        
        
        demoButton = childNodeWithName("demoButton") as? SKSpriteNode
        
    }


    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            
            if demoButton .containsPoint(location) {
                
                let scene = BattleScene.unarchiveFromFile("BattleScene") as? BattleScene
                let transition = SKTransition.crossFadeWithDuration(2)
                self.scene?.view?.presentScene(scene, transition: transition)
                
                
            }
            
        }
        
        
        
    }


}
