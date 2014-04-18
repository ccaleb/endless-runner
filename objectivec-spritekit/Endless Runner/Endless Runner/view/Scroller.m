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
#import "Walls.h"

@implementation Scroller
{
    Far *far;
    Mid *mid;
    Walls *front;
    CGFloat _viewportX;
}

- (id)initWithNode:(SKNode *)node withTextureAtlas:(SKTextureAtlas *)textureAtlas
{
    self = [super init];
    if (self) {
        far = [[Far alloc] init];
        mid = [[Mid alloc] init];
        front = [[Walls alloc] initWithTextureAtlas:textureAtlas];
        _viewportX = 0.0;
        
        [node addChild:far];
        [node addChild:mid];
        [node addChild:front];
    }
    
    return self;
}

- (void)setViewportX:(CGFloat)viewportX
{
    _viewportX = viewportX;
    [far setViewportX:viewportX];
    [mid setViewportX:viewportX];
    [front setViewportX:viewportX];
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
