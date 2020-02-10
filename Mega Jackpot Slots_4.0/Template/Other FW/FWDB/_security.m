//
//  _security.m
//  Template
//
//  Created by macbook on 2013-10-30.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "_security.h"
#import "Combinations.h"
#import "cfg.h"

@implementation _security{
    
}

+(NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

+(void)_secureSaveFLOAT_Value:(float)val_ forKey:(NSString*)key_{
    
    NSString *val = [NSString stringWithFormat:@"%f",val_];
    
    NSString *keySecured    = [_security convertIntoMD5:key_];
    NSString *valueSecured  = [_security convertIntoMD5:val];
    
    [Combinations saveNSDEFAULTS_String:valueSecured forKey:keySecured];
    
    //NSLog(@"\n:::%f:::<%@>\n:::%@:::<%@>",val_,key_,valueSecured,keySecured);
    
}

+(float)_secure_UNHACK_ForKey:(NSString*)key_{
    
    float ret_ = 0;
    
    if ([key_ isEqualToString:d_Coins])
    {
        [DB_ updateValue:d_Coins table:d_DB_Table :k_First_Cash];
        ret_  = k_First_Cash;
    }
    else if ([key_ isEqualToString:d_Level])
    {
        [DB_ updateValue:d_Level table:d_DB_Table :0];
        ret_  = 0;
    }
    else if ([key_ isEqualToString:d_Exp])
    {
        [DB_ updateValue:d_Exp table:d_DB_Table :0];
        ret_  = 0;
    }
    else if ([key_ isEqualToString:d_Boost2x])
    {
        [DB_ updateValue:d_Boost2x table:d_DB_Table :5];
        ret_  = 5;
    }
    else if ([key_ isEqualToString:d_Boost3x])
    {
        [DB_ updateValue:d_Boost3x table:d_DB_Table :5];
        ret_  = 5;
    }
    else if ([key_ isEqualToString:d_Boost4x])
    {
        [DB_ updateValue:d_Boost4x table:d_DB_Table :5];
        ret_  = 5;
    }
    else if ([key_ isEqualToString:d_Boost5x])
    {
        [DB_ updateValue:d_Boost5x table:d_DB_Table :5];
        ret_  = 5;
    }
    else if ([key_ isEqualToString:d_LastWin])
    {
        [DB_ updateValue:d_LastWin table:d_DB_Table :0];
        ret_  = 0.f;
    }
    else if ([key_ isEqualToString:d_WinAllTime])
    {
        [DB_ updateValue:d_WinAllTime table:d_DB_Table :0];
        ret_  = 0.f;
    }
    else if ([key_ isEqualToString:d_LoseAllTime])
    {
        [DB_ updateValue:d_LoseAllTime table:d_DB_Table :0];
        ret_  = 0.f;
    }
    
    return ret_;
}

+(BOOL)_secure_VALIDATE_Key:(NSString*)key_ withValue:(float)value_{
    
    NSString *keySecured = [_security convertIntoMD5:key_];
    NSString *savedValue = [Combinations getNSDEFAULTS_String:keySecured];
    
    NSString *valueGivenSecured = [_security convertIntoMD5:[NSString stringWithFormat:@"%f",value_]];
    
    if ([valueGivenSecured isEqualToString:savedValue]) {
        //NSLog(@"VALIDATED key < %@ >-> NOT HACKED",key_);
        return YES;
    }
    else {
       // NSLog(@"!!! WRONG VALIDATION !!! -> HACKED key < %@ >",key_);
        return NO;
    }
    
    return NO;
}

@end
