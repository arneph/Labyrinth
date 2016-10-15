//
//  IntroController.h
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Map.h"
#import "MapGenerator.h"
#import "MapView.h"
#import "ViewController.h"

@interface IntroController : NSViewController <MapViewDelegate>

@property IBOutlet ViewController *viewController;
@property IBOutlet NSViewController *mainMenuController;

@end
