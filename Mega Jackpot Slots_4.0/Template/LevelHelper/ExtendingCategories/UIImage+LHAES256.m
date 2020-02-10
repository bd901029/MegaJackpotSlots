//
//  UIImage+LHAES256.m
//  LevelHelper API
//
//  Created by Rabih on 7/5/11.
//  Modified by Vladu Bogdan for LevelHelper usage
//

#import "UIImage+LHAES256.h"
#import "NSData+LHAES256.h"

#if __has_feature(objc_arc) && __clang_major__ >= 3
#define LH_ARC_ENABLED 1
#endif // __has_feature(objc_arc)


@implementation UIImage (AES256)

+ (UIImage *)imageWithContentsOfEncryptedFile:(NSString *)path withKey:(NSData *)key {
   
#ifndef LH_ARC_ENABLED
    return [[[self alloc] initWithContentsOfEncryptedFile:path withKey:key] autorelease];
#else
    return [[self alloc] initWithContentsOfEncryptedFile:path withKey:key];
#endif
}

- (id)initWithContentsOfEncryptedFile:(NSString *)path withKey:(NSData *)key {
    NSData *data = [[NSData alloc] initWithContentsOfEncryptedFile:path withKey:key];
    if (!data) {
#ifndef LH_ARC_ENABLED
        [self release];
#else
        self = nil;
#endif
        return nil;
    }
    self = [self initWithData:data];
    
#ifndef LH_ARC_ENABLED
    [data release];
#else 
    data = nil;
#endif
    
    return self;
}

@end
