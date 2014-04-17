//
//  SliceType.m
//  Endless Runner
//
//  Created by Christopher Caleb on 16/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "WallSlice.h"

@implementation WallSlice

- (id)initWithType:(SliceType)type andY:(CGFloat)y;
{
    self = [super init];
    if (self) {
        _type = type;
        _y = y;
        _sprite = nil;
    }
    
    return self;
}

@end
