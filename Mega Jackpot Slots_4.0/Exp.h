//
//  Exp.h
//  Template
//
//  Created by Slavian on 2013-10-10.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exp : NSObject
{
}

+(int)checMaxMachineWithLevelNr:(int)lvl;
+(BOOL)checkUnlockMachine:(int)lvl;
+(int)returnLevelByEXP:(int)exp_;
+(int)returnExpPercentage:(int)exp_;
+(int)checkMachineN:(int)lvl;

@end
