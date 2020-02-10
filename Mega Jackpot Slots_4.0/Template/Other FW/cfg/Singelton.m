
#import "Singelton.h"
#import "cfg.h"
#import "Strings.h"

@implementation Singelton

+(id)shared{
    static id shared = nil;
    
    if (shared == nil) {
        
        shared = [[self alloc] init];
    }
    return shared;
}

-(id) init
{
    if ( (self=[super init]) ) {
           
    
        
    }
    return self;
}

@end
