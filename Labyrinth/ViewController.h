//
//  ViewController.h
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"

@interface ViewController : NSObject

@property IBOutlet NSWindow *window;
@property NSViewController *currentViewController;

@property IBOutlet NSToolbar *toolbar;
@property IBOutlet NSToolbarItem *itmTime;
@property IBOutlet NSToolbarItem *itmScore;

+ (ViewController*)viewController;

- (void)displayView: (NSView*)view;

- (void)displayWaitingScreen;
- (void)hideWaitingScreen;

@end
