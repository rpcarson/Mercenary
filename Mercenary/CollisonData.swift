//
//  CollisonData.swift
//  Mercenary
//
//  Created by Reed Carson on 7/2/15.
//  Copyright (c) 2015 Reed Carson. All rights reserved.
//

import Foundation
import SpriteKit



var playerCategory: UInt32 = 1

var playerProjectileOne: UInt32 = 2

var enemyCategoryOne: UInt32 = 3

var enemyAttackCategory: UInt32 = 4

var smallRockCat: UInt32 = 5

var bomberCategory: UInt32 = 6

var fighterCategory: UInt32 = 7

var largeRockCat: UInt32 = 8

var enemyRocketCat: UInt32 = 9

var oreCategory: UInt32 = 10

var enemyBulletCat: UInt32 = 11

var strafeJetCat: UInt32 = 12

var minionCat: UInt32 = 14


func delay1(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
