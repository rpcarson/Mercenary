//
//  MainMenuScene.swift
//  Mercenary
//
//  Created by Reed Carson on 7/3/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import UIKit
import SpriteKit


let bg1 = SKSpriteNode(imageNamed: "cloudoverlay")
let bg2 = SKSpriteNode(imageNamed: "cloudoverlay")

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
        
//        runAction(loopMusic)
        
            initializeBackground()
        
        
        
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        BGScroll()
        
    }

    func initializeBackground() {
        
        var bg = SKSpriteNode(imageNamed: "starryRedMoon")
        bg.size = CGSize(width: frame.width, height: frame.height)
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        bg.zPosition = -10
        addChild(bg)
        
        bg1.anchorPoint = CGPointZero
        bg1.position = CGPoint(x: 0, y: 0)
        bg1.zPosition = -5
        addChild(bg1)
        
        bg2.anchorPoint = CGPointZero
        bg2.position = CGPoint(x: bg1.size.width - 1, y: 0)
        bg2.zPosition = -5
        addChild(bg2)
        
    }
    
    func BGScroll() {
        
        bg1.position = CGPointMake(bg1.position.x - 2, bg1.position.y)
        bg2.position = CGPointMake(bg2.position.x - 2, bg2.position.y)
        
        
        if(bg1.position.x < -bg1.size.width)
            
        {
            
            bg1.position = CGPointMake(bg2.position.x + bg1.size.width, bg2.position.y)
            
        }
        
        if(bg2.position.x < -bg2.size.width)
            
        {
            
            bg2.position = CGPointMake(bg1.position.x + bg2.size.width, bg1.position.y)
            
        }
    }

}
