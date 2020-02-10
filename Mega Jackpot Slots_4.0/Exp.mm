//
//  Exp.m
//  Template
//
//  Created by Slavian on 2013-10-10.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "Exp.h"
#import "IDSTOREPLACE.h"

@implementation Exp

+(int)returnLevelByEXP:(int)exp_
{
    NSMutableDictionary *mDic = [self returnDic];
    
    NSMutableArray *arr = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 0; i<[mDic count]; i++) {
        int num = [[[mDic allKeysForObject:[NSNumber numberWithInt:i]]lastObject]integerValue];
        [arr addObject:[NSNumber numberWithInt:num]];
    }
    
    int expCount        = [arr count];
    
    NSNumber *index     = [arr objectAtIndex:(expCount-1)];
    
//    int i = index.intValue;
//    i = i*1.3;
    
    while (exp_ < index.intValue) {
        expCount--;
        if (expCount == -1) {
            break;
        }
        index = [arr objectAtIndex:expCount];
    }
    
    NSNumber *n = [mDic objectForKey:[NSNumber numberWithInt:index.intValue]];

    return n.intValue;
}

+(int)checMaxMachineWithLevelNr:(int)lvl
{
    
     if      (lvl >= 50)     return 6;
     else if (lvl >= 35)     return 5;
     else if (lvl >= 25)     return 4;
     else if (lvl >= 10)     return 3;
     else if (lvl >= 5)      return 2;
     else                    return 1;
        

    
    return 0;
}

+(int)checkMachineN:(int)lvl
{
    if (lvl == 5)       {return 2;}
    else if (lvl == 10)  {return 3;}
    else if (lvl == 25)  {return 4;}
    else if (lvl == 35)  {return 5;}
    else if (lvl == 50)  {return 6;}
    
    return 0;
}

+(BOOL)checkUnlockMachine:(int)lvl
{
    if (lvl == 5)       {return YES;}
    else if (lvl == 10)  {return YES;}
    else if (lvl == 25)  {return YES;}
    else if (lvl == 35)  {return YES;}
    else if (lvl == 50)  {return YES;}

    return NO;
}

+(int)returnExpPercentage:(int)exp_
{
    NSMutableDictionary *mDic = [self returnDic];
    
    NSMutableArray *arr = [[[NSMutableArray alloc]init]autorelease];
    for (int i = 0; i<[mDic count]; i++) {
        int num = [[[mDic allKeysForObject:[NSNumber numberWithInt:i]]lastObject]integerValue];
        [arr addObject:[NSNumber numberWithInt:num]];
    }
    
    int expCount        = [arr count];
    
    NSNumber *firstIndex     = [arr objectAtIndex:(expCount-1)];
    
    while (exp_ < firstIndex.intValue) {
        expCount--;
        if (expCount == -1) {
            break;
        }
        firstIndex = [arr objectAtIndex:expCount];
    }
    
    NSNumber *n = [mDic objectForKey:firstIndex];
    int v = 1;
    if (n.intValue >= 50 ) {
        v = -1;
    }

    NSNumber *secondIndex = [arr objectAtIndex:expCount+v];
    
    int fullPercents = secondIndex.intValue - firstIndex.intValue;
    
    int halfPercents = exp_ - firstIndex.intValue;
    
    int finishPercents = (halfPercents*100)/fullPercents;
    
    //NSLog(@"INDX::: %i",finishPercents);
    //finishPercents = finishPercents*1.3f;
    
    return finishPercents;
}

+(NSMutableDictionary *)returnDic
{
    float a = RequiredXPMultiplier;//
    
    NSMutableDictionary *mDic = [[[NSMutableDictionary alloc]init]autorelease];
    
    [mDic setObject:[NSNumber numberWithInt:0]      forKey:[NSNumber numberWithInt:0]];
    [mDic setObject:[NSNumber numberWithInt:1]      forKey:[NSNumber numberWithInt:600 *a]];
    [mDic setObject:[NSNumber numberWithInt:2]      forKey:[NSNumber numberWithInt:1425 *a]];
    [mDic setObject:[NSNumber numberWithInt:3]      forKey:[NSNumber numberWithInt:2587 *a]];
    [mDic setObject:[NSNumber numberWithInt:4]      forKey:[NSNumber numberWithInt:4088 *a]];
    [mDic setObject:[NSNumber numberWithInt:5]      forKey:[NSNumber numberWithInt:5925 *a]];
    [mDic setObject:[NSNumber numberWithInt:6]      forKey:[NSNumber numberWithInt:14738 *a]];
    [mDic setObject:[NSNumber numberWithInt:7]      forKey:[NSNumber numberWithInt:24956 *a]];
    [mDic setObject:[NSNumber numberWithInt:8]      forKey:[NSNumber numberWithInt:36581 *a]];
    [mDic setObject:[NSNumber numberWithInt:9]      forKey:[NSNumber numberWithInt:49612 *a]];
    [mDic setObject:[NSNumber numberWithInt:10]      forKey:[NSNumber numberWithInt:92112 *a]];
    [mDic setObject:[NSNumber numberWithInt:11]      forKey:[NSNumber numberWithInt:138779 *a]];
    [mDic setObject:[NSNumber numberWithInt:12]      forKey:[NSNumber numberWithInt:189613 *a]];
    [mDic setObject:[NSNumber numberWithInt:13]      forKey:[NSNumber numberWithInt:244613 *a]];
    [mDic setObject:[NSNumber numberWithInt:14]      forKey:[NSNumber numberWithInt:303770 *a]];
    [mDic setObject:[NSNumber numberWithInt:15]      forKey:[NSNumber numberWithInt:367113 *a]];
    [mDic setObject:[NSNumber numberWithInt:16]      forKey:[NSNumber numberWithInt:443362 *a]];
    [mDic setObject:[NSNumber numberWithInt:17]      forKey:[NSNumber numberWithInt:524300 *a]];
    [mDic setObject:[NSNumber numberWithInt:18]      forKey:[NSNumber numberWithInt:609925 *a]];
    [mDic setObject:[NSNumber numberWithInt:19]      forKey:[NSNumber numberWithInt:700238 *a]];
    [mDic setObject:[NSNumber numberWithInt:20]      forKey:[NSNumber numberWithInt:795238 *a]];
    [mDic setObject:[NSNumber numberWithInt:21]      forKey:[NSNumber numberWithInt:1070758 *a]];
    [mDic setObject:[NSNumber numberWithInt:22]      forKey:[NSNumber numberWithInt:1359300 *a]];
    [mDic setObject:[NSNumber numberWithInt:23]      forKey:[NSNumber numberWithInt:1660863 *a]];
    [mDic setObject:[NSNumber numberWithInt:24]      forKey:[NSNumber numberWithInt:1975446 *a]];
    [mDic setObject:[NSNumber numberWithInt:25]      forKey:[NSNumber numberWithInt:2303050 *a]];
    [mDic setObject:[NSNumber numberWithInt:26]      forKey:[NSNumber numberWithInt:2843675 *a]];
    [mDic setObject:[NSNumber numberWithInt:27]      forKey:[NSNumber numberWithInt:3437321 *a]];
    [mDic setObject:[NSNumber numberWithInt:28]      forKey:[NSNumber numberWithInt:4263988 *a]];
    [mDic setObject:[NSNumber numberWithInt:29]      forKey:[NSNumber numberWithInt:5243675 *a]];
    [mDic setObject:[NSNumber numberWithInt:30]      forKey:[NSNumber numberWithInt:6436383 *a]];
    [mDic setObject:[NSNumber numberWithInt:31]      forKey:[NSNumber numberWithInt:7842113 *a]];
    [mDic setObject:[NSNumber numberWithInt:32]      forKey:[NSNumber numberWithInt:9460863 *a]];
    [mDic setObject:[NSNumber numberWithInt:33]      forKey:[NSNumber numberWithInt:11292633 *a]];
    [mDic setObject:[NSNumber numberWithInt:34]      forKey:[NSNumber numberWithInt:12437425 *a]];
    [mDic setObject:[NSNumber numberWithInt:35]      forKey:[NSNumber numberWithInt:14770758 *a]];
    [mDic setObject:[NSNumber numberWithInt:36]      forKey:[NSNumber numberWithInt:16832425 *a]];
    [mDic setObject:[NSNumber numberWithInt:37]      forKey:[NSNumber numberWithInt:18942425 *a]];
    [mDic setObject:[NSNumber numberWithInt:38]      forKey:[NSNumber numberWithInt:21560758 *a]];
    [mDic setObject:[NSNumber numberWithInt:39]      forKey:[NSNumber numberWithInt:25007425 *a]];
    [mDic setObject:[NSNumber numberWithInt:40]      forKey:[NSNumber numberWithInt:28022425 *a]];
    [mDic setObject:[NSNumber numberWithInt:41]      forKey:[NSNumber numberWithInt:32065758 *a]];
    [mDic setObject:[NSNumber numberWithInt:42]      forKey:[NSNumber numberWithInt:37017425 *a]];
    [mDic setObject:[NSNumber numberWithInt:43]      forKey:[NSNumber numberWithInt:43077425 *a]];
    [mDic setObject:[NSNumber numberWithInt:44]      forKey:[NSNumber numberWithInt:49045758 *a]];
    [mDic setObject:[NSNumber numberWithInt:45]      forKey:[NSNumber numberWithInt:56022425 *a]];
    [mDic setObject:[NSNumber numberWithInt:46]      forKey:[NSNumber numberWithInt:67087425 *a]];
    [mDic setObject:[NSNumber numberWithInt:47]      forKey:[NSNumber numberWithInt:72271175 *a]];
    [mDic setObject:[NSNumber numberWithInt:48]      forKey:[NSNumber numberWithInt:86173675 *a]];
    [mDic setObject:[NSNumber numberWithInt:49]      forKey:[NSNumber numberWithInt:99094925 *a]];
    [mDic setObject:[NSNumber numberWithInt:50]      forKey:[NSNumber numberWithInt:140034925 *a]];
    
    return mDic;
}

@end
