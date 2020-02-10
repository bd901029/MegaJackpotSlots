//
//  _security.h
//  Template
//
//  Created by macbook on 2013-10-30.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface _security : NSObject

+(NSString *)convertIntoMD5:(NSString *) string;

+(void)_secureSaveFLOAT_Value:(float)val_ forKey:(NSString*)key_;

+(BOOL)_secure_VALIDATE_Key:(NSString*)key_ withValue:(float)value_;

+(float)_secure_UNHACK_ForKey:(NSString*)key_;

@end
