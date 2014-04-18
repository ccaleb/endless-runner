//
//  MyScene.m
//  Endless Runner
//
//  Created by Christopher Caleb on 14/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "MyScene.h"
#import "Scroller.h"

@implementation MyScene
{
    SKTextureAtlas *textureAtlas;
    Scroller *scroller;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        textureAtlas = [SKTextureAtlas atlasNamed:@"wallslices"];
        scroller = [[Scroller alloc] initWithNode:self withTextureAtlas:textureAtlas];
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
