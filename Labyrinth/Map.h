//
//  PSMap.h
//  PixelSettlers
//
//  Created by Programmieren on 22.09.12.
//  Copyright (c) 2012 AP-Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Map : NSObject <NSCopying, NSCoding>

@property (readonly) NSSize size;
@property NSPoint player1;
@property BOOL hasPlayer2;
@property NSPoint player2;
@property NSPoint finish;

- (id)initWithSize: (NSSize)size;

- (BOOL)wallAtPoint: (NSPoint)point;
- (void)setWall: (BOOL)wall atPoint: (NSPoint)point;

@end
