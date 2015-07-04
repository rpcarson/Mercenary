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



func delay1(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
