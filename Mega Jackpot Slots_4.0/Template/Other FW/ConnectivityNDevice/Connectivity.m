
//

#import "Connectivity.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation Connectivity

+(BOOL)hasConnectivity {
    
    struct sockaddr_in zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    
    zeroAddress.sin_len = sizeof(zeroAddress);
    
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    
    if(reachability != NULL) {
        
        
        SCNetworkReachabilityFlags flags;
        
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
                
            {
                
                return NO;
                
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
                
            {
                
                // if target host is reachable and no connection is required
                
                //  then we'll assume (for now) that your on Wi-Fi
                
                return YES;
                
            }
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
                
            {
                
                
                
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                    
                {
                    
                    // ... and no [user] intervention is needed
                    
                    return YES;
                    
                }
                
            }
            
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
                
            {
                
                // ... but WWAN connections are OK if the calling application
                
                //     is using the CFNetwork (CFSocketStream?) APIs.
                
                return YES;
                
            }
            
        }
        
    }

    
    return NO;
    
}


@end
