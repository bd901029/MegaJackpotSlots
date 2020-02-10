
#import "FacebookManager.h"

#import "FacebookIconManager.h"

#import "cfg.h"

@implementation FacebookManager

@synthesize facebook;


static NSString* kAppId = @"";

static FacebookManager * _sharedHelper = nil;

+ (FacebookManager *) sharedMgr {
	
    if (_sharedHelper == nil) {
        _sharedHelper = [[FacebookManager alloc] init];
    }
    return _sharedHelper;
	
}

-(void)Init
{
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    
    if (![facebook isSessionValid]) {
        [facebook authorize:nil];
        
        
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes",
                                @"read_stream",
                                nil];
        [facebook authorize:permissions];
        [permissions release];
        
    }
    
    [[FacebookIconManager sharedMgr] Init];
}

-(void)GetSelf {
    cmd = CMD_SELF;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"name,picture",  @"fields",
                                   nil];
    [facebook requestWithGraphPath:@"me" andParams:params  andDelegate:self];
    
}

-(void)GetFriends {
    cmd = CMD_FRIENDS;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"name,picture",  @"fields",
                                   nil];
    [facebook requestWithGraphPath:@"me/friends" andParams:params  andDelegate:self];
    
}

-(void)GetAppFriends {
    cmd = CMD_APP_FRIENDS;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"friends.getAppUsers", @"method",
                                   nil];
    [facebook requestWithParams:params andDelegate:self];
}

-(void)Feed:(CCNode *)sender{
    
    parent = sender;
    
     facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    if (![facebook isSessionValid]) {
        //[facebook authorize:nil];
        //[facebook authorize:[NSArray arrayWithObjects:@"publish_stream",@"offline_access",nil]];
    }
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    // The action links to be shown with the post in the feed
    
    /*
    NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Get Started",@"name",facebookZombieJoeLink,@"link", nil], nil];
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    // Dialog parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   facebookSHAREname, @"name",
                                   facebookSHAREtxt, @"description",
                                   iTunesLink, @"link",
                                   facebookImageLink, @"picture",
                                   actionLinksStr, @"actions",
                                   nil];
     
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
     */

}


- (void)fbDidLogin {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}

- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

- (void)fbDidNotLogin:(BOOL)cancelled {
    
}

- (void)fbSessionInvalidated {
    
}


-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"%@", result);
    
    
    
    NSString* url;
    NSString* name;
    //NSString* ID;
    
    switch (cmd) {
        case CMD_SELF:
            //ID = [result objectForKey:@"id"];
            url = [result objectForKey:@"picture"];
            name = [result objectForKey:@"name"];;

            break;
        case CMD_FRIENDS:
            //ID = [[[result objectForKey:@"data"] objectAtIndex:0] objectForKey:@"id"];
            url = [[[result objectForKey:@"data"] objectAtIndex:0] objectForKey:@"picture"];
            name = [[[result objectForKey:@"data"] objectAtIndex:0] objectForKey:@"name"];
            break;
        case CMD_APP_FRIENDS:
            return;
        default:
            assert(false);
            break;
    }
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Error message: %@", [[error userInfo] objectForKey:@"error_msg"]);
}

- (void)dialogCompleteWithUrl:(NSURL *)url {
    
    NSLog(@"%@",[url query]);
//    
//    return;
    
    if (![url query]) {
//        if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//            [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//        }
        NSLog(@"User canceled dialog or there was an error");
        return;
    }
    
    
//    if ([parent isKindOfClass:[B6luxPopUpManager class]]) {
//        B6luxPopUpManager*p = (B6luxPopUpManager*)parent;
//        int level = [p returnLevelNr];
//        //[parent_ returnLevelNr];
//        [db SS_sharegame_player:[gc_ getLocalPlayerAlias] level:level type:@"facebook"];
//        [parent performSelector:@selector(submitShare) withObject:nil];
//    }
    parent = nil;
//    if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//        [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//    }
    NSLog(@"User done dialog");

}

- (void)dialogDidNotComplete:(FBDialog *)dialog {
    NSLog(@"Dialog dismissed.");
//    if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//        [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//    }
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error {
    NSLog(@"Error message: %@", [[error userInfo] objectForKey:@"error_msg"]);
}

- (void)dialogDidComplete:(FBDialog *)dialog{
    
  
    
}

@end
