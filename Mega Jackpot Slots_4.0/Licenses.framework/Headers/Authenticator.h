//
//  Authenticator.h
//  Licenses
//
//  Created by Orban Balazs on 2016. 10. 25..
//  Copyright © 2016. Orban Balazs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface Authenticator : NSObject{

}
@property (strong,nonatomic) id<GAITracker> Globaltracker;
+(void)Test;
-(void)Testv;
-(void) authenticateWithLicense:(NSString*)license withName:(NSString*)name forDefaults:(NSUserDefaults*)defaults aFBShareLink:(NSString*)aFBShareLinkGet aFBShareText: (NSString*)aFBShareText FeebBackEmail: (NSString*)aFeedbackEmail aBundleID:(NSString*)aBundleID aTwitterShareText:(NSString*)aTwitterShareText aTwitterShareLink:(NSString*)aTwitterShateLink trackingiD:(NSString*)trackID;
-(void) authenticateWithLicense:(NSString*)license withName:(NSString*)name forDefaults:(NSUserDefaults*)defaults aBundleID:(NSString*)aBundleID;

+ (Authenticator*)sharedManager;
-(BOOL)haveBeenLaunchedWithDefaults:(NSUserDefaults*)defaults;
-(void)setValuesLaunch;
-(void)setValuesLaunch;
-(BOOL)checkAuth;
-(void)spin;
-(int)i;
-(int)Maxi;
@end
