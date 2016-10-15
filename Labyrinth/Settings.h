//
//  Settings.h
//  Labyrinth
//
//  Created by Programmieren on 28.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LabyrinthSettingsChangedNotification @"LabyrinthSettingsChangedNotification"

#define BackgroundColor [[Settings settings] backgroundColor]
#define WallColor [[Settings settings] wallColor]
#define Player1Color [[Settings settings] player1Color]
#define Player2Color [[Settings settings] player2Color]
#define FinishColor [[Settings settings] finishColor]

#define HasMovingSound [[Settings settings] hasMovingSound]
#define MovingSound [[Settings settings] movingSound]
#define HasFailureSound [[Settings settings] hasFailureSound]
#define FailureSound [[Settings settings] failureSound]
#define HasFinishSound [[Settings settings] hasFinishSound]
#define FinishSound [[Settings settings] finishSound]

#define MovingControls [[Settings settings] movingControls]
#define MovingControlsWASD LabyrinthSettingsMovingControlsWASD
#define MovingControlsArrowKeys LabyrinthSettingsMovingControlsArrowKeys

#define CurrentMapSize [[Settings settings] currentMapSize]

#define SquareWidth [[Settings settings] squareLength]
#define SquareLength [[Settings settings] squareLength]

typedef enum{
    LabyrinthSettingsMovingControlsWASD,
    LabyrinthSettingsMovingControlsArrowKeys
}LabyrinthSettingsMovingControls;

@interface Settings : NSObject

@property NSColor *backgroundColor;
@property NSColor *wallColor;
@property NSColor *player1Color;
@property NSColor *player2Color;
@property NSColor *finishColor;

@property BOOL hasMovingSound;
@property NSSound *movingSound;
@property BOOL hasFailureSound;
@property NSSound *failureSound;
@property BOOL hasFinishSound;
@property NSSound *finishSound;

@property LabyrinthSettingsMovingControls movingControls;

@property NSSize currentMapSize;
@property NSUInteger squareLength;

+ (Settings*)settings;

- (void)loadAllSettings;
- (void)saveAllSettings;

@end
