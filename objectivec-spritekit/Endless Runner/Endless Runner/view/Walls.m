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
    CGFloat viewportX;
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
        VIEWPORT_NUM_SLICES = (NSInteger)ceil(VIEWPORT_WIDTH / WALL_SLICE_WIDTH) + 1;
        
        pool = [[WallSlicePool alloc] initWithTextureAtlas:textureAtlas];
        [self createLookupTables];
        
        slices = [NSMutableArray array];
        
        viewportX = 0;
        viewportSliceX = 0;
        
        [self addTestSlices];
        //[self displayTestWall];
    }
    
    return self;
}

- (void)setViewportX:(CGFloat)newViewportX
{
    viewportX = [self checkViewportXBounds:newViewportX];
    NSInteger prevViewportSliceX = viewportSliceX;
    viewportSliceX = floor(viewportX / WALL_SLICE_WIDTH);
    
    [self removeOldSlices: prevViewportSliceX];
    [self addNewSlices];
}

- (void)addSlice:(SliceType)sliceType
{
    WallSlice *slice = [[WallSlice alloc] initWithType:sliceType andY:0.0f];
    [slices addObject:slice];
}

- (CGFloat)checkViewportXBounds:(CGFloat)newViewportX
{
    CGFloat maxViewportX = (slices.count - VIEWPORT_NUM_SLICES) * WALL_SLICE_WIDTH;
    if (newViewportX < 0)
    {
        newViewportX = 0;
    }
    else if (viewportX > maxViewportX)
    {
        newViewportX = maxViewportX;
    }
    
    return newViewportX;
}

- (void)addNewSlices
{
    NSInteger firstX = -((NSInteger)viewportX % WALL_SLICE_WIDTH);
    for (NSInteger i = viewportSliceX, sliceIndex = 0;
                   i < viewportSliceX + VIEWPORT_NUM_SLICES;
                   i++, sliceIndex++)
    {
        WallSlice *slice = [slices objectAtIndex:i];
        if (slice.sprite == nil && slice.type != kSliceTypeGap)
        {
            slice.sprite = [self borrowWallSlice: slice.type];
            
            slice.sprite.position = CGPointMake(
                                                firstX + (sliceIndex * WALL_SLICE_WIDTH),
                                                slice.y);
            
            [self addChild:slice.sprite];
        }
        else if (slice.sprite != nil)
        {
            slice.sprite.position = CGPointMake(
                                                firstX + (sliceIndex * WALL_SLICE_WIDTH),
                                                slice.sprite.position.y);
        }
    }
}

- (void)removeOldSlices:(NSInteger)prevViewportSliceX
{
    NSInteger numOldSlices = viewportSliceX - prevViewportSliceX;
    if (numOldSlices > VIEWPORT_NUM_SLICES)
    {
        numOldSlices = VIEWPORT_NUM_SLICES;
    }
    
    for (NSInteger i = prevViewportSliceX; i < prevViewportSliceX + numOldSlices; i++)
    {
        WallSlice *slice = slices[i];
        if (slice.sprite != nil)
        {
            [self returnWallSlice:slice.type usingSprite:slice.sprite];
            [slice.sprite removeFromParent];
            slice.sprite = nil;
        }
    }
}

- (void)addSlice:(SliceType)sliceType atYPosition:(CGFloat)y
{
    WallSlice *slice = [[WallSlice alloc] initWithType:sliceType andY:y];
    [slices addObject:slice];
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

- (SKSpriteNode *)borrowWallSlice:(SliceType)sliceType
{
    return [pool performSelector:borrowWallSliceLookup[sliceType]];
}

- (void)returnWallSlice:(SliceType)sliceType usingSprite:(SKSpriteNode *)sprite
{
    [pool performSelector:returnWallSliceLookup[sliceType] withObject:sprite];
}

- (void)addTestSlices
{
    [self addSlice:kSliceTypeFront atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeDecoration atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeStep atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:-128.0];
    [self addSlice:kSliceTypeDecoration atYPosition:-128.0];
    [self addSlice:kSliceTypeBack atYPosition:-128.0];
    [self addSlice:kSliceTypeGap];
    [self addSlice:kSliceTypeFront atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeDecoration atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeStep atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:-128.0];
    [self addSlice:kSliceTypeDecoration atYPosition:-128.0];
    [self addSlice:kSliceTypeBack atYPosition:-128.0];
    [self addSlice:kSliceTypeGap];
    [self addSlice:kSliceTypeFront atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeDecoration atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeStep atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:-128.0];
    [self addSlice:kSliceTypeDecoration atYPosition:-128.0];
    [self addSlice:kSliceTypeBack atYPosition:-128.0];
    [self addSlice:kSliceTypeGap];
    [self addSlice:kSliceTypeFront atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeDecoration atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:0.0];
    [self addSlice:kSliceTypeStep atYPosition:0.0];
    [self addSlice:kSliceTypeWindow atYPosition:-128.0];
    [self addSlice:kSliceTypeDecoration atYPosition:-128.0];
    [self addSlice:kSliceTypeBack atYPosition:-128.0];
    [self addSlice:kSliceTypeGap];
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
@end
