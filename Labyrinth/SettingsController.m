//
//  SettingsController.m
//  Labyrinth
//
//  Created by Programmieren on 28.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "SettingsController.h"

@interface SettingsController ()

@property IBOutlet NSWindow *settingsSheet;

@property IBOutlet Settings *settings;

@property IBOutlet DemoMapView *demoMapView;
@property IBOutlet NSPopUpButton *popMovingSound;
@property IBOutlet NSPopUpButton *popFailureSound;
@property IBOutlet NSPopUpButton *popFinishSound;
@property IBOutlet NSMatrix *mtxMapSize;
@property IBOutlet NSMatrix *mtxSquareLength;

- (IBAction)pushedCancel:(id)sender;
- (IBAction)pushedOkay:(id)sender;

- (IBAction)standardColorScheme:(id)sender;
- (IBAction)brownColorScheme:(id)sender;
- (IBAction)greenBlackColorScheme:(id)sender;
- (IBAction)greenWhiteColorScheme:(id)sender;

- (IBAction)playSound: (NSButton*)sender;

@end

const SettingsController *settingsController;

@implementation SettingsController

+ (void)showSettings{
    if (!settingsController) {
        settingsController = [[SettingsController alloc] init];
    }
    if (!settingsController.settingsSheet) {
        [NSBundle loadNibNamed:@"SettingsSheet"
                         owner:settingsController];
    }
    [NSApp beginSheet:settingsController.settingsSheet
       modalForWindow:[NSApp keyWindow]
        modalDelegate:nil
       didEndSelector:NULL
          contextInfo:NULL];
}

- (void)awakeFromNib{
    [self prepareSheet];
}

- (void)pushedCancel:(id)sender{
    [self closeSheet];
}

- (void)pushedOkay:(id)sender{
    [self readFromSheet];
    [_settings saveAllSettings];
    [[Settings settings] loadAllSettings];
    [self closeSheet];
    [[NSNotificationCenter defaultCenter] postNotificationName:LabyrinthSettingsChangedNotification
                                                        object:self];
}

- (void)closeSheet{
    [NSApp endSheet:_settingsSheet];
    [_settingsSheet close];
    _settingsSheet = nil;
}

- (void)prepareSheet{
    [_popMovingSound selectItemWithTitle:MovingSound.name];
    [_popFailureSound selectItemWithTitle:FailureSound.name];
    [_popFinishSound selectItemWithTitle:FinishSound.name];
    if (CurrentMapSize.width == 49&&CurrentMapSize.height == 25) {
        [_mtxMapSize selectCellAtRow:1 column:0];
    }else if (CurrentMapSize.width == 65&&CurrentMapSize.height == 33) {
        [_mtxMapSize selectCellAtRow:2 column:0];
    }else if (CurrentMapSize.width == 97&&CurrentMapSize.height == 49) {
        [_mtxMapSize selectCellAtRow:3 column:0];
    }else if (CurrentMapSize.width == 129&&CurrentMapSize.height == 65) {
        [_mtxMapSize selectCellAtRow:4 column:0];
    }else{
        [_mtxMapSize selectCellAtRow:0 column:0];
    }
    [_mtxSquareLength selectCellAtRow:(SquareLength - 10) / 5 column:0];
}

- (void)readFromSheet{
    [_settings setMovingSound:[NSSound soundNamed:_popMovingSound.titleOfSelectedItem]];
    [_settings setFailureSound:[NSSound soundNamed:_popFailureSound.titleOfSelectedItem]];
    [_settings setFinishSound:[NSSound soundNamed:_popFinishSound.titleOfSelectedItem]];
    if (_mtxMapSize.selectedRow == 0) {
        [_settings setCurrentMapSize:NSMakeSize(33, 17)];
    }else if (_mtxMapSize.selectedRow == 1) {
        [_settings setCurrentMapSize:NSMakeSize(49, 25)];
    }else if (_mtxMapSize.selectedRow == 2) {
        [_settings setCurrentMapSize:NSMakeSize(65, 33)];
    }else if (_mtxMapSize.selectedRow == 3) {
        [_settings setCurrentMapSize:NSMakeSize(97, 49)];
    }else if (_mtxMapSize.selectedRow == 4) {
        [_settings setCurrentMapSize:NSMakeSize(129, 65)];
    }
    [_settings setSquareLength:(_mtxSquareLength.selectedRow * 5) + 10];
}

- (void)standardColorScheme:(id)sender{
    _settings.backgroundColor = [NSColor whiteColor];
    _settings.wallColor = [NSColor blackColor];
    _settings.player1Color = [NSColor redColor];
    _settings.player2Color = [NSColor blueColor];
    _settings.finishColor = [NSColor greenColor];
    [_demoMapView redraw:sender];
}

- (void)brownColorScheme:(id)sender{
    _settings.backgroundColor = [NSColor colorWithSRGBRed:1
                                                    green:.66
                                                     blue:.33
                                                    alpha:1];
    _settings.wallColor = [NSColor brownColor];    
    _settings.player1Color = [NSColor redColor];
    _settings.player2Color = [NSColor blueColor];
    _settings.finishColor = [NSColor greenColor];
    [_demoMapView redraw:sender];
}

- (void)greenBlackColorScheme:(id)sender{
    _settings.backgroundColor = [NSColor blackColor];
    _settings.wallColor = [NSColor colorWithSRGBRed:0 green:.4 blue:0 alpha:1];;
    _settings.player1Color = [NSColor redColor];
    _settings.player2Color = [NSColor blueColor];
    _settings.finishColor = [NSColor greenColor];
    [_demoMapView redraw:sender];
}

- (void)greenWhiteColorScheme:(id)sender{
    _settings.backgroundColor = [NSColor whiteColor];
    _settings.wallColor = [NSColor colorWithSRGBRed:0 green:.4 blue:0 alpha:1];;
    _settings.player1Color = [NSColor redColor];
    _settings.player2Color = [NSColor blueColor];
    _settings.finishColor = [NSColor greenColor];
    [_demoMapView redraw:sender];
}

- (void)playSound:(NSButton *)sender{
    if (sender.tag == 1) {
        [[NSSound soundNamed:_popMovingSound.titleOfSelectedItem] play];
    }else if (sender.tag == 2) {
        [[NSSound soundNamed:_popFailureSound.titleOfSelectedItem] play];
    }else if (sender.tag == 3) {
        [[NSSound soundNamed:_popFinishSound.titleOfSelectedItem] play];
    }
}

@end
