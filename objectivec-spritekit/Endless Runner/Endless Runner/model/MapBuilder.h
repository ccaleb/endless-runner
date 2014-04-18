//
//  WallBuilder.h
//  Endless Runner
//
//  Created by Christopher Caleb on 18/04/2014.
//  Copyright (c) 2014 Christopher Caleb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Walls.h"

static const CGFloat WALL_HEIGHTS[] = {
    -256, // Lowest slice
    -192,
    -128,
     -64,
       0  // Highest slice
};

@interface MapBuilder : NSObject
- (id) initWithWalls:(Walls *)walls;
@end
