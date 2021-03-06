//
//  MainGameMenu.swift
//  Mercenary
//
//  Created by Reed Carson on 7/4/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import UIKit
import SpriteKit


var playButton: SKSpriteNode!


let bg11 = SKSpriteNode(imageNamed: "mmStarSlide1")
let bg22 = SKSpriteNode(imageNamed: "mmStarSlide1")

class MainGameMenu: SKScene {
   
    override func didMoveToView(view: SKView) {
        
        
       initializeBackground()
        
        size.width = 1334
        size.height = 750
        backgroundColor = UIColor.blackColor()
        
        let starsBG = SKSpriteNode(imageNamed: "spaceTruckMainOverlay")
        starsBG.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        starsBG.size = CGSize(width: frame.width, height: frame.height)
        addChild(starsBG)
        
        
        
        
        playButton = childNodeWithName("demoButton") as? SKSpriteNode
        playButton.hidden = true
    
    }


    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in (touches ) {
            
            let location = touch.locationInNode(self)
            
            
            if playButton .containsPoint(location) {
                
                removeActionForKey("loopKey")
                
                let scene = BattleScene.unarchiveFromFile("BattleScene") as? BattleScene
                let transition = SKTransition.crossFadeWithDuration(2)
                self.scene?.view?.presentScene(scene!, transition: transition)
                
                
            }
            
        }
    }
    
          func initializeBackground() {
           
        
        bg11.anchorPoint = CGPointZero
        bg11.position = CGPoint(x: 0, y: 0)
        bg11.zPosition = -5
        addChild(bg11)
        
        bg22.anchorPoint = CGPointZero
        bg22.position = CGPoint(x: bg11.size.width - 1, y: 0)
        bg22.zPosition = -5
        addChild(bg22)
        
    }
    
        func BGScroll() {
        
        
        
        bg11.position = CGPointMake(bg11.position.x - 2, bg11.position.y)
        bg22.position = CGPointMake(bg22.position.x - 2, bg22.position.y)
        
        
        if(bg11.position.x < -bg11.size.width)
            
        {
            
            bg11.position = CGPointMake(bg22.position.x + bg11.size.width, bg22.position.y)
            
        }
        
        if(bg22.position.x < -bg22.size.width)
            
        {
            
            bg22.position = CGPointMake(bg11.position.x + bg22.size.width, bg11.position.y)
            
        }
    }
    


    
    override func update(currentTime: NSTimeInterval) {
        
        BGScroll()
        
    }

}

  



