//
//  SliceType.h
//  Endless Runner
//
//  Created by Christopher Caleb on 16/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

static const NSInteger WALL_SLICE_WIDTH = 128;

typedef enum SliceType :NSInteger {
    kSliceTypeFront,
    kSliceTypeBack,
    kSliceTypeStep,
    kSliceTypeDecoration,
    kSliceTypeWindow,
    kSliceTypeGap
} SliceType;

@interface WallSlice : NSObject
@property (nonatomic) SliceType type;
@property (nonatomic) CGFloat y;
@property (nonatomic, strong) SKSpriteNode *sprite;
- (id)initWithType:(SliceType)type andY:(CGFloat)y;
@end
