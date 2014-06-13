//
//  WallSlicePool.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 12/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//  

import Foundation
import SpriteKit

class WallSlicePool {
    let _textureAtlas :SKTextureAtlas
    var _windows      :SKSpriteNode[] = []
    var _decorations  :SKSpriteNode[] = []
    var _frontEdges   :SKSpriteNode[] = []
    var _backEdges    :SKSpriteNode[] = []
    var _steps        :SKSpriteNode[] = []
    
    init(textureAtlas: SKTextureAtlas) {
        _textureAtlas = textureAtlas
        createWindows()
        createDecorations()
        createFrontEdges()
        createBackEdges()
        createSteps()
    }
    
    func borrowWindow() -> SKSpriteNode {
        return _windows.removeAtIndex(0)
    }
    
    func returnWindow(sprite: SKSpriteNode) {
        _windows.append(sprite)
    }
    
    func borrowDecoration() -> SKSpriteNode {
        return _decorations.removeAtIndex(0)
    }
    
    func returnDecoration(sprite: SKSpriteNode) {
        _decorations.append(sprite)
    }
    
    func borrowFrontEdge() -> SKSpriteNode {
        return _frontEdges.removeAtIndex(0)
    }
    
    func returnFrontEdge(sprite: SKSpriteNode) {
        _frontEdges.append(sprite)
    }
    
    func borrowBackEdge() -> SKSpriteNode {
        return _backEdges.removeAtIndex(0)
    }
    
    func returnBackEdge(sprite: SKSpriteNode) {
        _backEdges.append(sprite)
    }
    
    func borrowStep() -> SKSpriteNode {
        return _steps.removeAtIndex(0)
    }
    
    func returnStep(sprite :SKSpriteNode) {
        _steps.append(sprite)
    }
    
    func createWindows() {
        _windows = []
        addWindowSprites(6, textureName: "window-01")
        addWindowSprites(6, textureName: "window-02")
        
        shuffle(&_windows)
    }
    
    func createDecorations() {
        _decorations = []
        addDecorationSprites(6, textureName: "decoration-01")
        addDecorationSprites(6, textureName: "decoration-02")
        
        shuffle(&_decorations)
    }
    
    func createFrontEdges() {
        _frontEdges = []
        addFrontEdgeSprites(2, textureName: "edge-01")
        addFrontEdgeSprites(2, textureName: "edge-02")
        
        shuffle(&_frontEdges)
    }
    
    func createBackEdges() {
        _backEdges = []
        addBackEdgeSprites(2, textureName: "edge-01")
        addBackEdgeSprites(2, textureName: "edge-02")
        
        shuffle(&_backEdges)
    }
    
    func createSteps() {
        _steps = []
        addStepSprites(2, textureName: "step-01")
    }
    
    func addWindowSprites(amount: NSInteger, textureName: String) {
        for i in 0..amount {
            var sprite = SKSpriteNode(texture: _textureAtlas.textureNamed(textureName))
            sprite.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            _windows.append(sprite)
        }
    }
    
    func addDecorationSprites(amount: NSInteger, textureName: String) {
        for i in 0..amount {
            var sprite = SKSpriteNode(texture: _textureAtlas.textureNamed(textureName))
            sprite.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            _decorations.append(sprite)
        }
    }
    
    func addFrontEdgeSprites(amount: NSInteger, textureName: String) {
        for i in 0..amount {
            var sprite = SKSpriteNode(texture: _textureAtlas.textureNamed(textureName))
            sprite.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            _frontEdges.append(sprite)
        }
    }
    
    func addBackEdgeSprites(amount: NSInteger, textureName: String) {
        for i in 0..amount {
            var sprite = SKSpriteNode(texture: _textureAtlas.textureNamed(textureName))
            sprite.anchorPoint = CGPoint(x: 1.0, y: 0.0)
            sprite.xScale = -1.0
            _backEdges.append(sprite)
        }
    }
    
    func addStepSprites(amount: NSInteger, textureName: String) {
        for i in 0..amount {
            var sprite = SKSpriteNode(texture: _textureAtlas.textureNamed(textureName))
            sprite.anchorPoint = CGPoint(x: 0.0, y: -0.25)
            _steps.append(sprite)
        }
    }
    
    func shuffle(inout array: SKSpriteNode[]) {
        var len = array.count
        var shuffles = len * 3
        for i in 0..shuffles {
            var slice = array.removeLast()
            var pos: Int = Int(arc4random() % UInt32(len - 1))
            array.insert(slice, atIndex: pos)
        }
    }
}