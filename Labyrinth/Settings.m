//
//  Settings.m
//  Labyrinth
//
//  Created by Programmieren on 28.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "Settings.h"

#define SettingBackgroundColor @"de.AP-Software.Labyrinth.Settings_BackgroundColor"
#define SettingWallColor @"de.AP-Software.Labyrinth.Settings_WallColor"
#define SettingPlayer1Color @"de.AP-Software.Labyrinth.Settings_Player1Color"
#define SettingPlayer2Color @"de.AP-Software.Labyrinth.Settings_Player2Color"
#define SettingFinishColor @"de.AP-Software.Labyrinth.Settings_FinishColor"

#define SettingHasMovingSound @"de.AP-Software.Labyrinth.Settings_HasMovingSound"
#define SettingMovingSound @"de.AP-Software.Labyrinth.Settings_MovingSound"

#define SettingHasFailureSound @"de.AP-Software.Labyrinth.Settings_HasFailureSound"
#define SettingFailureSound @"de.AP-Software.Labyrinth.Settings_FailureSound"

#define SettingHasFinishSound @"de.AP-Software.Labyrinth.Settings_HasFinishSound"
#define SettingFinishSound @"de.AP-Software.Labyrinth.Settings_FinishSound"

#define SettingMovingControls @"de.AP-Software.Labyrinth.Settings_MovingControls"

#define SettingCurrentMapSize @"de.AP-Software.Labyrinth.Settings_CurrentMapSize"
#define SettingSquareLength @"de.AP-Software.Labyrinth.Settings_SquareLength"

const Settings *settings;

@implementation Settings

+ (Settings *)settings{
    if (!settings) {
        settings = [[Settings alloc] init];
    }
    return (Settings*)settings;
}

- (id)init{
    self = [super init];
    if (self) {
        [self loadAllSettings];
    }
    return self;
}

- (void)loadAllSettings{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Colors
    NSData *dBackgroundColor = [defaults objectForKey:SettingBackgroundColor];
    if (dBackgroundColor) {
        _backgroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:dBackgroundColor];
    }else{
        _backgroundColor = [NSColor whiteColor];
    }
    
    NSData *dWallColor = [defaults objectForKey:SettingWallColor];
    if (dWallColor) {
        _wallColor = [NSKeyedUnarchiver unarchiveObjectWithData:dWallColor];
    }else{
        _wallColor = [NSColor blackColor];
    }
    
    NSData *dPlayer1Color = [defaults objectForKey:SettingPlayer1Color];
    if (dPlayer1Color) {
        _player1Color = [NSKeyedUnarchiver unarchiveObjectWithData:dPlayer1Color];
    }else{
        _player1Color = [NSColor redColor];
    }
    
    NSData *dPlayer2Color = [defaults objectForKey:SettingPlayer2Color];
    if (dPlayer2Color) {
        _player2Color = [NSKeyedUnarchiver unarchiveObjectWithData:dPlayer2Color];
    }else{
        _player2Color = [NSColor blueColor];
    }
    
    NSData *dFinishColor = [defaults objectForKey:SettingFinishColor];
    if (dFinishColor) {
        _finishColor = [NSKeyedUnarchiver unarchiveObjectWithData:dFinishColor];
    }else{
        _finishColor = [NSColor greenColor];
    }
    
    //Sounds
    NSData *dHasMovingSound = [defaults objectForKey:SettingHasMovingSound];
    if (dHasMovingSound) {
        NSNumber *hasMovingSound = [NSKeyedUnarchiver unarchiveObjectWithData:dHasMovingSound];
        _hasMovingSound = hasMovingSound.boolValue;
    }else{
        _hasMovingSound = YES;
    }
    
    NSData *dMovingSound = [defaults objectForKey:SettingMovingSound];
    if (dMovingSound) {
        NSString *movingSoundName = [NSKeyedUnarchiver unarchiveObjectWithData:dMovingSound];
        _movingSound = [NSSound soundNamed:movingSoundName];
    }else{
        _movingSound = [NSSound soundNamed:@"Tink"];
    }
    
    NSData *dHasFailureSound = [defaults objectForKey:SettingHasFailureSound];
    if (dHasFailureSound) {
        NSNumber *hasFailureSound = [NSKeyedUnarchiver unarchiveObjectWithData:dHasFailureSound];
        _hasFailureSound = hasFailureSound.boolValue;
    }else{
        _hasFailureSound = YES;
    }
    
    NSData *dFailureSound = [defaults objectForKey:SettingFailureSound];
    if (dFailureSound) {
        NSString *failureSoundName = [NSKeyedUnarchiver unarchiveObjectWithData:dFailureSound];
        _failureSound = [NSSound soundNamed:failureSoundName];
    }else{
        _failureSound = [NSSound soundNamed:@"Sosumi"];
    }
    
    NSData *dHasFinishSound = [defaults objectForKey:SettingHasFinishSound];
    if (dHasFinishSound) {
        NSNumber *hasFinishSound = [NSKeyedUnarchiver unarchiveObjectWithData:dHasFinishSound];
        _hasFinishSound = hasFinishSound.boolValue;
    }else{
        _hasFinishSound = YES;
    }
    
    NSData *dFinishSound = [defaults objectForKey:SettingFinishSound];
    if (dFinishSound) {
        NSString *finishSoundName = [NSKeyedUnarchiver unarchiveObjectWithData:dFinishSound];
        _finishSound = [NSSound soundNamed:finishSoundName];
    }else{
        _finishSound = [NSSound soundNamed:@"Submarine"];
    }
    
    //Moving Controls
    NSData *dMovingControls = [defaults objectForKey:SettingMovingControls];
    if (dMovingControls) {
        NSNumber *movingControls = [NSKeyedUnarchiver unarchiveObjectWithData:dMovingControls];
        _movingControls = (LabyrinthSettingsMovingControls)movingControls.unsignedIntegerValue;
    }else{
        _movingControls = LabyrinthSettingsMovingControlsArrowKeys;
    }
    
    //Size
    NSData *dCurrentMapSize = [defaults objectForKey:SettingCurrentMapSize];
    if (dCurrentMapSize) {
        NSArray *arrayMapSize = [NSKeyedUnarchiver unarchiveObjectWithData:dCurrentMapSize];
        NSNumber *width = arrayMapSize[0];
        NSNumber *heigth = arrayMapSize[1];
        NSSize mapSize = NSMakeSize(width.unsignedIntegerValue, heigth.unsignedIntegerValue);
        _currentMapSize = mapSize;
    }else{
        _currentMapSize = NSMakeSize(33, 17);
    }
    
    NSData *dSquareLength = [defaults objectForKey:SettingSquareLength];
    if (dSquareLength) {
        NSNumber *squareLength = [NSKeyedUnarchiver unarchiveObjectWithData:dSquareLength];
        _squareLength = squareLength.unsignedIntegerValue;
    }else{
        _squareLength = 25;
    }
}

- (void)saveAllSettings{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //Colors
    NSData *dBackgroundColor = [NSKeyedArchiver archivedDataWithRootObject:_backgroundColor];
    [defaults setObject:dBackgroundColor
                 forKey:SettingBackgroundColor];
    
    NSData *dWallColor = [NSKeyedArchiver archivedDataWithRootObject:_wallColor];
    [defaults setObject:dWallColor
                 forKey:SettingWallColor];
    
    NSData *dPlayer1Color = [NSKeyedArchiver archivedDataWithRootObject:_player1Color];
    [defaults setObject:dPlayer1Color
                 forKey:SettingPlayer1Color];
    
    NSData *dPlayer2Color = [NSKeyedArchiver archivedDataWithRootObject:_player2Color];
    [defaults setObject:dPlayer2Color
                 forKey:SettingPlayer2Color];
    
    NSData *dFinishColor = [NSKeyedArchiver archivedDataWithRootObject:_finishColor];
    [defaults setObject:dFinishColor
                 forKey:SettingFinishColor];
    
    //Sounds
    NSData *dHasMovingSound = [NSKeyedArchiver archivedDataWithRootObject:@(_hasMovingSound)];
    [defaults setObject:dHasMovingSound
                 forKey:SettingHasMovingSound];
    
    NSData *dMovingSound = [NSKeyedArchiver archivedDataWithRootObject:_movingSound.name];
    [defaults setObject:dMovingSound
                 forKey:SettingMovingSound];
    
    NSData *dHasFailureSound = [NSKeyedArchiver archivedDataWithRootObject:@(_hasFailureSound)];
    [defaults setObject:dHasFailureSound
                 forKey:SettingHasFailureSound];
    
    NSData *dFailureSound = [NSKeyedArchiver archivedDataWithRootObject:_failureSound.name];
    [defaults setObject:dFailureSound
                 forKey:SettingFailureSound];
    
    NSData *dHasFinishSound = [NSKeyedArchiver archivedDataWithRootObject:@(_hasFinishSound)];
    [defaults setObject:dHasFinishSound
                 forKey:SettingHasFinishSound];
    
    NSData *dFinishSound = [NSKeyedArchiver archivedDataWithRootObject:_finishSound.name];
    [defaults setObject:dFinishSound
                 forKey:SettingFinishSound];
    
    //Moving Controls
    NSData *dMovingControls = [NSKeyedArchiver archivedDataWithRootObject:@(_movingControls)];
    [defaults setObject:dMovingControls
                 forKey:SettingMovingControls];
    
    //Size
    NSNumber *width = @(_currentMapSize.width);
    NSNumber *heigth = @(_currentMapSize.height);
    NSData *dCurrentMapSize = [NSKeyedArchiver archivedDataWithRootObject:@[width, heigth]];
    [defaults setObject:dCurrentMapSize
                 forKey:SettingCurrentMapSize];
    
    NSData *dSquareLength = [NSKeyedArchiver archivedDataWithRootObject:@(_squareLength)];
    [defaults setObject:dSquareLength
                 forKey:SettingSquareLength];
}

@end
