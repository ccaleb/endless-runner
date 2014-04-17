//
//  WallSlicePool.h
//  Endless Runner
//
//  Created by Christopher Caleb on 16/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface WallSlicePool : NSObject
- (id)initWithTextureAtlas:(SKTextureAtlas *)textureAtlas;
- (SKSpriteNode *)borrowWindow;
- (void)returnWindow:(SKSpriteNode *)sprite;
- (SKSpriteNode *)borrowDecoration;
- (void)returnDecoration:(SKSpriteNode *)sprite;
- (SKSpriteNode *)borrowFrontEdge;
- (void)returnFrontEdge:(SKSpriteNode *)sprite;
- (SKSpriteNode *)borrowBackEdge;
- (void)returnBackEdge:(SKSpriteNode *)sprite;
- (SKSpriteNode *)borrowStep;
- (void)returnStep:(SKSpriteNode *)sprite;
@end
