//
//  MainMenuScene.swift
//  Mercenary
//
//  Created by Reed Carson on 7/3/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import UIKit
import SpriteKit


let bgStars = SKSpriteNode(imageNamed: "mmStarSlide1")
let bgStars1 = SKSpriteNode(imageNamed: "mmStarSlide1")

var startButtonTapped: Bool = false
let startButton = SKLabelNode(fontNamed: "HelveticaNeue-UltraLight")



class MainMenuScene: SKScene {
    
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
           
            let location = touch.locationInNode(self)
            
            if (startButtonTapped == false) {
                
                
                let fadeToBlack = SKShapeNode(rectOfSize: CGSize(width: frame.width, height: frame.height))
                
                fadeToBlack.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
                fadeToBlack.alpha = 0
                fadeToBlack.fillColor = UIColor.blackColor()
                fadeToBlack.zPosition = 100
                
                
                let fadeOut = SKAction.fadeAlphaTo(1, duration: 2)
                let sceneChange = SKAction.runBlock({ () -> Void in
                    
                    let scene =  MainGameMenu.unarchiveFromFile("MainGameMenu") as? MainGameMenu
                    let transistion = SKTransition.crossFadeWithDuration(2)
                    self.scene?.view?.presentScene(scene)
                    
                    
                    
                })
                let sceneTransition = SKAction.sequence([fadeOut,sceneChange])

                
                addChild(fadeToBlack)
                
                fadeToBlack.runAction(sceneTransition)
                
                startButtonTapped = true
            
                
                
                
                
                }
            
            
        }
        
        
    }
   
   

    override func didMoveToView(view: SKView) {
        
       size.width = 1334
        size.height = 750
        
        startButton.text = "tap to start"
        startButton.fontSize = 50
        startButton.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 100)
        
        addChild(startButton)
        
      
        
        let titleLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
        titleLabel.text = "MERCENARY"
        titleLabel.fontSize = 100
        titleLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        addChild(titleLabel)
        
        let fadeOut = SKAction.fadeAlphaTo(0, duration: 2)
        let fadeIn = SKAction.fadeAlphaTo(1, duration: 2)
        let fadeSequence = SKAction.sequence([fadeOut,fadeIn])
        let repeat = SKAction.repeatActionForever(fadeSequence)
        titleLabel.runAction(repeat)

          startButton.runAction(repeat)
        
        let loopMusic = SKAction.repeatActionForever(SKAction.playSoundFileNamed("IntroThemeAughtV2.mp3", waitForCompletion: true))
        
        runAction(loopMusic)
        
            initializeBackground()
        
        
        
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
//        BGScroll()
        
    }

    func initializeBackground() {
        
        
        
        bgStars.anchorPoint = CGPointZero
        bgStars.position = CGPoint(x: 0, y: 0)
        bgStars.zPosition = -5
        addChild(bgStars)
        
        bgStars1.anchorPoint = CGPointZero
        bgStars1.position = CGPoint(x: bgStars.size.width - 1, y: 0)
        bgStars1.zPosition = -5
        addChild(bgStars1)
        
    }
    
  

}
