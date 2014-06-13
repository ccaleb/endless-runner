//
//  MapBuilder.swift
//  Endless-Runner
//
//  Created by Christopher Caleb on 13/06/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

import Foundation
import SpriteKit

class MapBuilder {
    let WALL_HEIGHTS: CGFloat[] = [
        -256, // Lowest slice
        -192,
        -128,
         -64,
           0  // Highest slice
    ]
    
    let _walls :Walls
    
    init(walls: Walls) {
        _walls = walls
        createMap()
    }
    
    func createMap() {
        createWallSpanWithHeight(3, spanLength: 9, noFront: true)
        createGap(1)
        createWallSpanWithHeight(1, spanLength: 30)
        createGap(1)
        createWallSpanWithHeight(2, spanLength: 18)
        createGap(1)
        createSteppedWallSpanWithHeight(2, spanALength: 5, spanBLength: 28)
        createGap(1)
        createWallSpanWithHeight(1, spanLength: 10)
        createGap(1)
        createWallSpanWithHeight(2, spanLength: 6)
        createGap(1)
        createWallSpanWithHeight(1, spanLength: 8)
        createGap(1)
        createWallSpanWithHeight(2, spanLength: 6)
        createGap(1)
        createWallSpanWithHeight(1, spanLength: 8)
        createGap(1)
        createWallSpanWithHeight(2, spanLength: 7)
        createGap(1)
        createWallSpanWithHeight(1, spanLength: 16)
        createGap(1)
        createWallSpanWithHeight(2, spanLength: 6)
        createGap(1)
        createWallSpanWithHeight(1, spanLength: 22)
        createGap(2)
        createWallSpanWithHeight(2, spanLength: 14)
        createGap(2)
        createWallSpanWithHeight(3, spanLength: 8)
        createGap(2)
        createSteppedWallSpanWithHeight(3, spanALength: 5, spanBLength: 12)
        createGap(3)
        createWallSpanWithHeight(0, spanLength: 8)
        createGap(3)
        createWallSpanWithHeight(1, spanLength: 50)
        createGap(20)
    }
    
    func createGap(spanLength: NSInteger) {
        for i in 0..spanLength {
            _walls.addSlice(SliceType.Gap)
        }
    }
    
    func createWallSpanWithHeight(
            heightIndex: Int,
        var spanLength:  Int,
            noFront:     Bool = false,
            noBack:      Bool = false)
    {
        if !noFront && spanLength > 0 {
            addWallFront(heightIndex)
            spanLength--
        }
        
        let midSpanLength: Int = spanLength - (noBack ? 0 : 1)
        if midSpanLength > 0 {
            addWallMid(heightIndex, spanLength: midSpanLength)
            spanLength -= midSpanLength
        }
        
        if !noBack && spanLength > 0 {
            addWallBack(heightIndex)
        }
    }
    
    func createSteppedWallSpanWithHeight(var heightIndex: Int, spanALength: Int, spanBLength: Int) {
        if heightIndex < 2 {
            heightIndex = 2
        }
        
        createWallSpanWithHeight(heightIndex, spanLength: spanALength, noFront: false, noBack: true)
        addWallStep(heightIndex - 2)
        createWallSpanWithHeight(heightIndex - 2, spanLength: spanBLength - 1, noFront: true, noBack: false)
    }
    
    func addWallFront(heightIndex: Int) {
        let y = WALL_HEIGHTS[heightIndex]
        _walls.addSlice(SliceType.Front, y: y)
    }
    
    func addWallBack(heightIndex: Int) {
        let y = WALL_HEIGHTS[heightIndex]
        _walls.addSlice(SliceType.Back, y: y)
    }
    
    func addWallMid(heightIndex: Int, spanLength: Int) {
        let y = WALL_HEIGHTS[heightIndex]
        for i in 0..spanLength {
            if i % 2 == 0 {
                _walls.addSlice(SliceType.Window, y: y)
            } else {
                _walls.addSlice(SliceType.Decoration, y: y)
            }
        }
    }
    
    func addWallStep(heightIndex: Int) {
        let y = WALL_HEIGHTS[heightIndex]
        _walls.addSlice(SliceType.Step, y: y)
    }
}