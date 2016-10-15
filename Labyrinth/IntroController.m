//
//  IntroController.m
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "IntroController.h"

@interface IntroController ()

@end

@implementation IntroController

- (id)init{
    self = [super initWithNibName:@"IntroController" bundle:[NSBundle mainBundle]];
    if (self) {
        ((MapView*)self.view).map = [MapGenerator introMapWithSize: CurrentMapSize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        ((MapView*)self.view).map = [MapGenerator introMapWithSize: CurrentMapSize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        ((MapView*)self.view).map = [MapGenerator introMapWithSize: CurrentMapSize];
    }
    return self;
}

- (void)awakeFromNib{
    BOOL hasSeenIntro = [[NSUserDefaults standardUserDefaults] boolForKey:@"de.AP-Software.Intro_HasSeenIntro"];
    if (_viewController&&!hasSeenIntro) {
        [((MapView*)self.view) resizeToPerfectSize];
        [_viewController displayView:self.view];
        [[ViewController viewController] setCurrentViewController:self];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"de.AP-Software.Intro_HasSeenIntro"];
    }else if (_viewController&&_mainMenuController) {
        [_viewController displayView:_mainMenuController.view];
        [[ViewController viewController] setCurrentViewController:_mainMenuController];
    }
}

- (void)hasSolvedMap{
    [_viewController displayView:_mainMenuController.view];
    [[ViewController viewController] setCurrentViewController:_mainMenuController];
}

@end
