//
//  MapGenerator.h
//  Labyrinth
//
//  Created by Programmieren on 23.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/mach.h>
#import <mach/mach_time.h>
#import "Map.h"
#import "GameSettings.h"

@interface MapGenerator : NSObject

+ (id)randomMapWithSize: (NSSize)size andGameSettings: (GameSettings*)settings;

+ (id)introMapWithSize: (NSSize)size;
+ (id)demoMap;

@end
