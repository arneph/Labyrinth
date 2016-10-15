//
//  MapView.m
//  Labyrinth
//
//  Created by Programmieren on 23.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "MapView.h"

@implementation MapView{
    NSUInteger player1Direction;
    NSUInteger player2Direction;
    NSTimer *player1MovingTimer;
    NSTimer *player2MovingTimer;
}

@synthesize map = _map;

- (void)awakeFromNib{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsChanged:)
                                                 name:LabyrinthSettingsChangedNotification
                                               object:nil];
}

- (void)settingsChanged: (NSNotification*)notification{
    [self refresh];
}

- (void)refresh{
    [self setNeedsDisplay:YES];
    if (_map.player1.x == _map.finish.x&&_map.player1.y == _map.finish.y) {
        if  (HasFinishSound) {
            [FinishSound play];
        }
        if ([_delegate respondsToSelector:@selector(hasSolvedMap)]) {
            [_delegate hasSolvedMap];
        }
        if ([_delegate respondsToSelector:@selector(needsNewMap)]) {
           [_delegate needsNewMap];
        }
    }
}

- (void)resizeToPerfectSize{
    [self setFrameSize:NSMakeSize(_map.size.width * SquareWidth, _map.size.height * SquareWidth)];
}

- (BOOL)acceptsFirstResponder{
    return YES;
}

- (void)movingKeyDown: (NSUInteger)key{
    NSUInteger player;
    NSUInteger direction;
    
    if (!_settings.multiplayer) {
        player = 0;
        if (MovingControls == MovingControlsWASD&&key > 3) {
            return;
        }else if (MovingControls == MovingControlsArrowKeys&&key < 4) {
            return;
        }
        if (MovingControls == MovingControlsArrowKeys) {
            direction = key - 4;
        }else{
            direction = key;
        }
    }else{
        player = (key > 3);
        if (_settings.switchPlayerControls) {
            player = !player;
        }
        direction = key - (player) ? 4 : 0;
    }
    
    if (player == 0) {
        player1Direction = direction;
        [player1MovingTimer invalidate];
        player1MovingTimer = nil;
        player1MovingTimer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                              target:self
                                                            selector:@selector(player1MovingTimerFired)
                                                            userInfo:nil
                                                             repeats:YES];
        [player1MovingTimer fire];
    }else if (player == 1) {
        player2Direction = direction;
        [player2MovingTimer invalidate];
        player2MovingTimer = nil;
        player2MovingTimer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                              target:self
                                                            selector:@selector(player2MovingTimerFired)
                                                            userInfo:nil
                                                             repeats:YES];
        [player2MovingTimer fire];
    }
}

- (void)movingKeyUp: (NSUInteger)key{
    NSUInteger player = (key > 3);
    if (_settings.switchPlayerControls) {
        player = !player;
    }
    NSUInteger direction = key - (player) ? 4 : 0;
    if (player == 0&&player1Direction == direction) {
        [player1MovingTimer invalidate];
        player1MovingTimer = nil;
    }else if (player == 1&&player2Direction == direction) {
        [player2MovingTimer invalidate];
        player2MovingTimer = nil;
    }
}

- (void)player1MovingTimerFired{
    [self movePlayer:0 inDirection:player1Direction];
}

- (void)player2MovingTimerFired{
    [self movePlayer:1 inDirection:player2Direction];
}

- (void)keyDown:(NSEvent *)theEvent{
    if([theEvent.charactersIgnoringModifiers isEqualToString:@"n"]){
        if (theEvent.modifierFlags & NSControlKeyMask) {
            if ([_delegate respondsToSelector:@selector(needsNewMap)]) {
                [_delegate needsNewMap];
                return;
            }
        }
    }
    if ([theEvent.characters isEqualToString:@"a"]) {
        [self movingKeyDown:0];
    }else if ([theEvent.characters isEqualToString:@"w"]) {
        [self movingKeyDown:1];
    }else if ([theEvent.characters isEqualToString:@"d"]) {
        [self movingKeyDown:2];
    }else if ([theEvent.characters isEqualToString:@"s"]) {
        [self movingKeyDown:3];
    }else if (((unichar)[theEvent.characters characterAtIndex: 0]) == NSLeftArrowFunctionKey) {
        [self movingKeyDown:4];
    }else if (((unichar)[theEvent.characters characterAtIndex: 0]) == NSUpArrowFunctionKey) {
        [self movingKeyDown:5];
    }else if (((unichar)[theEvent.characters characterAtIndex: 0]) == NSRightArrowFunctionKey) {
        [self movingKeyDown:6];
    }else if (((unichar)[theEvent.characters characterAtIndex: 0]) == NSDownArrowFunctionKey) {
        [self movingKeyDown:7];
    }else{
        [super keyDown:theEvent];
    }
    return;
    
    if (MovingControls == MovingControlsWASD&&!_map.hasPlayer2) {
        if ([theEvent.characters isEqualToString:@"a"]) {
            [self movePlayer:0 inDirection:0];
        }else if ([theEvent.characters isEqualToString:@"w"]) {
            [self movePlayer:0 inDirection:1];
        }else if ([theEvent.characters isEqualToString:@"d"]) {
            [self movePlayer:0 inDirection:2];
        }else if ([theEvent.characters isEqualToString:@"s"]) {
            [self movePlayer:0 inDirection:3];
        }else{
            [super keyDown:theEvent];
        }
    }else if (_map.hasPlayer2){
        if ([theEvent.characters isEqualToString:@"a"]) {
            [self movePlayer:_settings.switchPlayerControls inDirection:0];
        }else if ([theEvent.characters isEqualToString:@"w"]) {
            [self movePlayer:_settings.switchPlayerControls inDirection:1];
        }else if ([theEvent.characters isEqualToString:@"d"]) {
            [self movePlayer:_settings.switchPlayerControls inDirection:2];
        }else if ([theEvent.characters isEqualToString:@"s"]) {
            [self movePlayer:_settings.switchPlayerControls inDirection:3];
        }else{
            [super keyDown:theEvent];
        }
    }else{
        [super keyDown:theEvent];
    }
}

- (void)keyUp:(NSEvent *)theEvent{
    unsigned short keyCode = theEvent.keyCode;
    if ([theEvent.characters isEqualToString:@"a"]) {
        [self movingKeyUp:0];
    }else if ([theEvent.characters isEqualToString:@"w"]) {
        [self movingKeyUp:1];
    }else if ([theEvent.characters isEqualToString:@"d"]) {
        [self movingKeyUp:2];
    }else if ([theEvent.characters isEqualToString:@"s"]) {
        [self movingKeyUp:3];
    }else if (keyCode & NSLeftArrowFunctionKey) {
        [self movingKeyUp:4];
    }else if (keyCode & NSUpArrowFunctionKey) {
        [self movingKeyUp:5];
    }else if (keyCode & NSRightArrowFunctionKey) {
        [self movingKeyUp:6];
    }else if (keyCode & NSDownArrowFunctionKey) {
        [self movingKeyUp:7];
    }else{
        [super keyUp:theEvent];
    }
}

- (void)movePlayer: (NSUInteger)player inDirection: (NSUInteger)direction{
    NSPoint playerPoint = (player) ? _map.player2 : _map.player1;
    if (direction == 0) {
        if (playerPoint.x > 0
            &&![_map wallAtPoint:NSMakePoint(playerPoint.x - 1, playerPoint.y)]) {
            playerPoint = NSMakePoint(playerPoint.x - 1, playerPoint.y);
        }else{
            if (HasFailureSound) {
                [FailureSound play];
            }
            return;
        }
    }else if (direction == 1) {
        if (playerPoint.y < _map.size.height - 1&&![_map wallAtPoint:NSMakePoint(playerPoint.x, playerPoint.y + 1)]) {
            playerPoint = NSMakePoint(playerPoint.x, playerPoint.y + 1);
        }else{
            if (HasFailureSound) {
                [FailureSound play];
            }
            return;
        }
    }else if (direction == 2) {
        if (playerPoint.x < _map.size.width - 1&&![_map wallAtPoint:NSMakePoint(playerPoint.x + 1, playerPoint.y)]) {
            playerPoint = NSMakePoint(playerPoint.x + 1, playerPoint.y);
        }else{
            if (HasFailureSound) {
                [FailureSound play];
            }
            return;
        }
    }else if (direction == 3) {
        if (playerPoint.y > 0&&![_map wallAtPoint:NSMakePoint(playerPoint.x, playerPoint.y - 1)]) {
            playerPoint = NSMakePoint(playerPoint.x, playerPoint.y - 1);
        }else{
            if (HasFailureSound) {
                [FailureSound play];
            }
            return;
        }
    }
    if (HasMovingSound) {
        [MovingSound play];
    }
    if (player == 0) {
        _map.player1 = playerPoint;
    }else{
        _map.player2 = playerPoint;
    }
    [self refresh];
    if ([_delegate respondsToSelector:@selector(hasMoved)]) {
        [_delegate hasMoved];
    }
}

- (void)cancelOperation:(id)sender{
    if ([_delegate respondsToSelector:@selector(pauseGame)]) {
        [_delegate pauseGame];
    }
}

/*
- (void)moveLeft:(id)sender{
    if (MovingControls == MovingControlsArrowKeys&&!_map.hasPlayer2) {
        [self movePlayer:0 inDirection:0];
    }else if (_map.hasPlayer2){
        [self movePlayer:!_settings.switchPlayerControls inDirection:0];
    }
}

- (void)moveUp:(id)sender{
    if (MovingControls == MovingControlsArrowKeys&&!_map.hasPlayer2) {
        [self movePlayer:0 inDirection:1];
    }else if (_map.hasPlayer2){
        [self movePlayer:!_settings.switchPlayerControls inDirection:1];
    }
}

- (void)moveRight:(id)sender{
    if (MovingControls == MovingControlsArrowKeys&&!_map.hasPlayer2) {
        [self movePlayer:0 inDirection:2];
    }else if (_map.hasPlayer2){
        [self movePlayer:!_settings.switchPlayerControls inDirection:2];
    }
}

- (void)moveDown:(id)sender{
    if (MovingControls == MovingControlsArrowKeys&&!_map.hasPlayer2) {
        [self movePlayer:0 inDirection:3];
    }else if (_map.hasPlayer2){
        [self movePlayer:!_settings.switchPlayerControls inDirection:3];
    }
}

- (void)mouseDown:(NSEvent *)theEvent{
    NSPoint mousePoint = [self convertPoint:theEvent.locationInWindow fromView:nil];
    NSPoint playerPoint = _map.player1;
    playerPoint.x *= SquareWidth;
    playerPoint.y *= SquareWidth;
    playerPoint.x += SquareWidth / 2;
    playerPoint.y += SquareWidth / 2;
    
    BOOL moveRight = (mousePoint.x > playerPoint.x);
    BOOL moveUp = (mousePoint.y > playerPoint.y);
    NSUInteger dX = (moveRight) ? mousePoint.x - playerPoint.x : playerPoint.x - mousePoint.x;
    NSUInteger dY = (moveUp) ? mousePoint.y - playerPoint.y : playerPoint.y - mousePoint.y;
    if (dX > dY) {
        [self moveInDirection:(moveRight) ? 2 : 0];
    }else{
        [self moveInDirection:(moveUp) ? 1 : 3];
    }
}

- (void)mouseDragged:(NSEvent *)theEvent{
    NSPoint mousePoint = [self convertPoint:theEvent.locationInWindow fromView:nil];
    NSPoint playerPoint = _map.player1;
    playerPoint.x *= SquareWidth;
    playerPoint.y *= SquareWidth;
    playerPoint.x += SquareWidth / 2;
    playerPoint.y += SquareWidth / 2;
    
    BOOL moveRight = (mousePoint.x > playerPoint.x);
    BOOL moveUp = (mousePoint.y > playerPoint.y);
    NSUInteger dX = (moveRight) ? mousePoint.x - playerPoint.x : playerPoint.x - mousePoint.x;
    NSUInteger dY = (moveUp) ? mousePoint.y - playerPoint.y : playerPoint.y - mousePoint.y;
    if (dX > dY) {
        [self moveInDirection:(moveRight) ? 2 : 0];
    }else{
        [self moveInDirection:(moveUp) ? 1 : 3];
    }
}

- (void)viewDidMoveToWindow{
    [self.window makeFirstResponder:self];
}
 */

- (BOOL)isOpaque{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect{
    [BackgroundColor set];
    [NSBezierPath fillRect:dirtyRect];

    if (!_map) {
        return;
    }
        
    [WallColor set];
    
    for (NSUInteger x = 0; x < _map.size.width; x++) {
        for (NSUInteger y = 0; y < _map.size.height; y++) {
            NSPoint point = NSMakePoint(x, y);
            BOOL wall = [_map wallAtPoint:point];
            if (wall) {
                [NSBezierPath fillRect:NSMakeRect(x * SquareWidth, y * SquareWidth, SquareWidth , SquareWidth)];
            }
            
            BOOL finish = point.x == _map.finish.x&&point.y == _map.finish.y;
            BOOL player1 = (point.x == _map.player1.x&&point.y == _map.player1.y);
            BOOL player2 = (_map.hasPlayer2&&
                            point.x == _map.player2.x&&point.y == _map.player2.y);
                        
            if (finish) {
                [FinishColor set];
                [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(x * SquareWidth + 3,
                                                                   y * SquareWidth + 3,
                                                                   SquareWidth - 6,
                                                                   SquareWidth - 6)] fill];
                [WallColor set];
            }
            
            if (player1&&player2) {
                NSBezierPath *path1 = [NSBezierPath bezierPath];
                NSBezierPath *path2 = [NSBezierPath bezierPath];
                [path1 moveToPoint:NSMakePoint((x * SquareWidth) + (.5 * SquareWidth),
                                               (y * SquareWidth) + (SquareWidth - 3))];
                [path1 appendBezierPathWithArcWithCenter:NSMakePoint((x * SquareWidth)
                                                                     + (.5 * SquareWidth),
                                                                     (y * SquareWidth)
                                                                     + (.5 * SquareWidth))
                                                  radius:(SquareWidth / 2) - 3
                                              startAngle:270
                                                endAngle:90];
                [path1 closePath];
                [path2 moveToPoint:NSMakePoint((x * SquareWidth) + (.5 * SquareWidth),
                                               (y * SquareWidth) + (SquareWidth - 3))];
                [path2 appendBezierPathWithArcWithCenter:NSMakePoint((x * SquareWidth)
                                                                     + (.5 * SquareWidth),
                                                                     (y * SquareWidth)
                                                                     + (.5 * SquareWidth))
                                                  radius:(SquareWidth / 2) - 3
                                              startAngle:90
                                                endAngle:270];
                [path2 closePath];
                [Player1Color set];
                [path1 fill];
                [Player2Color set];
                [path2 fill];
                [WallColor set];
            }else if (player1) {
                [Player1Color set];
                [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(x * SquareWidth + 3,
                                                                   y * SquareWidth + 3,
                                                                   SquareWidth - 6,
                                                                   SquareWidth - 6)] fill];
                [WallColor set];
            }else if (player2) {
                [Player2Color set];
                [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(x * SquareWidth + 3,
                                                                   y * SquareWidth + 3,
                                                                   SquareWidth - 6,
                                                                   SquareWidth - 6)] fill];
                [WallColor set];
            }
        }
    }
}

@end
