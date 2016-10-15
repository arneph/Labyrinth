//
//  MapView.h
//  Labyrinth
//
//  Created by Programmieren on 23.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Map.h"
#import "MapViewDelegate.h"
#import "GameSettings.h"
#import "Settings.h"

@interface MapView : NSView

@property Map *map;
@property GameSettings *settings;
@property IBOutlet id<MapViewDelegate> delegate;

- (void)refresh;
- (void)resizeToPerfectSize;

@end
