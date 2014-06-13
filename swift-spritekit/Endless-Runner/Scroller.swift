//
//  Scroller.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

class Scroller: SKNode {
    let _far: Far
    let _mid: Mid
    let _front: Walls
    let _mapBuilder: MapBuilder
    var _viewportX: CGFloat
    
    init(node: SKNode, textureAtlas: SKTextureAtlas) {
        _viewportX = 0.0
        _far = Far()
        _mid = Mid()
        _front = Walls(textureAtlas: textureAtlas);
        _mapBuilder = MapBuilder(walls: _front)
        super.init()
        
        node.addChild(_far)
        node.addChild(_mid)
        node.addChild(_front)
        
        setViewportX(_viewportX)
    }
    
    func setViewportX(viewportX: CGFloat) {
        _viewportX = viewportX
        _far.setViewportX(_viewportX)
        _mid.setViewportX(_viewportX)
        _front.setViewportX(_viewportX)
    }
    
    func getViewportX() -> CGFloat {
        return _viewportX
    }
    
    func moveViewportXBy(distance: CGFloat) {
        var newViewportX = _viewportX + distance
        setViewportX(newViewportX)
    }
}