//
//  Background.swift
//  Mercenary
//
//  Created by Reed Carson on 7/9/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit



let bg1 = SKSpriteNode(imageNamed: "starOverlay")
let bg2 = SKSpriteNode(imageNamed: "starOverlay")
let redStarsTex = SKTexture(imageNamed: "redStarBG1")
let bgMain = SKSpriteNode(texture: redStarsTex)
let bgMain1 = SKSpriteNode(texture: redStarsTex)

func BGScroll() {
    
    bg1.position = CGPoint(x: bg1.position.x - 12, y: bg1.position.y)
    bg2.position = CGPoint(x: bg2.position.x - 12, y: bg2.position.y)
    
    
    if(bg1.position.x < -bg1.size.width)
        
    {
        
        bg1.position = CGPoint(x: bg2.position.x + bg1.size.width, y: bg2.position.y)
        
    }
    
    if(bg2.position.x < -bg2.size.width)
        
    {
        
        bg2.position = CGPoint(x: bg1.position.x + bg2.size.width, y: bg1.position.y)
        
    }
}

func BGScroll2() {
    
    bgMain.position = CGPoint(x: bgMain.position.x - 0.5, y: bgMain.position.y)
    bgMain1.position = CGPoint(x: bgMain1.position.x - 0.5, y: bgMain1.position.y)
    
    
    if(bgMain.position.x < -bgMain.size.width)
        
    {
        
        bgMain.position = CGPoint(x: bgMain1.position.x + bgMain.size.width, y: bgMain1.position.y)
        
    }
    
    if(bgMain1.position.x < -bgMain1.size.width)
        
    {
        
        bgMain1.position = CGPoint(x: bgMain.position.x + bgMain1.size.width, y: bgMain.position.y)
        
    }
}

