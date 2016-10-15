//
//  MapGenerator.m
//  Labyrinth
//
//  Created by Programmieren on 23.01.13.
//  Copyright (c) 2013 Arne Philipeit Software. All rights reserved.
//

#import "MapGenerator.h"

@implementation MapGenerator

+ (id)randomMapWithSize:(NSSize)size andGameSettings:(GameSettings *)settings{
    if (size.width < 18||size.height < 10) {
        return nil;
    }
    
    Map *map = [[Map alloc] initWithSize:size];
    
    //Surrounding Walls
    for (NSUInteger i = 0; i < size.width; i++) {
        [map setWall:YES atPoint:NSMakePoint(i, 0)];
        [map setWall:YES atPoint:NSMakePoint(i, size.height - 1)];
    }
    for (NSUInteger i = 0; i < size.height; i++) {
        [map setWall:YES atPoint:NSMakePoint(0, i)];
        [map setWall:YES atPoint:NSMakePoint(size.width -1, i)];
    }
    
    //Inner Walls
    NSUInteger x = 1001;
    NSUInteger y = 0;
    while (YES/*(Has Free Space)*/) {
        srand((unsigned int)mach_absolute_time());
        
        //Starting Point for a wall
            //First Four Startingspoints from Surrounding Walls
        if (x == 1001) {
            x = (rand() % (int)((size.width - 1) / 2)) * 2 + 2;
            y = 0;
        }else if (x == 1002) {
            x = (rand() % (int)((size.width - 1) / 2)) * 2 + 2;
            y = size.height - 1;
        }else if (x == 1003) {
            y = (rand() % (int)((size.height - 1) / 2)) * 2 + 2;
            x = 0;
        }else if (x == 1004) {
            y = (rand() % (int)((size.height - 1) / 2)) * 2 + 2;
            x = size.width - 1;
        }else if (x == 0&&y == 0) {
            //Standard Radom Start Point
            if (rand() % 8 > 0) {
                //Start Point from Surrounding Wall
                srand((unsigned int)mach_absolute_time());
                if (rand() % 2 == 0) {
                    srand((unsigned int)mach_absolute_time());
                    x = (rand() % (int)((size.width + 1) / 2)) * 2;
                    srand((unsigned int)mach_absolute_time());
                    if (rand() % 2 == 0) {
                        y = 0;
                    }else{
                        y = size.height - 1;
                    }
                }else{
                    srand((unsigned int)mach_absolute_time());
                    y = (rand() % (int)((size.height + 1) / 2)) * 2;
                    srand((unsigned int)mach_absolute_time());
                    if (rand() % 2 == 0) {
                        x = 0;
                    }else{
                        x = size.width - 1;
                    }
                }
                //Start Point from Inside
            }else{
                while ([map wallAtPoint:NSMakePoint(x, y)]) {
                    srand((unsigned int)mach_absolute_time());
                    x = (rand() % (int)((size.width + 1) / 2)) * 2;
                    srand((unsigned int)mach_absolute_time());
                    y = (rand() % (int)((size.height + 1) / 2)) * 2;
                }
            }
        }
        [map setWall:YES atPoint:NSMakePoint(x, y)];
        
        NSPoint nextPoint = NSMakePoint(0, 0);
        if (x > 1000&&x < 1004) {
            nextPoint.x = x + 1;
        }
        for (NSUInteger i = 0; i < 8 + rand() % 8; i++) {
            BOOL spaceLeft = ![map wallAtPoint:NSMakePoint(x - 2, y)];
            BOOL spaceTop = ![map wallAtPoint:NSMakePoint(x, y + 2)];
            BOOL spaceRight = ![map wallAtPoint:NSMakePoint(x + 2, y)];
            BOOL spaceBottom = ![map wallAtPoint:NSMakePoint(x, y - 2)];
            
            BOOL noPossiblilty = (!spaceLeft&&!spaceTop&&!spaceRight&&!spaceBottom);
            BOOL mayConectToWall = (noPossiblilty&&i == 0&&!(x == 0||x == size.width - 1||
                                                             y == 0||y == size.height - 1));
            
            if (noPossiblilty&&!mayConectToWall) {
                break;
            }
            
            //Set Continue Point
            srand((unsigned int)mach_absolute_time());
            if (rand() % 2 == 1
                &&(spaceLeft)+(spaceTop)+(spaceRight)+(spaceBottom) > 1
                &&nextPoint.x == 0&&nextPoint.y == 0) {
                nextPoint.x = x;
                nextPoint.y = y;
            }
            
            //Going in a Direction
            NSUInteger direction;
            while (YES) {
                srand((unsigned int)mach_absolute_time());
                direction = rand() % 4;
                if (direction == 0&&(spaceLeft||mayConectToWall)) {
                    break;
                }else if (direction == 1&&(spaceTop||mayConectToWall)) {
                    break;
                }else if (direction == 2&&(spaceRight||mayConectToWall)) {
                    break;
                }else if (direction == 3&&(spaceBottom||mayConectToWall)) {
                    break;
                }
            }
            if (direction == 0) {
                x--;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
                x--;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
            }else if (direction == 1) {
                y++;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
                y++;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
            }else if (direction == 2) {
                x++;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
                x++;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
            }else if (direction == 3) {
                y--;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
                y--;
                [map setWall:YES atPoint:NSMakePoint(x, y)];
            }
            
            if (mayConectToWall) {
                break;
            }
        }
        
        //Set Next Point
        if (nextPoint.x != 0&&nextPoint.y != 0&&nextPoint.x < 1000) {
            BOOL spaceLeft = ![map wallAtPoint:NSMakePoint(nextPoint.x - 2, nextPoint.y)];
            BOOL spaceTop = ![map wallAtPoint:NSMakePoint(nextPoint.x, nextPoint.y + 2)];
            BOOL spaceRight = ![map wallAtPoint:NSMakePoint(nextPoint.x + 2, nextPoint.y)];
            BOOL spaceBottom = ![map wallAtPoint:NSMakePoint(nextPoint.x, nextPoint.y - 2)];
            
            if ((spaceLeft) + (spaceTop) + (spaceRight) + (spaceBottom) < 1) {
                nextPoint.x = 0;
                nextPoint.y = 0;
            }
        }
        x = nextPoint.x;
        y = nextPoint.y;
        
        //Terminate If Needed
        BOOL hasFreeSpace = NO;
        for (NSUInteger x = 2; x < size.width - 1; x = x + 2) {
            for (NSUInteger y = 2; y < size.height - 1; y = y + 2) {
                if (![map wallAtPoint:NSMakePoint(x, y)]) {
                    hasFreeSpace = YES;
                }
            }
        }
        if (!hasFreeSpace) {
            break;
        }
    }
    
    //Player/Finish Point
    srand((unsigned int)mach_absolute_time());
    if (rand() % 2 == 1) {
        srand((unsigned int)mach_absolute_time());
        if (rand() % 2 == 1) {
            [map setPlayer1:NSMakePoint(1, 1)];
            [map setFinish:NSMakePoint(size.width - 2, size.height - 2)];
        }else{
            [map setPlayer1:NSMakePoint(1, size.height - 2)];
            [map setFinish:NSMakePoint(size.width - 2, 1)];
        }
    }else{
        srand((unsigned int)mach_absolute_time());
        if (rand() % 2 == 1) {
            [map setPlayer1:NSMakePoint(size.width - 2, 1)];
            [map setFinish:NSMakePoint(1, size.height - 2)];
        }else{
            [map setPlayer1:NSMakePoint(size.width - 2, size.height - 2)];
            [map setFinish:NSMakePoint(1, 1)];
        }
    }
    
    if (settings.multiplayer) {
        map.hasPlayer2 = YES;
        map.player2 = map.player1;
    }
    
    return map;
}

+ (id)introMapWithSize:(NSSize)size{
    if (size.width < 18||size.height < 10) {
        return nil;
    }
    
    srand((unsigned int) mach_absolute_time());
    
    Map *map = [[Map alloc] initWithSize:size];
    NSUInteger width = size.width;
    NSUInteger height = size.height;
    NSUInteger hCenter = size.width / 2;
    NSUInteger whole = (rand() % (height - 2)) + 1;
    
    //Surounding Walls
    for (NSUInteger i = 0; i < width; i++) {
        [map setWall:YES atPoint:NSMakePoint(i, 0)];
        [map setWall:YES atPoint:NSMakePoint(i, size.height - 1)];
    }
    for (NSUInteger i = 0; i < height; i++) {
        [map setWall:YES atPoint:NSMakePoint(0, i)];
        [map setWall:YES atPoint:NSMakePoint(size.width -1, i)];
    }
    
    //Inner Wall
    for (NSUInteger i = 0; i < size.height; i++) {
        if (i != whole) {
            [map setWall:YES atPoint:NSMakePoint(hCenter, i)];
        }
    }
    
    [map setPlayer1:NSMakePoint((rand() % (hCenter - 4)) + 2, (rand() % (height - 4)) + 2)];
    [map setFinish:NSMakePoint((rand() % (hCenter - 4)) + hCenter + 2, (rand() % (height - 4)) + 2)];
    
    return map;
}

+ (id)demoMap{
    Map *map = [[Map alloc] initWithSize:NSMakeSize(8, 6)];
    map.hasPlayer2 = YES;
    
    //Surounding Walls
    for (NSUInteger i = 0; i < 8; i++) {
        [map setWall:YES atPoint:NSMakePoint(i, 0)];
        [map setWall:YES atPoint:NSMakePoint(i, 5)];
    }
    for (NSUInteger i = 0; i < 6; i++) {
        [map setWall:YES atPoint:NSMakePoint(0, i)];
        [map setWall:YES atPoint:NSMakePoint(7, i)];
    }
    
    [map setWall:YES atPoint:NSMakePoint(5, 1)];
    [map setWall:YES atPoint:NSMakePoint(5, 2)];
    [map setWall:YES atPoint:NSMakePoint(5, 3)];
    [map setWall:YES atPoint:NSMakePoint(5, 5)];
    
    [map setWall:YES atPoint:NSMakePoint(1, 3)];
    [map setWall:YES atPoint:NSMakePoint(3, 3)];
    [map setWall:YES atPoint:NSMakePoint(4, 3)];
    
    [map setFinish: NSMakePoint(6, 1)];
    [map setPlayer1:NSMakePoint(4, 2)];
    [map setPlayer2:NSMakePoint(1, 1)];
    return map;
}

@end
