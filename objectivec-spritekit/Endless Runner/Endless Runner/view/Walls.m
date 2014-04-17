//
//  Walls.m
//  Endless Runner
//
//  Created by Christopher Caleb on 17/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "Walls.h"
#import "WallSlicePool.h"
#import "WallSlice.h"

@implementation Walls
{
    WallSlicePool *pool;
    NSMutableArray *slices;
    NSInteger viewportX;
    NSInteger viewportSliceX;
    SEL borrowWallSliceLookup[kSliceTypeGap];
    SEL returnWallSliceLookup[kSliceTypeGap];
    NSInteger VIEWPORT_NUM_SLICES;
}

- (id)initWithTextureAtlas:(SKTextureAtlas *)textureAtlas
{
    self = [super init];
    if (self)
    {
        pool = [[WallSlicePool alloc] initWithTextureAtlas:textureAtlas];
        [self createLookupTables];
        
        slices = [NSMutableArray array];
        
        viewportX = 0;
        viewportSliceX = 0;
        
        [self displayTestWall];
    }
    
    return self;
}

- (void)displayTestWall
{
    SKSpriteNode *slice;
    CGFloat y = 0.0;
    for (NSInteger i = 0; i < 8; i++)
    {
        if (i > 4)
        {
            y = -128.0;
        }
        
        if (i == 0)
        {
            slice = [pool borrowFrontEdge];
        }
        else if (i == 7)
        {
            slice = [pool borrowBackEdge];
        }
        else if (i == 4)
        {
            slice = [pool borrowStep];
        }
        else if (i % 2 == 0)
        {
            slice = [pool borrowWindow];
        }
        else
        {
            slice = [pool borrowDecoration];
        }
        //slice.anchorPoint = CGPointMake(0.0, 0.0);
        slice.position = CGPointMake(i * 128.0, y);
        [self addChild:slice];
    }
}

- (void)createLookupTables
{
    borrowWallSliceLookup[kSliceTypeFront] = @selector(borrowFrontEdge);
    borrowWallSliceLookup[kSliceTypeBack] = @selector(borrowBackEdge);
    borrowWallSliceLookup[kSliceTypeStep] = @selector(borrowStep);
    borrowWallSliceLookup[kSliceTypeDecoration] = @selector(borrowDecoration);
    borrowWallSliceLookup[kSliceTypeWindow] = @selector(borrowWindow);
    
    returnWallSliceLookup[kSliceTypeFront] = @selector(returnFrontEdge:);
    returnWallSliceLookup[kSliceTypeBack] = @selector(returnBackEdge:);
    returnWallSliceLookup[kSliceTypeStep] = @selector(returnStep:);
    returnWallSliceLookup[kSliceTypeDecoration] = @selector(returnDecoration:);
    returnWallSliceLookup[kSliceTypeWindow] = @selector(returnWindow:);
}
@end
