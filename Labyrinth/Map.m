//
//  PSMap.m
//  PixelSettlers
//
//  Created by Programmieren on 22.09.12.
//  Copyright (c) 2012 AP-Software. All rights reserved.
//

#import "Map.h"

@implementation Map{
    NSMutableArray *squares;
}

#pragma mark Standard

- (id)init{
    self = [super init];
    if (self) {
        _size = NSMakeSize(33, 17);
        squares = [[NSMutableArray alloc] initWithCapacity:_size.width];
        for (NSUInteger x = 0; x < _size.width; x++) {
            NSMutableArray *column = [[NSMutableArray alloc] initWithCapacity:_size.height];
            for (NSUInteger y = 0; y < _size.height; y++) {
                [column addObject:@NO];
            }
            [squares addObject:column];
        }
    }
    return self;
}

- (id)initWithSize:(NSSize)nSize{
    self = [super init];
    if (self) {
        _size = nSize;
        squares = [[NSMutableArray alloc] initWithCapacity:_size.width];
        for (NSUInteger x = 0; x < _size.width; x++) {
            NSMutableArray *column = [[NSMutableArray alloc] initWithCapacity:_size.height];
            for (NSUInteger y = 0; y < _size.height; y++) {
                [column addObject:@NO];
            }
            [squares addObject:column];
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [self init];
    _size = [aDecoder decodeSizeForKey:@"size"];
    squares = [[NSMutableArray alloc] initWithArray:[aDecoder decodeObjectForKey:@"squares"]];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeSize:_size forKey:@"size"];
    [aCoder encodeObject:squares forKey:@"squares"];
}

- (id)copyWithZone:(NSZone *)zone{
    Map *map = [[Map alloc] initWithSize:_size];
    for (NSUInteger x = 0; x < _size.width; x++) {
        for (NSUInteger y = 0; y < _size.height; y++) {
            NSPoint point = NSMakePoint(x, y);
            [map setWall:[self wallAtPoint:point] atPoint:point];
        }
    }
    return map;
}

# pragma mark Squares

- (BOOL)wallAtPoint:(NSPoint)point{
    if (-1 < point.x&&point.x < _size.width&&-1 < point.y&&point.y < _size.height) {
        NSMutableArray *column = squares[(NSUInteger)point.x];
        NSNumber *value = column[(NSUInteger)point.y];
        return value.boolValue;
    }else{
        return YES;
    }
}

- (void)setWall:(BOOL)wall atPoint:(NSPoint)point{
    if (-1 < point.x&&point.x < _size.width&&-1 < point.y&&point.y < _size.height) {
        NSMutableArray *column = squares[(NSUInteger)point.x];
        [column replaceObjectAtIndex:(NSUInteger)point.y withObject:@(wall)];
    }
}

@end
