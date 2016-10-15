//
//  GameSettings.m
//  Labyrinth
//
//  Created by Programmieren on 01.03.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

- (id)init{
    self = [super init];
    if (self) {
        _multiplayer = NO;
        _hasTimeLimit = NO;
        _timeLimit = 300;
    }
    return self;
}

@end
