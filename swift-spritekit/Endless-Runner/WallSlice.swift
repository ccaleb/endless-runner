//
//  WallSlice.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

let WALL_SLICE_WIDTH: CGFloat = 128

enum SliceType: Int {
    case Front = 0, Back, Step, Decoration, Window, Gap
}

class WallSlice {
    
    let type:   SliceType
    let y:      CGFloat
    var sprite: SKSpriteNode?
    
    init(type: SliceType, y: CGFloat) {
        self.type = type
        self.y    = y
    }
}