

#import "Lines.h"

@implementation Lines

+(NSArray *)returnArray_a:(int)a b:(int)b c:(int)c d:(int)d e:(int)e
{
    return [NSArray arrayWithObjects:
            [NSNumber numberWithInt:a],
            [NSNumber numberWithInt:b],
            [NSNumber numberWithInt:c],
            [NSNumber numberWithInt:d],
            [NSNumber numberWithInt:e],nil];

}

+(NSArray *)returnLines:(int)lines
{
    if (lines > 30) {
        return nil;
    }
    NSMutableArray *_lines = [[[NSMutableArray alloc]init]autorelease];
    
    for (int i = 1; i<=lines; i++) {
        
        switch (i) {
            case 1:
                [_lines addObject:[self returnArray_a:2 b:5 c:8 d:11 e:14]];// Line 1
                break;
            case 2:
                [_lines addObject:[self returnArray_a:1 b:4 c:7 d:10 e:13]];// Line 2
                break;
            case 3:
                [_lines addObject:[self returnArray_a:3 b:6 c:9 d:12 e:15]];// Line 3
                break;
            case 4:
                [_lines addObject:[self returnArray_a:1 b:5 c:9 d:11 e:13]];// Line 4
                break;
            case 5:
                [_lines addObject:[self returnArray_a:3 b:5 c:7 d:11 e:15]];// Line 5
                break;
            case 6:
                [_lines addObject:[self returnArray_a:2 b:4 c:7 d:10 e:14]];// Line 6
                break;
            case 7:
                [_lines addObject:[self returnArray_a:2 b:6 c:9 d:12 e:14]];// Line 7
                break;
            case 8:
                [_lines addObject:[self returnArray_a:1 b:4 c:8 d:12 e:15]];// Line 8
                break;
            case 9:
                [_lines addObject:[self returnArray_a:3 b:6 c:8 d:10 e:13]];// Line 9
                break;
            case 10:
                [_lines addObject:[self returnArray_a:2 b:6 c:8 d:10 e:14]];// Line 10
                break;
            case 11:
                [_lines addObject:[self returnArray_a:2 b:4 c:8 d:12 e:14]];// Line 11
                break;
            case 12:
                [_lines addObject:[self returnArray_a:1 b:5 c:8 d:11 e:13]];// Line 12
                break;
            case 13:
                [_lines addObject:[self returnArray_a:3 b:5 c:8 d:11 e:15]];// Line 13
                break;
            case 14:
                [_lines addObject:[self returnArray_a:1 b:4 c:7 d:10 e:13]];// Line 14
                break;
            case 15:
                [_lines addObject:[self returnArray_a:3 b:5 c:9 d:11 e:15]];// Line 15
                break;
            case 16:
                [_lines addObject:[self returnArray_a:2 b:5 c:7 d:11 e:14]];// Line 16
                break;
            case 17:
                [_lines addObject:[self returnArray_a:2 b:5 c:9 d:11 e:14]];// Line 17
                break;
            case 18:
                [_lines addObject:[self returnArray_a:1 b:4 c:9 d:10 e:13]];// Line 18
                break;
            case 19:
                [_lines addObject:[self returnArray_a:3 b:6 c:7 d:12 e:15]];// Line 19
                break;
            case 20:
                [_lines addObject:[self returnArray_a:1 b:6 c:9 d:12 e:13]];// Line 20
                break;
            case 21:
                [_lines addObject:[self returnArray_a:3 b:4 c:7 d:10 e:15]];// Line 21
                break;
            case 22:
                [_lines addObject:[self returnArray_a:2 b:6 c:7 d:12 e:14]];// Line 22
                break;
            case 23:
                [_lines addObject:[self returnArray_a:2 b:4 c:9 d:10 e:14]];// Line 23
                break;
            case 24:
                [_lines addObject:[self returnArray_a:1 b:6 c:7 d:12 e:13]];// Line 24
                break;
            case 25:
                [_lines addObject:[self returnArray_a:3 b:4 c:9 d:10 e:15]];// Line 25
                break;
            case 26:
                [_lines addObject:[self returnArray_a:3 b:4 c:8 d:12 e:13]];// Line 26
                break;
            case 27:
                [_lines addObject:[self returnArray_a:1 b:6 c:8 d:10 e:15]];// Line 27
                break;
            case 28:
                [_lines addObject:[self returnArray_a:1 b:6 c:8 d:12 e:13]];// Line 28
                break;
            case 29:
                [_lines addObject:[self returnArray_a:3 b:4 c:8 d:10 e:15]];// Line 29
                break;
            case 30:
                [_lines addObject:[self returnArray_a:3 b:5 c:7 d:10 e:14]];// Line 30
                break;
                
            default:
                break;
        }
    }
    
    return _lines;
}

+(int)returnMaxLinesByMachine:(int)machineNr
{
    int maxLines = 9;
    switch (machineNr) {
        case 1:maxLines = 9;break;
        case 2:maxLines = 15;break;
        case 3:maxLines = 20;break;
        case 4:maxLines = 25;break;
        case 5:maxLines = 30;break;
        case 6:maxLines = 30;break;
        case 7:maxLines = 20;break;
        case 8:maxLines = 30;break;
        case 9:maxLines = 25;break;
        case 10:maxLines = 30;break;
        case 11:maxLines = 30;break;
        case 12:maxLines = 25;break;
        case 13:maxLines = 25;break;
        case 14:maxLines = 20;break;
        case 15:maxLines = 20;break;
        case 16:maxLines = 20;break;
        case 17:maxLines = 30;break;
        case 18:maxLines = 25;break;
        case 19:maxLines = 25;break;
        case 20:maxLines = 30;break;
        case 21:maxLines = 30;break;
        case 22:maxLines = 20;break;
        case 23:maxLines = 20;break;
        case 24:maxLines = 25;break;
        case 25:maxLines = 25;break;
        case 26:maxLines = 30;break;
        case 27:maxLines = 30;break;
        case 28:maxLines = 30;break;
        case 29:maxLines = 30;break;
        case 30:maxLines = 30;break;
        default:break;
    }
    
    return maxLines;
}

@end
