//
//  Scroller.m
//  Endless Runner
//
//  Created by Christopher Caleb on 15/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "Scroller.h"
#import "Far.h"
#import "Mid.h"

@implementation Scroller
{
    Far *far;
    Mid *mid;
    CGFloat _viewportX;
}

- (id)initWithNode:(SKNode *)node
{
    self = [super init];
    if (self) {
        far = [[Far alloc] init];
        mid = [[Mid alloc] init];
        _viewportX = 0.0;
        
        [node addChild:far];
        [node addChild:mid];
    }
    
    return self;
}

- (void)setViewportX:(CGFloat)viewportX
{
    _viewportX = viewportX;
    [far setViewportX:viewportX];
    [mid setViewportX:viewportX];
}

- (CGFloat)getViewportX
{
    return _viewportX;
}

- (void)moveViewportXBy:(CGFloat)units
{
    CGFloat newViewportX = _viewportX + units;
    [self setViewportX:newViewportX];
}

@end
