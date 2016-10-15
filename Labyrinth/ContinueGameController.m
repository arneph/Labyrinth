//
//  ContinueGameController.m
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "ContinueGameController.h"

@interface ContinueGameController ()

- (IBAction)pushedBack:(id)sender;

@end

@implementation ContinueGameController

- (void)pushedBack:(id)sender{
    if (_mainMenuController) {
        [[ViewController viewController] displayView:_mainMenuController.view];
        [[ViewController viewController] setCurrentViewController:_mainMenuController];
    }
}

@end
