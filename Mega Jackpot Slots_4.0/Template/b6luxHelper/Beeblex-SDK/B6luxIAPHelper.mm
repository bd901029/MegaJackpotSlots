

#import "B6luxIAPHelper.h"

@implementation B6luxIAPHelper

+ (B6luxIAPHelper *)sharedInstance {
    static B6luxIAPHelper * sharedInstance;
    
    if (sharedInstance==nil) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

@end
