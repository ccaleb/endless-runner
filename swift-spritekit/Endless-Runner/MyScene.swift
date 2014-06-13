//
//  MyScene.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

class MyScene: SKScene {
    
    let MIN_SCROLL_SPEED:    CGFloat = 5.0
    let MAX_SCROLL_SPEED:    CGFloat = 15.0
    let SCROLL_ACCELERATION: CGFloat = 0.005
    
    let _textureAtlas: SKTextureAtlas
    let _scroller: Scroller?
    var _scrollSpeed :CGFloat
    var _viewportX :CGFloat
    
    init(size: CGSize) {
        _viewportX = 0.0
        _scrollSpeed = MIN_SCROLL_SPEED
        _textureAtlas = SKTextureAtlas(named: "wallslices")
        super.init(size: size)
        
        _scroller = Scroller(node: self, textureAtlas: _textureAtlas)
        addChild(_scroller)
    }
    
    override func update(currentTime: NSTimeInterval) {
        _scrollSpeed += SCROLL_ACCELERATION
        if _scrollSpeed > MAX_SCROLL_SPEED {
            _scrollSpeed = MAX_SCROLL_SPEED
        }
        _scroller!.moveViewportXBy(_scrollSpeed);
    }
}