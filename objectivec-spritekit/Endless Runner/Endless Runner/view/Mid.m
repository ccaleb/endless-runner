//
//  Mid.m
//  Endless Runner
//
//  Created by Christopher Caleb on 14/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "Mid.h"

static const CGFloat MID_DELTA_X = 0.64;

@implementation Mid
{
    SKTexture *texture;
    SKSpriteNode *mid1;
    SKSpriteNode *mid2;
    CGFloat viewportX;
}

- (id)init
{
    self = [super init];
    if (self) {
        texture = [SKTexture textureWithImageNamed:@"bg-mid"];
        mid1 = [SKSpriteNode spriteNodeWithTexture:texture];
        mid2 = [SKSpriteNode spriteNodeWithTexture:texture];
        
        mid1.anchorPoint = CGPointMake(0.0, 0.0);
        mid1.position = CGPointMake(0, 0.0);
        [self addChild:mid1];
        
        mid2.anchorPoint = CGPointMake(0.0, 0.0);
        mid2.position = CGPointMake(1024.0, 0.0);
        [self addChild:mid2];
        
        viewportX = 0.0;
    }
    
    return self;
}

- (void)setViewportX:(CGFloat)newViewportX
{
    float distanceTravelled = newViewportX - viewportX;
    viewportX = newViewportX;
    
    CGPoint tempPoint = self.position;
    tempPoint.x -= (distanceTravelled * MID_DELTA_X);
    if (tempPoint.x < -1024)
    {
        tempPoint.x += 1024;
    }

    self.position = tempPoint;
}

@end
