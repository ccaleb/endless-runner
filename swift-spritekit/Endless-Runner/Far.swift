//
//  Far.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

class Far: SKNode {
    let FAR_DELTA_X: CGFloat = 0.32
    
    let _texture: SKTexture
    let _far1: SKSpriteNode
    let _far2: SKSpriteNode
    var _viewportX: CGFloat
    
    init() {
        _texture = SKTexture(imageNamed: "bg-far")
        _far1 = SKSpriteNode(texture: _texture)
        _far2 = SKSpriteNode(texture: _texture)
        _viewportX = 0.0
        super.init()
        
        _far1.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        _far1.position = CGPoint(x: 0.0, y: 256.0)
        addChild(_far1)
        
        _far2.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        _far2.position = CGPoint(x: 1024.0, y: 256.0)
        addChild(_far2)
    }
    
    func setViewportX(newViewportX: CGFloat) {
        var distanceTravelled = newViewportX - _viewportX
        _viewportX = newViewportX
        
        var tempPoint = self.position;
        tempPoint.x -= distanceTravelled * FAR_DELTA_X
        if tempPoint.x < -1024 {
            tempPoint.x += 1024
        }
        position = tempPoint
    }
}
