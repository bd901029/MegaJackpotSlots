//
//  Bet.m
//  Template
//
//  Created by Slavian on 2013-09-25.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "Bet.h"

@implementation Bet

+(NSArray *)getBetbyLevel:(int)lvl
{
    NSMutableArray *a = [[[NSMutableArray alloc]initWithObjects:
                          [NSNumber numberWithFloat:    0.10],// 1
                          [NSNumber numberWithFloat:    0.50],// 2
                          [NSNumber numberWithFloat:    1.00],// 3
                          [NSNumber numberWithFloat:    2.00],// 4
                          [NSNumber numberWithFloat:    5.00],// 5
                          [NSNumber numberWithFloat:    10.00],// 6
                          [NSNumber numberWithFloat:    15.00],// 7
                          [NSNumber numberWithFloat:    20.00],// 8
                          [NSNumber numberWithFloat:    25.00],// 9
                          [NSNumber numberWithFloat:    30.00],// 10
                          [NSNumber numberWithFloat:    50.00],// 11
                          [NSNumber numberWithFloat:    100.00],// 12
                          [NSNumber numberWithFloat:    150.00],// 13
                          [NSNumber numberWithFloat:    200.00],// 14
                          [NSNumber numberWithFloat:    250.00],// 15
                          [NSNumber numberWithFloat:    300.00],// 16
                          [NSNumber numberWithFloat:    400.00],// 17
                          [NSNumber numberWithFloat:    500.00],// 18
                          [NSNumber numberWithFloat:    750.00],// 19
                          [NSNumber numberWithFloat:    1000.00],// 20
                          [NSNumber numberWithFloat:    1500.00],// 21
                          [NSNumber numberWithFloat:    2000.00],// 22
                          [NSNumber numberWithFloat:    5000.00],// 23
                          [NSNumber numberWithFloat:    10000.00],nil]autorelease];// 24
    
    NSRange range;
    range.location  = 0;
    
    if ((lvl >= 0) && (lvl <= 5)) {range.length          = 5;}
    else if ((lvl >= 6) && (lvl <= 10)) {range.length    = 9;}
    else if ((lvl >= 11) && (lvl <= 15)) {range.length   = 12;}
    else if ((lvl >= 16) && (lvl <= 20)) {range.length   = 15;}
    else if ((lvl >= 21) && (lvl <= 25)) {range.length   = 17;}
    else if ((lvl >= 26) && (lvl <= 30)) {range.length   = 18;}
    else if ((lvl >= 31) && (lvl <= 40)) {range.length   = 20;}
    else if ((lvl >= 41) && (lvl <= 45)) {range.length   = 22;}
    else if ((lvl >= 46) && (lvl <= 49)) {range.length   = 23;}
    else if (lvl >= 50) {range.length                    = 24;}
    
    
    NSArray *subarray = [a subarrayWithRange:range];

    return subarray;
}

@end
