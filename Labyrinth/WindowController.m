//
//  WindowController.m
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "WindowController.h"

@implementation WindowController

- (void)windowWillClose:(NSNotification *)notification{
    [NSApp terminate:nil];
}

@end
