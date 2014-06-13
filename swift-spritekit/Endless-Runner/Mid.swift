//
//  Mid.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

class Mid: SKNode {
    let MID_DELTA_X: CGFloat = 0.64
    
    let _texture: SKTexture
    let _mid1: SKSpriteNode
    let _mid2: SKSpriteNode
    var _viewportX: CGFloat
    
    init() {
        _texture = SKTexture(imageNamed: "bg-mid")
        _mid1 = SKSpriteNode(texture: _texture)
        _mid2 = SKSpriteNode(texture: _texture)
        _viewportX = 0.0
        super.init()
        
        _mid1.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        _mid1.position = CGPoint(x: 0.0, y: 0.0)
        addChild(_mid1)
        
        _mid2.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        _mid2.position = CGPoint(x: 1024.0, y: 0.0)
        addChild(_mid2)
    }
    
    func setViewportX(newViewportX: CGFloat) {
        var distanceTravelled = newViewportX - _viewportX
        _viewportX = newViewportX
        
        var tempPoint = self.position;
        tempPoint.x -= distanceTravelled * MID_DELTA_X
        if tempPoint.x < -1024 {
            tempPoint.x += 1024
        }
        position = tempPoint
    }
}