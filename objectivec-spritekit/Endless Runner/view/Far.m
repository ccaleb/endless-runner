//
//  Far.m
//  Endless Runner
//
//  Created by Christopher Caleb on 15/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "Far.h"

static const CGFloat FAR_DELTA_X = 0.32;

@implementation Far
{
    SKTexture *texture;
    SKSpriteNode *far1;
    SKSpriteNode *far2;
    CGFloat viewportX;
}

- (id)init
{
    self = [super init];
    if (self) {
        texture = [SKTexture textureWithImageNamed:@"bg-far"];
        far1 = [SKSpriteNode spriteNodeWithTexture:texture];
        far2 = [SKSpriteNode spriteNodeWithTexture:texture];
        
        far1.anchorPoint = CGPointMake(0.0, 0.0);
        far1.position = CGPointMake(0, 256.0);
        [self addChild:far1];
        
        far2.anchorPoint = CGPointMake(0.0, 0.0);
        far2.position = CGPointMake(1024.0, 256.0);
        [self addChild:far2];
        
        viewportX = 0.0;
    }
    
    return self;
}

- (void)setViewportX:(CGFloat)newViewportX
{
    float distanceTravelled = newViewportX - viewportX;
    viewportX = newViewportX;
    
    CGPoint tempPoint = self.position;
    tempPoint.x -= (distanceTravelled * FAR_DELTA_X);
    if (tempPoint.x < -1024)
    {
        tempPoint.x += 1024;
    }
    
    self.position = tempPoint;
}

@end
