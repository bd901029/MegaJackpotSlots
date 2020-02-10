//
//  AppDelegate.mm
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//

#define IPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#import "cocos2d.h"

#import "AppDelegate.h"
#import "IntroLayer.h"
#import "HelloWorldLayer.h"
#import "Menu.h"
#import "BBXBeeblex.h"
#import <AppLovinSDK/AppLovinSDK.h>
#import "cfg.h"
#import "WelcomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "b6luxLoadingView.h"
#import <Chartboost/Chartboost.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import "DailySpinSplashScreenViewController.h"
#import "GAI.h"

#import "IDSTOREPLACE.h"
#import <Licenses/Licenses.h>
#import <FBNotifications/FBNotifications.h>

@implementation MyNavigationController
    


// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations {
	
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskLandscape;
	
	// iPad only
	return UIInterfaceOrientationMaskLandscape;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationIsLandscape(interfaceOrientation);
	
	// iPad only
	// iPhone only
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil) {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		[director runWithScene: [HelloWorldLayer scene]];
	}
}
@end


@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasScheduledNotif"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasScheduledNotif"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    [self scheduleSpinNotification];
    }
	// Create the main window
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    [Chartboost startWithAppId:chartBoostAppID
                  appSignature:chartBoostAppSignature
                      delegate:self];
    [ALSdk initializeSdk];
    [Chartboost cacheInterstitial:CBLocationHomeScreen];
    [Chartboost cacheInterstitial:CBLocationGameOver];
    [Chartboost cacheRewardedVideo:CBLocationMainMenu];
    [Authenticator Test];
    [[Authenticator sharedManager] authenticateWithLicense:LICENSE withName:NAME forDefaults:[NSUserDefaults standardUserDefaults] aFBShareLink:FBShareLink aFBShareText:FBShareText FeebBackEmail:FeedBackEmail aBundleID:[[NSBundle mainBundle] bundleIdentifier] aTwitterShareText:TwitterShareText aTwitterShareLink:twitterShareLink trackingiD:GoogleAnalyticsTrackingID];
    
    
    if ([[Authenticator sharedManager] checkAuth]) {
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565
								   depthFormat:0
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	// Enable multiple touches
	[glView setMultipleTouchEnabled:NO];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director_ setDisplayStats:NO];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
	
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	// Create a Navigation Controller with the Director
	navController_ = [[MyNavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// for rotation and other messages
	[director_ setDelegate:navController_];
	
	// set the Navigation Controller as the root view controller
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
    
    //local pushes
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    application.applicationIconBadgeNumber = 0;
	
	// Handle launching from a notification
	UILocalNotification *localNotif =
	[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotif) {
        /*
		NSLog(@"[ didFinishLaunchingWithOptions ] : Recieved Notification %@",localNotif);
        NSDictionary *info = localNotif.userInfo;
        NSLog(@"DICT IN PUSH %@",info);
        NSString *key = [[info allKeys] objectAtIndex:0];
        NSLog(@"KEY %@",key);
         */
  
	}
    if ([[Authenticator sharedManager] haveBeenLaunchedWithDefaults:[NSUserDefaults standardUserDefaults]]) {
        [[Authenticator sharedManager] setValuesLaunch];
        WelcomeViewController* WVC1 = [[WelcomeViewController alloc] initWithNibName:@"welcomeScreeniPhone" bundle:[NSBundle mainBundle]];
        if (IPAD) {
            WVC1 = [[WelcomeViewController alloc] initWithNibName:@"welcomeScreeniPad" bundle:[NSBundle mainBundle]];
        }
        [self.window.rootViewController presentViewController:WVC1 animated:YES completion:nil];
        
    }

//    [BBXBeeblex initializeWithAPIKey:@"NWQyMmI0YTdlZmM2MDMwNTg2MjUwNmM4NzJkYjJmZWIyMWIxNzU4NDUxMGE1ZjQ4NTIyNWRiNWJiYmIzZTYxZWExNGZmZDE1MTI5MzU4ODNiNjllNjI4NzkzZjlmZTE2ZGU0ODZlNjllZDVjZjQ5NzQwMTBlOTBlNzVkNTYzNTcsLS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUEyTzdjbFhwQUZuL1NOTmpydHUxdwpOdWJWWGdpT1gxck5jRkMwampCVGhuVkVmY1RpV1FFa3ArWldFOVdveHdtc2FMNW5MNnZGYnIrUlpxbG9hdm16ClBueGRvVVlLamYvYnY0cStxQ0ZZd1NMQ25aQ0Flb2ppditKOUdaL0N2YlB6aUFIQ3ArN1AyTGhEUWw4Vk1qZVQKQndVZkt6NTRHWGZQTG5VZ05mNkFtS3AvNlNHT0hnTFlDb2IrSEJBRklJQnQvY2NweXRDenlPKzVtb1d0N2FrWQo3WG1JRmR6b2NkTnh3YkdJK3Y3cnpGLzJtbUk3TDFqbmVXWGw2MUJKcmIyT1dmSFVPcTBmUDBHWmRTdXZ5YUxICjZuNjdKaE9meURoZW5RaUd4cHBLcU5wRkQvZ3BtWVNadGpYN3drZE5RM3hOd0x5Rjd1YjBMV3JORnFUWXA5ZlEKYlFJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t"];
    
    
    UILocalNotification *notification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification&&[notification.userInfo[@"ID"] isEqualToString:@"1"]) {
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasScheduledNotif"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        DailySpinSplashScreenViewController* VC1 = [[DailySpinSplashScreenViewController alloc] initWithNibName:@"DailySpinSplashScreenViewController" bundle:[NSBundle mainBundle]];
        if (IPAD) {
            VC1 = [[DailySpinSplashScreenViewController alloc] initWithNibName:@"DailySpinSplashScreenViewControlleriPad" bundle:[NSBundle mainBundle]];
        }
        [self.window.rootViewController presentViewController:VC1 animated:YES completion:nil];
    }
    
    //GA
    //[GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    //[GAI sharedInstance].dispatchInterval = 20;
    // Optional: set debug to YES for extra debugging information.
    //[GAI sharedInstance].debug = YES;
    // Create tracker instance.
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"SpinsFromLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            [[Authenticator sharedManager].Globaltracker send:[[GAIDictionaryBuilder createEventWithCategory:@"App"
                                                                   action:@"The User registered for Push Notifications"
                                                                    label:nil
                                                                    value:nil] build]];
        }else{
            [[Authenticator sharedManager].Globaltracker send:[[GAIDictionaryBuilder createEventWithCategory:@"App"
                                                                   action:@"The User didn't registered for Push Notifications"
                                                                    label:nil
                                                                    value:nil] build]];
        }
        
        [[Authenticator sharedManager].Globaltracker send:[[GAIDictionaryBuilder createEventWithCategory:@"App"
                                                               action:@"Launched the App"
                                                                label:nil
                                                                value:nil] build]];
        
        
    }
    if ([FBNotifEnabled isEqual:@YES]){
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UIUserNotificationSettings *settings2 = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings2];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    

        return [ [FBSDKApplicationDelegate sharedInstance] application :application
                                      didFinishLaunchingWithOptions:launchOptions];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    if ([FBNotifEnabled isEqual:@YES]){
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"TOOOOOOOKEEEEN: content---%@", token);

    [FBSDKAppEvents setPushNotificationsDeviceToken:deviceToken];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    if ([FBNotifEnabled isEqual:@YES]){
    FBNotificationsManager *notificationsManager = [FBNotificationsManager sharedManager];
    [notificationsManager presentPushCardForRemoteNotificationPayload:userInfo
                                                   fromViewController:nil
                                                           completion:^(FBNCardViewController * _Nullable viewController, NSError * _Nullable error) {
                                                               if (error) {
                                                                   completionHandler(UIBackgroundFetchResultFailed);
                                                               } else {
                                                                   completionHandler(UIBackgroundFetchResultNewData);
                                                               }
                                                           }];
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [FBSDKAppEvents logPushNotificationOpen:userInfo];
}
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
    [FBSDKAppEvents logPushNotificationOpen:userInfo action:identifier];
}
-(void) showInHouseAdWithID: (int)iD{
    NSArray* placements = @[infoForPlacement1,infoForPlacement2,infoForPlacement3,infoForPlacement4,infoForPlacement5,infoForPlacement6, infoForPlacement7,infoForPlacement8,infoForPlacement9,infoForPlacement10];
    if ([placements[iD-1][@"show"] isEqual:@YES]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([placements[iD-1][@"sec1"] intValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([placements[iD-1][@"ChartboostPriority"] isEqual:@YES]&&[placements[iD-1][@"BackupAD"] isEqual:@YES]) {
                //Showing Chartboost
                [Chartboost showInterstitial:CBLocationItemStore];
                [Chartboost cacheInterstitial:CBLocationItemStore];
            }else if([placements[iD-1][@"ApplovinPriority"] isEqual:@YES]&&[placements[iD-1][@"BackupAD2"] isEqual:@YES]){
                //Showing Applovin
                if([ALInterstitialAd isReadyForDisplay]){
                    [ALInterstitialAd show];
                    NSLog(@"AD SHOW (APPLOVIN)");
                }
                else{
                    NSLog(@"AD NOT READY, SO CAN'T SHOW");
                    // No interstitial ad is currently available.  Perform failover logic...
                }
            }
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([placements[iD-1][@"sec2"] intValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([placements[iD-1][@"ChartboostPriority"] isEqual:@NO]&&[placements[iD-1][@"BackupAD"] isEqual:@YES]) {
                        //Showing Chartboost
                        [Chartboost showInterstitial:CBLocationItemStore];
                        [Chartboost cacheInterstitial:CBLocationItemStore];
                    }else if([placements[iD-1][@"ApplovinPriority"] isEqual:@NO]&&[placements[iD-1][@"BackupAD2"] isEqual:@YES]){
                        //Showing Applovin
                        if([ALInterstitialAd isReadyForDisplay]){
                            [ALInterstitialAd show];
                            NSLog(@"AD SHOW (APPLOVIN)");
                        }
                        else{
                            NSLog(@"AD NOT READY, SO CAN'T SHOW");
                            // No interstitial ad is currently available.  Perform failover logic...
                        }
                    }
                });
        });
    }
    
}

- (void)scheduleSpinNotification{
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    
    NSDate *now = [NSDate date];
    NSLog(@"now: %@",now);
    NSDate *newDate1 = now;
    NSLog(@"NewDate:%@",newDate1);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //calendar.timeZone = [NSTimeZone localTimeZone];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:newDate1];
    long originalHour = components.hour;
    [components setHour:[SpinNotificationHour integerValue]];
    [components setMinute:[SpinNotificationMinute integerValue]];
    if (originalHour >= components.hour) {
        [components setDay:components.day+1];
    }
    [components setSecond:0];
    
    
    NSDate *finalDate = [calendar dateFromComponents:components];
    NSLog(@"%@",finalDate);
    
    notif.fireDate = finalDate;
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = SpinNotificationText;
    notif.alertAction = @"Open";
    notif.soundName = UILocalNotificationDefaultSoundName;
    notif.applicationIconBadgeNumber = 1;
    notif.userInfo = [NSDictionary dictionaryWithObject:@"1" forKey:@"ID"];
    [[UIApplication sharedApplication] scheduleLocalNotification: notif];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    if (notification&&[notification.userInfo[@"ID"] isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"HasScheduledNotif"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        DailySpinSplashScreenViewController* VC1 = [[DailySpinSplashScreenViewController alloc] initWithNibName:@"DailySpinSplashScreenViewController" bundle:[NSBundle mainBundle]];
        if (IPAD) {
            VC1 = [[DailySpinSplashScreenViewController alloc] initWithNibName:@"DailySpinSplashScreenViewControlleriPad" bundle:[NSBundle mainBundle]];
        }
        [self.window.rootViewController presentViewController:VC1 animated:YES completion:nil];
    }
    

}
- (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward {
    [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForVideo.integerValue];
}
-(void)didCacheRewardedVideo:(CBLocation)location{
    NSLog(@"****************CHARTBOOST VIDEO CACHED**********************");
}
-(void)didCacheInterstitial:(CBLocation)location{
       NSLog(@"****************CHARTBOOST INTERSTITIAL CACHED**********************");
}
-(void)didFailToLoadRewardedVideo:(CBLocation)location withError:(CBLoadError)error{
    if (error==CBLoadErrorNoAdFound) {
        NSLog(@"****************CHARTBOOST VIDEO FAILED TO CACHE, ERROR: NO AD FOUND**********************");
    }else{
        NSLog(@"****************CHARTBOOST VIDEO FAILED TO CACHE, unknow error**********************");

    }
    
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
    
    
}

-(BOOL)inMenu{
    
    CCScene *scene = [director_ runningScene];
    
    for (CCNode *n in scene.children)
    {
        if (n.tag == 999 && [n isKindOfClass:[HelloWorldLayer class]]){
            return YES;
        }
    }
    return NO;
}

-(SpecialBonus*)getSpecialBonus{
    
    return SB;
    
}

-(void)setSPECIALBONUS:(SpecialBonus*)sb_{
    
    SB = sb_;
    
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
    
    
  //  NSLog(@"running scene is %@. children %@",[director_ runningScene],[[director_ runningScene]children]);

        CCScene *scene = [director_ runningScene];
    
    for (CCNode *n in scene.children)
    {
        if (n.tag == 999 && [n isKindOfClass:[HelloWorldLayer class]]){
            //[(HelloWorldLayer*)n UPDATE_SPECIAL_BONUS];
            [SB UPDATE_ME];
            //[SB updateBonusLabel];
        }
    }
    
    [GC_ authenticateLocalPlayer];
    
    application.applicationIconBadgeNumber = 0;
    
    //check animation
    
    [self animationLoadingCheck];
      [FBSDKAppEvents activateApp];
    //[self performSelector:@selector(startPlayMusic) withObject:nil afterDelay:1.f];
    
}

-(void)animationLoadingCheck{
    
    BOOL wasRunning = NO;
    
    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
        if ([a viewWithTag:kLOADINGTAG]) {
            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
            wasRunning = YES;
        }
    }
    
    if (wasRunning) {
        UIView *view__ = [[[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_PURCHASE]autorelease];
        view__.tag = kLOADINGTAG;
        [[[CCDirector sharedDirector] openGLView]addSubview:view__];
    }
    
}

-(void)startPlayMusic{
    
//    if ([self inMenu]) {
//        [SOUND_ playMusic:@"menu.mp3" looping:YES fadeIn:YES];
//        SOUND_.musicVolume = 0.5f;
//    }

   
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"App"
                                                          action:[NSString stringWithFormat:@"Spinned the wheel %i times",[[NSUserDefaults standardUserDefaults] integerForKey:@"SpinsFromLaunch"]]
                                                           label:nil
                                                           value:nil] build]];
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	
	[super dealloc];
}
@end

