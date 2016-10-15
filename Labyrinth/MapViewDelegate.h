//
//  MapViewDelegate.h
//  Labyrinth
//
//  Created by Programmieren on 09.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MapViewDelegate <NSObject>

@optional
- (void)hasMoved;
- (void)hasSolvedMap;

- (void)pauseGame;
- (void)needsNewMap;

@end
