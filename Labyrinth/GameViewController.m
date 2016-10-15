//
//  GameViewController.m
//  Labyrinth
//
//  Created by Programmieren on 09.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property IBOutlet MapView *mapView;
@property IBOutlet NSView *pauseView;

- (IBAction)continueGame:(id)sender;
- (IBAction)showSettings:(id)sender;

@end

@implementation GameViewController{
    BOOL paused;
    Map *map;
    NSMutableArray *nextMaps;
    NSUInteger mapsInProcess;
    NSTimer *timer;
    float currentTime;
}

+ (GameViewController*)gameViewWithGameSettings:(GameSettings *)settings{
    GameViewController *controller;
    controller = [[GameViewController alloc] initWithGameSettings:settings];
    return controller;
}

- (id)init{
    self = [super initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithGameSettings: (GameSettings*)settings{
    self = [super initWithNibName:@"GameViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        _settings = settings;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    nextMaps = [[NSMutableArray alloc] init];
    mapsInProcess = 0;
    [self createInitialBuffer];
}

- (void)createInitialBuffer{
    for (NSUInteger i = 0; i < 5; i++) {
        [self createNewMap];
    }
}

- (void)awakeFromNib{
    [self displayNextMap];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsChanged:)
                                                 name:LabyrinthSettingsChangedNotification
                                               object:nil];
    [[[ViewController viewController] toolbar] setVisible:YES];
    if (_settings.hasTimeLimit) {
        [[ViewController viewController] itmTime].label = [NSString stringWithFormat:@"%i Seconds remaining", (int)_settings.timeLimit];
    }else{
        [[ViewController viewController] itmTime].label = @"0 Seconds";
    }
}

- (void)settingsChanged: (NSNotification*)notification{
    NSSize currentSize = CurrentMapSize;
    if (map.size.width != currentSize.width||
        map.size.height != currentSize.height) {
        map = nil;
        [nextMaps removeAllObjects];
        [self createInitialBuffer];
        [self displayNextMap];
    }
}

- (void)createNewMap{
    mapsInProcess++;
    dispatch_async(dispatch_queue_create("de.AP-Software.Laybrinth", NULL), ^{
        NSSize size = CurrentMapSize;
        __block Map *newMap = [MapGenerator randomMapWithSize: size andGameSettings:_settings];
        [self performSelectorOnMainThread:@selector(createdNewMap:)
                               withObject:newMap
                            waitUntilDone:NO];
    });
}

- (void)createdNewMap: (Map*)newMap{
    mapsInProcess--;
    NSSize currentSize = CurrentMapSize;
    if (newMap.size.width != currentSize.width||
        newMap.size.height != currentSize.height) {
        [self createNewMap];
        return;
    }
    [nextMaps addObject:newMap];
    if (map == nil) {
        [self displayNextMap];
    }
}

- (void)displayNextMap{
    map = nil;
    if (nextMaps.count == 0) {
        [[ViewController viewController] displayWaitingScreen];
        [self stopTimer];
        if (mapsInProcess < 1) {
            [self createNewMap];
        }
        return;
    }else{
        [[ViewController viewController] hideWaitingScreen];
        [[ViewController viewController] displayView:_mapView];
        [_mapView.window makeFirstResponder:_mapView];
        [self startTimer];
    }
    map = nextMaps[0];
    [nextMaps removeObjectAtIndex:0];
    _mapView.map = map;
    [self createNewMap];
}

- (void)startTimer{
    timer = [NSTimer timerWithTimeInterval:.1 target:self selector:@selector(timerDidFire) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer{
    [timer invalidate];
}

- (void)timerDidFire{
    currentTime += .1;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:1];
    NSString *newTimeInfo;
    if (_settings.hasTimeLimit) {
        newTimeInfo = [NSString stringWithFormat:@"%@ Seconds remaining", [formatter stringFromNumber:@(_settings.timeLimit - currentTime)]];
    }else{
        newTimeInfo = [NSString stringWithFormat:@"%@ Seconds", [formatter stringFromNumber:@(currentTime)]];
    }
    [[ViewController viewController] itmTime].label = newTimeInfo;
}

- (void)pauseGame{
    paused = YES;
    [[ViewController viewController] displayView:_pauseView];
    [self stopTimer];
}

- (void)needsNewMap{
    [self displayNextMap];
}

- (void)continueGame:(id)sender{
    paused = NO;
    [[ViewController viewController] displayView:_mapView];
    [_mapView.window makeFirstResponder:_mapView];
    [self startTimer];
}

- (void)showSettings:(id)sender{
    [SettingsController showSettings];
}

@end
