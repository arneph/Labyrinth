//
//  GameSettings.h
//  Labyrinth
//
//  Created by Programmieren on 01.03.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSettings : NSObject

@property BOOL multiplayer;
@property BOOL switchPlayerControls;

@property BOOL hasTimeLimit;
@property NSUInteger timeLimit;

@end
