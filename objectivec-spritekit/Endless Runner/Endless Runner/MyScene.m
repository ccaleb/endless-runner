//
//  MyScene.m
//  Endless Runner
//
//  Created by Christopher Caleb on 14/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "MyScene.h"
#import "Scroller.h"
#import "WallSlice.h"
#import "WallSlicePool.h"
#import "Walls.h"

@implementation MyScene
{
    SKSpriteNode *farNode;
    SKSpriteNode *midNode;
    SKNode *wallNode;
    SKTextureAtlas *textureAtlas;
    WallSlicePool *slicePool;
    Walls *walls;
    
    Scroller *scroller;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        scroller = [[Scroller alloc] initWithNode:self];
        
        wallNode = [SKNode node];
        [self addChild:wallNode];
        
        textureAtlas = [SKTextureAtlas atlasNamed:@"wallslices"];
        
        walls = [[Walls alloc] initWithTextureAtlas:textureAtlas];
        [self addChild:walls];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    [scroller moveViewportXBy:8];
}

@end
