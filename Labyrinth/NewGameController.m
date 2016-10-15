//
//  NewGameController.m
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "NewGameController.h"

@interface NewGameController ()

@property IBOutlet GameSettings *settings;

- (IBAction)pushedBack:(id)sender;
- (IBAction)pushedStart:(id)sender;

@end

@implementation NewGameController

- (id)init{
    self = [super initWithNibName:@"NewGameController" bundle:[NSBundle mainBundle]];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)pushedBack:(id)sender{
    if (_mainMenuController) {
        [[ViewController viewController] displayView:_mainMenuController.view];
        [[ViewController viewController] setCurrentViewController:_mainMenuController];
    }
}

- (void)pushedStart:(id)sender{
    GameViewController *controller = [GameViewController gameViewWithGameSettings:_settings];
    [[ViewController viewController] displayView:controller.view];
    [[ViewController viewController] setCurrentViewController:controller];
}

@end
