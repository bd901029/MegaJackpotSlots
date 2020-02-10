//
//  FreeCoinsWindow.m
//  Fun Vegas Slots
//
//  Created by Orban Balazs on 24/02/16.
//  Copyright © 2016 bsixlux. All rights reserved.
//

#import "FreeCoinsWindow.h"
#import "PayTableWindow.h"
#import "PopupManager.h"
#import "IDSTOREPLACE.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Chartboost/Chartboost.h>
#import <Social/Social.h>
#import "AppDelegate.h"

@implementation FreeCoinsWindow

-(id)init
{
    if((self = [super init]))
    {
        
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        
        
        bg             = [CCSprite spriteWithFile:@"popup_bg.png"];
        bg.scale       = ((IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX))*1.7;
        bg.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        if (IS_STANDARD_IPHONE_6_PLUS) {
            bg.scale = 0.45*1.7;
        }
        [self addChild:bg z:1];
    

//
        [self blackScreen_with_Z_order:0];
        [self addButtons];
    }
    
    return self;
}

-(void) addButtons
{
    closeBtn                  = [CCSprite spriteWithFile:@"paytable_back.png"];
    closeBtn.scale            = (IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX);
    closeBtn.position         = ccp(kWidthScreen/2, kHeightScreen/10*1.5);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        closeBtn.scale = 0.45;
    }
    if(IS_IPAD){
    closeBtn.position         = ccp(kWidthScreen/2, kHeightScreen/10*1.5-70);
    }
    [self addChild:closeBtn z:9];
    
    
    FBInvite = [CCSprite spriteWithFile:@"InviteFB_iphone.png"];
    FBInvite.position = ccp(kWidthScreen/2, kHeightScreen/11*9);
    FBInvite.scale = ((IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX))*1.7;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        FBInvite.scale = 0.45*1.7;
    }
    if(IS_IPAD){
        FBInvite.position = ccp(kWidthScreen/2, kHeightScreen/11*9-30);
    }
    [self addChild:FBInvite z:2] ;
    
    FBShare = [CCSprite spriteWithFile:@"shareonfbbutton_iphone.png"];
    FBShare.position = ccp(kWidthScreen/2, kHeightScreen/11*7.5);
    FBShare.scale = ((IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX))*1.7;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        FBShare.scale = 0.45*1.7;
    }
    if(IS_IPAD){
      FBShare.position = ccp(kWidthScreen/2, kHeightScreen/11*7.5-30);
    }
    [self addChild:FBShare z:2] ;
    
    TwitterShare = [CCSprite spriteWithFile:@"shareontwitterbutton_iphone.png"];
    TwitterShare.position = ccp(kWidthScreen/2, kHeightScreen/11*6);
    TwitterShare.scale = ((IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX))*1.7;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        TwitterShare.scale = 0.45*1.7;
    }
    if(IS_IPAD){
       TwitterShare.position = ccp(kWidthScreen/2, kHeightScreen/11*6-30);
    }
    [self addChild:TwitterShare z:2] ;
    
    WatchVid = [CCSprite spriteWithFile:@"Watchavideoforcoinsbutton_iphone.png"];
    WatchVid.position = ccp(kWidthScreen/2, kHeightScreen/11*4.5);
    WatchVid.scale = ((IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX))*1.7;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        WatchVid.scale = 0.45*1.7;
    }
    if(IS_IPAD){
        WatchVid.position = ccp(kWidthScreen/2, kHeightScreen/11*4.5-30);
    }
    [self addChild:WatchVid z:2] ;
    
    if (![Chartboost hasRewardedVideo:CBLocationMainMenu]) {
        WatchVid.opacity = 50;
        [self CheckVidAvailability];
    }
    
    emailFriend = [CCSprite spriteWithFile:@"emailafriendforcounsbutton_iphone.png"];
    emailFriend.position = ccp(kWidthScreen/2, kHeightScreen/11*3);
    emailFriend.scale = ((IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX))*1.7;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        emailFriend.scale = 0.45*1.7;
    }
    if(IS_IPAD){
        emailFriend.position = ccp(kWidthScreen/2, kHeightScreen/11*3-30);
    }
    [self addChild:emailFriend z:2] ;

}
-(void) CheckVidAvailability{
    if ([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
        WatchVid.opacity = 100;
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self CheckVidAvailability];
        });
    }
}

-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    [super onEnter];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}



-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
    id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
    id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [closeBtn runAction:runAnimation];
        [self closeWindow];
    }
    if (CGRectContainsPoint(FBInvite.boundingBox, touchPos))
    {
        //FB INVITE
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Facebook"]) {
            [self Invite];
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                                  action:@"Clicked Facebook invite"
                                                                   label:nil
                                                                   value:nil] build]];
        }
        else{
            //FB Login
            [self FBLogin];
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                                  action:@"Clicked Facebook login"
                                                                   label:nil
                                                                   value:nil] build]];

        }
    }
    if (CGRectContainsPoint(FBShare.boundingBox, touchPos))
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"Facebook"]) {
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                                  action:@"Clicked Facebook share"
                                                                   label:nil
                                                                   value:nil] build]];

            [self FBShare];
        }
//        else{
//            //FB Login
//            [self FBLogin];
//        }
        //FB Share
    }
    if (CGRectContainsPoint(TwitterShare.boundingBox, touchPos))
    {
        //Twitter Share
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                              action:@"Clicked twitter share"
                                                               label:nil
                                                               value:nil] build]];

        [self twitterShare];
    }
    if (CGRectContainsPoint(WatchVid.boundingBox, touchPos))
    {
        //Watch Vid
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                              action:@"Clicked rewarded video"
                                                               label:nil
                                                               value:nil] build]];

        [self ShowRewardedVid];
    }
    if (CGRectContainsPoint(emailFriend.boundingBox, touchPos))
    {
        //Email friend
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                              action:@"Clicked email invite"
                                                               label:nil
                                                               value:nil] build]];

        [self emailInvite];
    }
    
    
    return YES;
}


-(void) closeWindow
{
    if ([_parent isKindOfClass:[PopupManager class]])
    {
        [_parent performSelector:@selector(closeFreeCoinsWindow) withObject:nil];
    }else{
        [self.parent removeChild:self];
    }
}
-(void) FBLogin{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:((AppController*)[[UIApplication sharedApplication] delegate]).window.rootViewController
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         });
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
             
             [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                                   action:@"Logged in to Facebook"
                                                                    label:nil
                                                                    value:nil] build]];

             [((CCSprite*)[self getChildByTag:754]) setTexture:[[CCSprite spriteWithFile:@"fbinvite.png"]texture]];
             if ([result.grantedPermissions containsObject:@"email"]) {
                 NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                 [parameters setValue:@"id,name,email" forKey:@"fields"];
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                               id result, NSError *error) {
                      NSLog(@"%@",result[@"email"]);
                      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Facebook"];
                      [[NSUserDefaults standardUserDefaults] synchronize];
                      [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForFBLogin.integerValue];
                      
                    }];
             }
         }
     }];
}
-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results{
    NSLog(@"%@",results);
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                          action:@"Shared on Facebook"
                                                           label:nil
                                                           value:nil] build]];

        [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForFBShare.integerValue];
        //Close the window
        id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
        id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
        id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
        [AUDIO playEffect:s_click1];
        [closeBtn runAction:runAnimation];
        [self closeWindow];
}
-(void)sharerDidCancel:(id<FBSDKSharing>)sharer{
    NSLog(@"Canceled");
}

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error{
    NSLog(@"ERROR");
}
-(void)Invite{
    //FB invite
    FBSDKAppInviteContent *content =[[FBSDKAppInviteContent alloc] init];
    content.appLinkURL = [NSURL URLWithString:AppLinkAppStore];
    // optionally set previewImageURL
    // content.appInvitePreviewImageURL = [NSURL URLWithString:FBInviteImage];
    
    
    
    // present the dialog. Assumes self implements protocol `FBSDKAppInviteDialogDelegate`
    //[FBSDKAppInviteDialog showWithContent:content delegate:self];
    [FBSDKAppInviteDialog showFromViewController:((AppController*)[[UIApplication sharedApplication] delegate]).window.rootViewController withContent:content delegate:self];
}
-(void)ShowRewardedVid{
    if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
        [Chartboost showRewardedVideo:CBLocationMainMenu];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                              action:@"Showed Rewarded video"
                                                               label:nil
                                                               value:nil] build]];

    }
}
-(void)FBShare{
    
    FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    dialog.fromViewController = ((AppController*)[[UIApplication sharedApplication] delegate]).window.rootViewController;
    FBSDKShareLinkContent *link = [[FBSDKShareLinkContent alloc]init];

    link.contentURL = [NSURL URLWithString:FBShareLink];
    dialog.delegate = self;
    dialog.shareContent = link;
    dialog.mode = FBSDKShareDialogModeShareSheet;
    [dialog show];
    
//    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
//    content.contentURL = [NSURL URLWithString:FBShareLink];
//    if (![FBShareImageLink isEqualToString:@""]) {
//        content.imageURL = [NSURL URLWithString:FBShareImageLink];
//    }
//    [FBSDKShareDialog showFromViewController:((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController
//                                 withContent:content
//                                    delegate:self];
    
//    SLComposeViewController *FBSheet = [SLComposeViewController
//                                           composeViewControllerForServiceType:SLServiceTypeFacebook];
//    [FBSheet setInitialText:FBShareText];
//    [FBSheet setTitle:FBShareText];
//    [FBSheet addURL: [NSURL URLWithString:FBShareLink]];
//    FBSheet.completionHandler = ^(SLComposeViewControllerResult result) {
//        switch(result) {
//                //  This means the user cancelled without sending the Tweet
//            case SLComposeViewControllerResultCancelled:
//                break;
//                //  This means the user hit 'Send'
//            case SLComposeViewControllerResultDone:
//                NSLog(@"Completed");
//                [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForFBShare.integerValue];
//                //Close the window
//                id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
//                id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
//                id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
//                [AUDIO playEffect:s_click1];
//                [closeBtn runAction:runAnimation];
//                [self closeWindow];
//                break;
//        }
//    };
//    [((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:FBSheet animated:YES completion:^{
//        [FBSheet setInitialText:FBShareText];
//    }];
    
}
-(void) twitterShare{
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:TwitterShareText];
        [tweetSheet addURL: [NSURL URLWithString:twitterShareLink]];
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
                NSLog(@"Completed");
                id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
                
                [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                                      action:@"Twitter share completed"
                                                                       label:nil
                                                                       value:nil] build]];

                [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForTweet.integerValue];
                //Close the window
                id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
                id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
                id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
                [AUDIO playEffect:s_click1];
                [closeBtn runAction:runAnimation];
                [self closeWindow];
                break;
        }
    };
        [((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:tweetSheet animated:YES completion:^{
        }];
}
-(void) emailInvite{
    // Email Subject
    NSString *emailTitle = emailSubject;
    // Email Content
    NSString *messageBody = emailBody;
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    
    // Present mail view controller on screen
    [((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                                  action:@"Sent email invite"
                                                                   label:nil
                                                                   value:nil] build]];

            [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForEmail.integerValue];
            //Close the window
            id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
            id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
            id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
            [AUDIO playEffect:s_click1];
            [closeBtn runAction:runAnimation];
            [self closeWindow];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results{
    if(results.count>0 && !results[@"completionGesture"]){
        NSLog(@"%@",results);
    NSLog(@"Invite SUCCESS.. FREE REWARD!!! :)");
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"FreeCoinsWindow"
                                                              action:@"Completed Facebook Invite"
                                                               label:nil
                                                               value:nil] build]];

    [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForFBInvite.integerValue];
        //Close the window
        id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
        id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
        id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
        [AUDIO playEffect:s_click1];
        [closeBtn runAction:runAnimation];
        [self closeWindow];
    }
}
-(void)appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didFailWithError:(NSError *)error{
    
}
///////////////////// CREATE BLACK SCREEN ///////////////////////
-(void)blackScreen_with_Z_order:(int) Zorder_
{
    CCSprite *spr   = [CCSprite node];
    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
    spr.opacity     = 200;
    spr.anchorPoint = ccp(0, 0);
    spr.color       = ccc3(255,255,255);
    [self addChild:spr z:Zorder_ tag:kBlackSreen_TAG];
    
}










@end

