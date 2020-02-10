//
//  NSDictionary+LHAES256.m
//  LevelHelper API
//
//  Created by Rabih on 7/5/11.
//  Modified by Vladu Bogdan for LevelHelper usage
//

#import "NSDictionary+LHAES256.h"
#import "NSData+LHAES256.h"

#if __has_feature(objc_arc) && __clang_major__ >= 3
#define LH_ARC_ENABLED 1
#endif // __has_feature(objc_arc)


@implementation NSDictionary (AES256)

+ (id)dictionaryWithContentsOfEncryptedFile:(NSString *)path withKey:(NSData *)key {
#ifndef LH_ARC_ENABLED
    return [[[self alloc] initWithContentsOfEncryptedFile:path withKey:key] autorelease];
#else
    return [[self alloc] initWithContentsOfEncryptedFile:path withKey:key];
#endif
}

- (id)initWithContentsOfEncryptedFile:(NSString *)path withKey:(NSData *)key {

    NSData *data = [[NSData alloc] initWithContentsOfEncryptedFile:path withKey:key];
    if (!data) 
        return nil;
    
    id plist = nil;
    if ([NSPropertyListSerialization resolveClassMethod:@selector(propertyListWithData:options:format:error:)]) 
        plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
    else
        plist = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:0 format:NULL errorDescription:NULL];
    
#ifndef LH_ARC_ENABLED
    [data release];
#else 
    data = nil;
#endif
    
    if (plist && [plist isKindOfClass:[NSDictionary class]])
    {
#ifndef LH_ARC_ENABLED
        self = [plist retain];
#else
        self = plist;
#endif
    }
    
    return self;
}

@end
