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
    
   
 
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            if (startButtonTapped == false) {
                
                
                let fadeToBlack = SKShapeNode(rectOf: CGSize(width: frame.width, height: frame.height))
                
                fadeToBlack.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
                fadeToBlack.alpha = 0
                fadeToBlack.fillColor = UIColor.black
                fadeToBlack.zPosition = 100
                
                
                let fadeOut = SKAction.fadeAlpha(to: 1, duration: 2)
                let sceneChange = SKAction.run({ () -> Void in
                    
                    let scene =  MainGameMenu.unarchiveFromFile(file: "MainGameMenu") as? MainGameMenu
                    self.scene?.view?.presentScene(scene)
                })
                let sceneTransition = SKAction.sequence([fadeOut,sceneChange])

                
                addChild(fadeToBlack)
                
                fadeToBlack.run(sceneTransition)
                
                startButtonTapped = true
                }

        }
        
        
    }

    override func didMove(to view: SKView) {
        
       size.width = 1334
        size.height = 750
        
        initializeBackground()

        
        
        startButton.text = "tap to start"
        startButton.fontSize = 50
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        
        addChild(startButton)
        
      
        
        let titleLabel = SKLabelNode(fontNamed:"HelveticaNeue-UltraLight")
        titleLabel.text = "MERCENARY"
        titleLabel.fontSize = 100
        titleLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        addChild(titleLabel)
        
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: 2)
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: 2)
        let fadeSequence = SKAction.sequence([fadeOut,fadeIn])
        let repeatAction = SKAction.repeatForever(fadeSequence)
        titleLabel.run(repeatAction)

        startButton.run(repeatAction)
        
        _ = SKAction.repeatForever(SKAction.playSoundFileNamed("IntroThemeAughtV2.mp3", waitForCompletion: true))
        
        
//        runAction((loopMusic), withKey: "loopKey")
        
        
        
        
        
        
    }

    func initializeBackground() {
        
        
        
        bgStars.anchorPoint = CGPoint.zero
        bgStars.position = CGPoint(x: 0, y: 0)
        bgStars.zPosition = -5
        addChild(bgStars)
        
//        bgStars1.anchorPoint = CGPointZero
//        bgStars1.position = CGPoint(x: bgStars.size.width - 1, y: 0)
//        bgStars1.zPosition = -5
//        addChild(bgStars1)
        
    }
    
  

}
