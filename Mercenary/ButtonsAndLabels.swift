//
//  ButtonsAndLabels.swift
//  Mercenary
//
//  Created by Reed Carson on 7/17/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit

var scoreLabel = SKLabelNode(fontNamed: "ZrnicRg-Regular")
let healthLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
let oreLabel = SKLabelNode(fontNamed:"ZrnicRg-Regular")
var pauseLabel = SKLabelNode(fontNamed: "ZrnicRg-Regular")

var nullZone: SKSpriteNode!
var nullMove: SKSpriteNode!

let retryButton = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 250, height: 100))
let abortButton = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 250, height: 100))
let resumeButton = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 250, height: 100))
let returnButton = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 250, height: 100))
let upgradeSystemsButton = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 250, height: 100))
var pauseButton = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: 150, height: 70))