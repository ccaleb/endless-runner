//
//  Scroller.h
//  Endless Runner
//
//  Created by Christopher Caleb on 15/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Scroller : SKNode
- (id)initWithNode:(SKNode *)node;
- (void)setViewportX:(CGFloat)viewportX;
- (CGFloat)getViewportX;
- (void)moveViewportXBy:(CGFloat)units;
@end
