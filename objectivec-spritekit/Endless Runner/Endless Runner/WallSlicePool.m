//
//  WallSlicePool.m
//  Endless Runner
//
//  Created by Christopher Caleb on 16/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import "WallSlicePool.h"

@implementation WallSlicePool
{
    SKTextureAtlas *_textureAtlas;
    NSMutableArray *windows;
    NSMutableArray *decorations;
    NSMutableArray *frontEdges;
    NSMutableArray *backEdges;
    NSMutableArray *steps;
}

- (id)initWithTextureAtlas:(SKTextureAtlas *)textureAtlas
{
    self = [super init];
    if (self)
    {
        _textureAtlas = textureAtlas;
        [self createWindows];
        [self createDecorations];
        [self createFrontEdges];
        [self createBackEdges];
        [self createSteps];
    }
    
    return self;
}

- (SKSpriteNode *)borrowWindow
{
    SKSpriteNode *sprite = [windows firstObject];
    if (windows.count > 0)
    {
        [windows removeObjectAtIndex:0];
    }
    return sprite;
}

- (void)returnWindow:(SKSpriteNode *)sprite
{
    [windows addObject:sprite];
}

- (SKSpriteNode *)borrowDecoration
{
    SKSpriteNode *sprite = [decorations firstObject];
    if (decorations.count > 0)
    {
        [decorations removeObjectAtIndex:0];
    }
    return sprite;
}

- (void)returnDecoration:(SKSpriteNode *)sprite
{
    [decorations addObject:sprite];
}

- (SKSpriteNode *)borrowFrontEdge
{
    SKSpriteNode *sprite = [frontEdges firstObject];
    if (frontEdges.count > 0)
    {
        [frontEdges removeObjectAtIndex:0];
    }
    return sprite;
}

- (void)returnFrontEdge:(SKSpriteNode *)sprite
{
    [frontEdges addObject:sprite];
}

- (SKSpriteNode *)borrowBackEdge
{
    SKSpriteNode *sprite = [backEdges firstObject];
    if (backEdges.count > 0)
    {
        [backEdges removeObjectAtIndex:0];
    }
    return sprite;
}

- (void)returnBackEdge:(SKSpriteNode *)sprite
{
    [backEdges addObject:sprite];
}

- (SKSpriteNode *)borrowStep
{
    SKSpriteNode *sprite = [steps firstObject];
    if (steps.count > 0)
    {
        [steps removeObjectAtIndex:0];
    }
    return sprite;
}

- (void)returnStep:(SKSpriteNode *)sprite
{
    [steps addObject:sprite];
}

- (void)createWindows
{
    windows = [NSMutableArray array];
    [self addWindowSprites:6 usingTextureNamed:@"window-01"];
    [self addWindowSprites:6 usingTextureNamed:@"window-02"];
    
    [self shuffle:windows];
}

- (void)createDecorations
{
    decorations = [NSMutableArray array];
    [self addDecorationSprites:6 usingTextureNamed:@"decoration-01"];
    [self addDecorationSprites:6 usingTextureNamed:@"decoration-02"];
    
    [self shuffle:decorations];
}

- (void)createFrontEdges
{
    frontEdges = [NSMutableArray array];
    [self addFrontEdgeSprites:2 usingTextureNamed:@"edge-01"];
    [self addFrontEdgeSprites:2 usingTextureNamed:@"edge-02"];
    
    [self shuffle:frontEdges];
}

- (void)createBackEdges
{
    backEdges = [NSMutableArray array];
    [self addBackEdgeSprites:2 usingTextureNamed:@"edge-01"];
    [self addBackEdgeSprites:2 usingTextureNamed:@"edge-02"];
    
    [self shuffle:backEdges];
}

-(void)createSteps
{
    steps = [NSMutableArray array];
    [self addStepSprites:2 usingTextureNamed:@"step-01"];
}

- (void)addWindowSprites:(NSInteger)amount usingTextureNamed:(NSString *)name
{
    for (NSInteger i = 0; i < amount; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[_textureAtlas textureNamed:name]];
        sprite.anchorPoint = CGPointMake(0.0, 0.0);
        [windows addObject:sprite];
    }
}

- (void)addDecorationSprites:(NSInteger)amount usingTextureNamed:(NSString *)name
{
    for (NSInteger i = 0; i < amount; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[_textureAtlas textureNamed:name]];
        sprite.anchorPoint = CGPointMake(0.0, 0.0);
        [decorations addObject:sprite];
    }
}

- (void)addFrontEdgeSprites:(NSInteger)amount usingTextureNamed:(NSString *)name
{
    for (NSInteger i = 0; i < amount; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[_textureAtlas textureNamed:name]];
        sprite.anchorPoint = CGPointMake(0.0, 0.0);
        [frontEdges addObject:sprite];
    }
}

- (void)addBackEdgeSprites:(NSInteger)amount usingTextureNamed:(NSString *)name
{
    for (NSInteger i = 0; i < amount; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[_textureAtlas textureNamed:name]];
        sprite.anchorPoint = CGPointMake(1.0, 0.0);
        sprite.xScale = -1.0;
        [backEdges addObject:sprite];
    }
}

- (void)addStepSprites:(NSInteger)amount usingTextureNamed:(NSString *)name
{
    for (NSInteger i = 0; i < amount; i++)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[_textureAtlas textureNamed:name]];
        sprite.anchorPoint = CGPointMake(0.0, -0.25);
        [steps addObject:sprite];
    }
}

- (void)shuffle:(NSMutableArray *)array
{
    NSUInteger len = [array count];
    NSUInteger shuffles = len * 3;
    for (NSInteger i = 0; i < shuffles; i++)
    {
        SKSpriteNode *slice = [array lastObject];
        [array removeLastObject];
        NSInteger pos = arc4random() % (len - 1);
        [array insertObject:slice atIndex:pos];
    }
}
@end
