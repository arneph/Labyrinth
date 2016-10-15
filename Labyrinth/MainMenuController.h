//
//  MainMenuController.h
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"
#import "SettingsController.h"

@interface MainMenuController : NSViewController

@property IBOutlet NSViewController *gameNewController;
@property IBOutlet NSViewController *continueGameController;

@end
