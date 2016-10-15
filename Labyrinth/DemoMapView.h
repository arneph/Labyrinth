//
//  DemoMapView.h
//  Labyrinth
//
//  Created by Programmieren on 11.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MapGenerator.h"
#import "Settings.h"

@interface DemoMapView : NSView

@property IBOutlet Settings *settings;

- (IBAction)redraw:(id)sender;

@end
