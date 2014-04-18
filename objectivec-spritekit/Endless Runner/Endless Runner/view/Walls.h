//
//  Walls.h
//  Endless Runner
//
//  Created by Christopher Caleb on 17/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WallSlice.h"

static const CGFloat VIEWPORT_WIDTH = 1024;

@interface Walls : SKNode
- (id)initWithTextureAtlas:(SKTextureAtlas *)textureAtlas;
- (void)setViewportX:(CGFloat)viewportX;
- (void)addSlice:(SliceType)sliceType;
- (void)addSlice:(SliceType)sliceType atYPosition:(CGFloat)y;
@end
