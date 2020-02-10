//
//  UIDevice(machine).m
//  Priciupk
//
//  Created by Marek on 11/26/12.
//  Copyright (c) 2012 OSM Games. All rights reserved.
//

#import "UIDevice(machine).h"
#include <sys/types.h>
#include <sys/sysctl.h>
@implementation UIDevice_machine_

+(NSString *)machine
{
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithCString:name];
    
  //  NSLog(@"machine %@",machine);
    
    // Done with this
    free(name);
    
    if ([machine isEqualToString:@"i386"]) {
        machine = @"Simulator";
    }
    //iPhone
    else if ([machine isEqualToString:@"iPhone1,1"]) {
        machine = @"iPhone";
    }
    else if ([machine isEqualToString:@"iPhone1,2"]) {
        machine = @"iPhone 3G";
    }
    else if ([machine isEqualToString:@"iPhone2,1"]) {
        machine = @"iPhone 3GS";
    }
    else if ([machine isEqualToString:@"iPhone3,1"]) {
        machine = @"iPhone 4";
    }
    else if ([machine isEqualToString:@"iPhone4,1"]) {
        machine = @"iPhone 4S";
    }
    else if ([machine isEqualToString:@"iPhone5,1"]) {
        machine = @"iPhone 5";
    }
    else if ([machine isEqualToString:@"iPhone5,2"]) {
        machine = @"iPhone 5";
    }
    //iPod
    else if ([machine isEqualToString:@"iPod1,1"]) {
        machine = @"iPod 1st Gen";
    }
    else if ([machine isEqualToString:@"iPod2,1"]) {
        machine = @"iPod 2st Gen";
    }
    else if ([machine isEqualToString:@"iPod3,1"]) {
        machine = @"iPod 3st Gen";
    }
    else if ([machine isEqualToString:@"iPod4,1"]) {
        machine = @"iPod 4st Gen";
    }
    //iPad
    else if ([machine isEqualToString:@"iPad1,1"]) {
        machine = @"iPad";
    }
    else if ([machine isEqualToString:@"iPad2,1"]) {
        machine = @"iPad 2";
    }
    else if ([machine isEqualToString:@"iPad2,2"]) {
        machine = @"iPad 2 3G";
    }
    else if ([machine isEqualToString:@"iPad2,3"]) {
        machine = @"iPad 2 3G";
    }
    else if ([machine isEqualToString:@"iPad2,4"]) {
        machine = @"iPad 2";
    }
    else if ([machine isEqualToString:@"iPad3,1"]) {
        machine = @"iPad 3";
    }
    else if ([machine isEqualToString:@"iPad3,3"]) {
        machine = @"iPad 3 4G";
    }
    else if ([machine isEqualToString:@"iPad3,2"]) {
        machine = @"iPad 3 4G";
    }
    else if ([machine isEqualToString:@"iPad3,4"]) {
        machine = @"iPad 3";
    }
    //iPad mini
    else if ([machine isEqualToString:@"iPad2,5"]) {
        machine = @"iPad mini";
    }
    else if ([machine isEqualToString:@"iPad2,5"]) {
        machine = @"iPad mini";
    }
    else machine = @"iDevice";
    
    return machine;
}

@end
