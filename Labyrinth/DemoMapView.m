//
//  DemoMapView.m
//  Labyrinth
//
//  Created by Programmieren on 11.02.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "DemoMapView.h"

@implementation DemoMapView{
    Map *map;
}

- (void)awakeFromNib{
    map = [MapGenerator demoMap];
}

- (void)redraw:(id)sender{
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect{
    [_settings.backgroundColor set];
    [NSBezierPath fillRect:dirtyRect];
    
    if (!map) {
        return;
    }
        
    [_settings.wallColor set];
    
    for (NSUInteger x = 0; x < map.size.width; x++) {
        for (NSUInteger y = 0; y < map.size.height; y++) {
            NSPoint point = NSMakePoint(x, y);
            BOOL wall = [map wallAtPoint:point];
            if (wall) {
                [NSBezierPath fillRect:NSMakeRect(x * 25, y * 25, 25, 25)];
            }
            if (point.x == map.finish.x&&point.y == map.finish.y) {
                [_settings.finishColor set];
                [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(x * 25 + 3, y * 25 + 3, 19, 19)] fill];
                [_settings.wallColor set];
            }
            if (point.x == map.player1.x&&point.y == map.player1.y) {
                [_settings.player1Color set];
                [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(x * 25 + 3, y * 25 + 3, 19, 19)] fill];
                [_settings.wallColor set];
            }
            if (map.hasPlayer2&&point.x == map.player2.x&&point.y == map.player2.y) {
                [_settings.player2Color set];
                [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(x * 25 + 3, y * 25 + 3, 19, 19)] fill];
                [_settings.wallColor set];
            }
        }
    }
}

@end
