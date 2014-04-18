//
//  WallBuilder.m
//  Endless Runner
//
//  Created by Christopher Caleb on 18/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "MapBuilder.h"

@implementation MapBuilder
{
    Walls *_walls;
}

- (id) initWithWalls:(Walls *)walls
{
    self = [super init];
    if (self)
    {
        _walls = walls;
        [self createMap];
    }
    
    return self;
}

- (void)createMap
{
    [self createWallSpanWithHeight:3 thatSpans: 9 andHasNoFront: YES];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:1 thatSpans:30];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:2 thatSpans:18];
    [self createGapWithSpan:1];
    [self createSteppedWallSpan:2 thatSpans:5 andAlsoSpans:28];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:1 thatSpans:10];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:2 thatSpans:6];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:1 thatSpans:8];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:2 thatSpans:6];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:1 thatSpans:8];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:2 thatSpans:7];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:1 thatSpans:16];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:2 thatSpans:6];
    [self createGapWithSpan:1];
    [self createWallSpanWithHeight:1 thatSpans:22];
    [self createGapWithSpan:2];
    [self createWallSpanWithHeight:2 thatSpans:14];
    [self createGapWithSpan:2];
    [self createWallSpanWithHeight:3 thatSpans:8];
    [self createGapWithSpan:2];
    [self createSteppedWallSpan:3 thatSpans:5 andAlsoSpans:12];
    [self createGapWithSpan:3];
    [self createWallSpanWithHeight:0 thatSpans:8];
    [self createGapWithSpan:3];
    [self createWallSpanWithHeight:1 thatSpans:50];
    [self createGapWithSpan:20];
}

- (void)createGapWithSpan:(NSInteger)spanLength
{
    for (NSInteger i = 0; i < spanLength; i++)
    {
        [_walls addSlice:kSliceTypeGap];
    }
}

- (void)createWallSpanWithHeight:(NSInteger)heightIndex
                       thatSpans:(NSInteger)spanLength
                   andHasNoFront:(BOOL)noFront
                    andHasNoBack:(BOOL)noBack
{
    if (noFront == NO && spanLength > 0)
    {
        [self addWallFrontWithHeight:heightIndex];
        spanLength--;
    }
    
    NSInteger midSpanLength = spanLength - (noBack ? 0 : 1);
    if (midSpanLength > 0)
    {
        [self addWallMidWithHeight:heightIndex thatSpans:midSpanLength];
        spanLength -= midSpanLength;
    }
    
    if (noBack == NO && spanLength > 0)
    {
        [self addWallBackWithHeight:heightIndex];
    }
}

- (void)createWallSpanWithHeight:(NSInteger)heightIndex
                       thatSpans:(NSInteger)spanLength
                   andHasNoFront:(BOOL)noFront
{
    [self createWallSpanWithHeight:heightIndex thatSpans:spanLength andHasNoFront:noFront andHasNoBack:NO];
}

- (void)createWallSpanWithHeight:(NSInteger)heightIndex
                      thatSpans:(NSInteger)spanLength
{
    [self createWallSpanWithHeight:heightIndex thatSpans:spanLength andHasNoFront:NO andHasNoBack:NO];
}

- (void)createSteppedWallSpan:(NSInteger)heightIndex
                    thatSpans:(NSInteger)spanALength
                 andAlsoSpans:(NSInteger)spanBLength
{
    if (heightIndex < 2)
    {
        heightIndex = 2;
    }
    
    [self createWallSpanWithHeight:heightIndex thatSpans:spanALength andHasNoFront:NO andHasNoBack:YES];
    [self addWallStepWithHeight:heightIndex - 2];
    [self createWallSpanWithHeight:heightIndex - 2 thatSpans:spanBLength - 1 andHasNoFront:YES andHasNoBack:NO];
}


- (void)addWallFrontWithHeight:(NSInteger)heightIndex
{
    CGFloat y = WALL_HEIGHTS[heightIndex];
    [_walls addSlice:kSliceTypeFront atYPosition:y];
}

- (void)addWallBackWithHeight:(NSInteger)heightIndex
{
    CGFloat y = WALL_HEIGHTS[heightIndex];
    [_walls addSlice:kSliceTypeBack atYPosition:y];
}

- (void)addWallMidWithHeight:(NSInteger)heightIndex thatSpans:(NSInteger)spanLength
{
    CGFloat y = WALL_HEIGHTS[heightIndex];
    for (NSInteger i = 0; i < spanLength; i++)
    {
        if (i % 2 == 0)
        {
            [_walls addSlice:kSliceTypeWindow atYPosition:y];
        }
        else
        {
            [_walls addSlice:kSliceTypeDecoration atYPosition:y];
        }
    }
}

- (void)addWallStepWithHeight:(NSInteger)heightIndex
{
    CGFloat y = WALL_HEIGHTS[heightIndex];
    [_walls addSlice:kSliceTypeStep atYPosition:y];
}

@end
