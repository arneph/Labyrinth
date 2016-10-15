//
//  MainMenuController.m
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "MainMenuController.h"

@interface MainMenuController ()

- (IBAction)pushedNewGame:(id)sender;
- (IBAction)pushedContinueGame:(id)sender;
- (IBAction)pushedShowSettings:(id)sender;

@end

@implementation MainMenuController

- (void)pushedNewGame:(id)sender{
    if (_gameNewController) {
        [[ViewController viewController] displayView:_gameNewController.view];
        [[ViewController viewController] setCurrentViewController:_gameNewController];
    }
}

- (void)pushedContinueGame:(id)sender{
    if (_gameNewController) {
        [[ViewController viewController] displayView:_continueGameController.view];
        [[ViewController viewController] setCurrentViewController:_continueGameController];
    }
}

- (void)pushedShowSettings:(id)sender{
    [SettingsController showSettings];
}

@end
