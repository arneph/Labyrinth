//
//  ViewController.m
//  Labyrinth
//
//  Created by Programmieren on 27.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "ViewController.h"

@interface WaitingScreenController : NSViewController

+ (WaitingScreenController*)waitingScreen;

@property IBOutlet NSProgressIndicator *progressIndicator;

@end

@implementation WaitingScreenController

+ (WaitingScreenController *)waitingScreen{
    WaitingScreenController *controller;
    controller = [[WaitingScreenController alloc] initWithNibName:@"WaitingScreen"
                                                           bundle:[NSBundle mainBundle]];
    return controller;
}

- (void)awakeFromNib{
    [_progressIndicator setUsesThreadedAnimation:YES];
    [_progressIndicator startAnimation:nil];
}

@end

const ViewController *viewController;

@implementation ViewController{
    NSView* view;
    BOOL showingWaitingScreen;
    WaitingScreenController *waitingScreenController;
}

- (void)awakeFromNib{
    viewController = self;
    [self resize];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsChanged:)
                                                 name:LabyrinthSettingsChangedNotification
                                               object:nil];
    _itmTime.label = @"";
    _itmScore.label = @"";
}

- (void)settingsChanged: (NSNotification*)notification{
    [self resize];
}

+ (ViewController *)viewController{
    return (ViewController*)viewController;
}

- (void)resize{
    NSSize size = CurrentMapSize;
    size.width *= SquareLength;
    size.height *= SquareLength;
    [_window setContentSize:size];
}

- (void)displayView:(NSView *)nView{
    if (nView&&!showingWaitingScreen) {
        nView.frame = view.frame;
        [_window setContentView:nView];
        view = nView;
    }
}

- (void)displayWaitingScreen{
    if (!waitingScreenController) {
        waitingScreenController = [WaitingScreenController waitingScreen];
    }
    waitingScreenController.view.frame = view.frame;
    [_window setContentView:waitingScreenController.view];
    showingWaitingScreen = YES;
}

- (void)hideWaitingScreen{
    [_window setContentView:view];
    showingWaitingScreen = NO;
}

@end
