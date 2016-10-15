//
//  GameViewController.h
//  Labyrinth
//
//  Created by Programmieren on 09.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Map.h"
#import "MapGenerator.h"
#import "MapView.h"
#import "GameSettings.h"
#import "ViewController.h"
#import "SettingsController.h"

@interface GameViewController : NSViewController <MapViewDelegate>

@property (readonly) GameSettings *settings;

+ (GameViewController*)gameViewWithGameSettings: (GameSettings*)settings;

@end
