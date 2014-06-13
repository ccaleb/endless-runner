//
//  Walls.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 13/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

class Walls: SKNode {
    let VIEWPORT_WIDTH: CGFloat = 1024.0
    let VIEWPORT_NUM_SLICES: NSInteger
    
    let _pool: WallSlicePool
    var _slices: WallSlice[]
    var _viewportX: CGFloat
    var _viewportSliceX: Int
    var _borrowWallSliceLookup: (() -> SKSpriteNode)[] = []
    var _returnWallSliceLookup: ((SKSpriteNode) -> ())[] = []
    
    init(textureAtlas: SKTextureAtlas) {
        VIEWPORT_NUM_SLICES = NSInteger(ceil(CDouble(VIEWPORT_WIDTH / WALL_SLICE_WIDTH))) + 1
        
        _pool = WallSlicePool(textureAtlas: textureAtlas)
        
        _slices = []
        
        _viewportX = 0
        _viewportSliceX = 0
        
        super.init()
        
        createLookupTables()
    }
    
    func setViewportX(newViewportX: CGFloat) {
        _viewportX = checkViewportXBounds(newViewportX)
        let prevViewportSliceX = _viewportSliceX
        _viewportSliceX = NSInteger(floor(CDouble(_viewportX) / CDouble(WALL_SLICE_WIDTH)))
        removeOldSlices(prevViewportSliceX)
        addNewSlices()
    }
    
    func addSlice(sliceType: SliceType, y: CGFloat = 0) {
        let slice = WallSlice(type: sliceType, y: y)
        _slices.append(slice)
    }
    
    func checkViewportXBounds(var newViewportX: CGFloat) -> CGFloat {
        var maxViewportX = CGFloat(_slices.count - VIEWPORT_NUM_SLICES) * WALL_SLICE_WIDTH
        if newViewportX < 0 {
            newViewportX = 0
        } else if newViewportX > maxViewportX {
            newViewportX = maxViewportX
        }
        
        return newViewportX
    }
    
    func addNewSlices() {
        let firstX :NSInteger = -NSInteger(_viewportX % WALL_SLICE_WIDTH)
        for var i: NSInteger = _viewportSliceX, sliceIndex = 0;
            i < _viewportSliceX + VIEWPORT_NUM_SLICES;
            i++, sliceIndex++ {
                let slice = _slices[i]
                if slice.sprite == nil && slice.type != .Gap {
                    slice.sprite = borrowWallSlice(slice.type)
                    if let sprite = slice.sprite {
                        let x = CGFloat(firstX) + (CGFloat(sliceIndex) * WALL_SLICE_WIDTH)
                        sprite.position = CGPoint(x: x, y: slice.y)
                    }
                    addChild(slice.sprite)
                } else if slice.sprite != nil {
                    if let sprite = slice.sprite {
                        let x = CGFloat(firstX) + (CGFloat(sliceIndex) * WALL_SLICE_WIDTH)
                        let y = sprite.position.y
                        sprite.position = CGPoint(x: x, y: y)
                }
            }
        }
    }
    
    func removeOldSlices(prevViewportSliceX: NSInteger) {
        var numOldSlices = _viewportSliceX - prevViewportSliceX
        if numOldSlices > VIEWPORT_NUM_SLICES {
            numOldSlices = VIEWPORT_NUM_SLICES
        }
        
        for i in prevViewportSliceX..(prevViewportSliceX + numOldSlices) {
            let slice = _slices[i]
            if let sprite = slice.sprite {
                returnWallSlice(slice.type, sprite: sprite)
                sprite.removeFromParent()
                slice.sprite = nil
            }
        }
    }
    
    func createLookupTables() {
        _borrowWallSliceLookup = Array(count:5, repeatedValue:_pool.borrowWindow)
        _borrowWallSliceLookup[SliceType.Front.toRaw()] = _pool.borrowFrontEdge
        _borrowWallSliceLookup[SliceType.Back.toRaw()] = _pool.borrowBackEdge
        _borrowWallSliceLookup[SliceType.Step.toRaw()] = _pool.borrowStep
        _borrowWallSliceLookup[SliceType.Decoration.toRaw()] = _pool.borrowDecoration
        _borrowWallSliceLookup[SliceType.Window.toRaw()] = _pool.borrowWindow
        
        _returnWallSliceLookup = Array(count:5, repeatedValue:_pool.returnWindow)
        _returnWallSliceLookup[SliceType.Front.toRaw()] = _pool.returnFrontEdge
        _returnWallSliceLookup[SliceType.Back.toRaw()] = _pool.returnBackEdge
        _returnWallSliceLookup[SliceType.Step.toRaw()] = _pool.returnStep
        _returnWallSliceLookup[SliceType.Decoration.toRaw()] = _pool.returnDecoration
        _returnWallSliceLookup[SliceType.Window.toRaw()] = _pool.returnWindow
    }
    
    func borrowWallSlice(sliceType: SliceType) -> SKSpriteNode {
        return _borrowWallSliceLookup[sliceType.toRaw()]()
    }
    
    func returnWallSlice(sliceType: SliceType, sprite: SKSpriteNode) {
        _returnWallSliceLookup[sliceType.toRaw()](sprite)
    }
}