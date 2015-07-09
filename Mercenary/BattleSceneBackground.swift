//
//  Background.swift
//  Mercenary
//
//  Created by Reed Carson on 7/9/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit



let bg1 = SKSpriteNode(imageNamed: "cloudoverlay")
let bg2 = SKSpriteNode(imageNamed: "cloudoverlay")

func BGScroll() {
    
    bg1.position = CGPointMake(bg1.position.x - 7, bg1.position.y)
    bg2.position = CGPointMake(bg2.position.x - 7, bg2.position.y)
    
    
    if(bg1.position.x < -bg1.size.width)
        
    {
        
        bg1.position = CGPointMake(bg2.position.x + bg1.size.width, bg2.position.y)
        
    }
    
    if(bg2.position.x < -bg2.size.width)
        
    {
        
        bg2.position = CGPointMake(bg1.position.x + bg2.size.width, bg1.position.y)
        
    }
}


