#import "SpecialBonus.h"
#import "cfg.h"
#import "TopMenu.h"
#import "Menu.h"
#import "Combinations.h"
#import <Chartboost/Chartboost.h>
#import "IDSTOREPLACE.h"
#import "WheelGame.h"
#import "DailyWheelGame.h"


#define kFullWaiTime            10800
#define kNotiftime              86400
#define kPushText               @"Special Bonus is ready. Come and get it!"
#define kPushTextNotif          @"Hey, don't forget to take your special bonus"
#define kbuttonBlinkActionTag    10



@implementation SpecialBonus{
    
    BOOL canTouch;
    int timeLeft;
    
    CCLabelBMFont *TIME_LEFT_LABEL;
    CCLabelBMFont *NO_CONNECTION_LABEL;
    
}

-(id)initWithRect:(CGRect)rect kProgress:(int)progress_ bonusValue:(int)bonus_;
{
    
    if((self = [super init]))
    {
        
        int plus = FreeRewardBonusAmountLVL.integerValue;
      //  int level = kLEVEL;
        int machinemaxNr = [Exp checMaxMachineWithLevelNr:kLEVEL];  //1;
        
        coins = FreeRewardBaseAmount.integerValue+(plus*machinemaxNr);
        
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        SPEC_BONUS = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_special_bonus.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_special_bonus.plist"]];
        [self addChild:SPEC_BONUS z:1];
        
        
        specBackground              = [CCSprite spriteWithSpriteFrameName:@"bonus_background.png"];
        specBackground.anchorPoint  = ccp(0.5f, 0);
        specBackground.position     = ccp(kWidthScreen/2, 0);
        [SPEC_BONUS addChild:specBackground z:2];
        
        Btn_Active          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_get_active.png"]];
        Btn_notActive       = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_get.png"]];
        
        b1 = false;
        
        [self addProgress];
        [self addTxtLabel];
        [self addButton ];
        
        //custom
        [self addTimeLeftLabel];
        
        [self UPDATE_ME];
        
        NSString *name = (IS_IPAD) ? @"coins_fly" : @"coins_fly_iPhone";
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",name]];
        
        Coina = [CCSprite spriteWithSpriteFrameName:@"coin_flat.png"];
        Coina.anchorPoint = ccp(0.5f, 0.5f);
        Coina.position = ccp(progress_line.position.x + progress_line.contentSize.width *0.4f, progress_line.position.y);
        Coina.scale = IS_IPAD ? ([Combinations isRetina]) ? 0.7f : 0.4f    : ([Combinations isRetina]) ? 0.4f : 0.4f ;
        Coina.visible = NO;
        [self addChild:Coina z:4];
        if (coins > 1000) {
            Coina.position = ccpAdd(Coina.position, ccp(-Coina.boundingBox.size.width*0.25f, 0));
        }
        
        
        
    }
    
    return self;
}

-(void)internetCheckingUpdate:(ccTime)dt{
    
    [self UPDATE_ME];
    
}

-(void)UPDATE_ME{
    
    canTouch = NO;
    
    button.opacity = 100;    //  first always should be small opacity, later change

   // NSLog(@"Must update special bonus %@",self);
    
//    else {
//        [self changeSpecialBonusStateTo:state_connected];
//    }

    
    [self unschedule:@selector(internetCheckingUpdate:)];
    
    //check if it was no connection state -
    
    
    // generate uniq id if it's not created     //save to DB - Not nsdefaut
    if  ([self MY_ID]==nil ||
        [[self MY_ID] isEqualToString:@""])
    {
        NSString *s = [cfg GENERATE_ME_UNIQID];
        [Combinations saveNSDEFAULTS_String:s forKey:kUSER_UNIQE_IDE];
    }
    
    //begin server check for time
    if ([self canDisplayAD]) {
        [self CHECKFORBONUS_SS];
            [self changeSpecialBonusStateTo:state_canTakeBonus];
        
        // [self changeSpecialBonusStateTo:state_canTakeBonus];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                [self changeSpecialBonusStateTo:state_canTakeBonus];
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                [self changeSpecialBonusStateTo:state_canTakeBonus];
            }
            
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                    [self changeSpecialBonusStateTo:state_canTakeBonus];
            
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
               
                    [self changeSpecialBonusStateTo:state_canTakeBonus];
               
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                [self changeSpecialBonusStateTo:state_canTakeBonus];
                
            }
        });
        

    }
        [self updateBonusLabel];
    
    
    
}

-(NSString*)MY_ID{
    
    return [Combinations getNSDEFAULTS_String:kUSER_UNIQE_IDE];
    
}

-(void)CHECKFORBONUS_SS{
    
    return;
    
    __block NSString *timleftState = nil;
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           // NSLog(@"loading bonus time from server...");
            
        });
  
        
        NSString *uniqid = [self MY_ID];
      //  NSLog(@"Uniq id was created : %@",uniqid);
        
        timleftState = [cfg SS_CHECK_BONUSTIMEFOR:uniqid];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            //NSLog(@"FINISHED SERVER time left %@",timleftState);
            
            if ([timleftState integerValue]==0 && timleftState != nil){
                //enalbe buttons press etc;
                [self changeSpecialBonusStateTo:state_canTakeBonus];
                
            }
            else if ([timleftState integerValue] > 0 && timleftState != nil){
                timeLeft = [timleftState integerValue];
                [self changeSpecialBonusStateTo:state_waitingForbonus];
                [self schedule:@selector(specialBonusTimeUpdate:) interval:1.f];
            }
            else{
             //   NSLog(@"error !");
                [self changeSpecialBonusStateTo:state_connectionError];
                [self UPDATE_ME];
            }

        });
        
    });
  

    
}
-(int) updateTimeLeftStillNextAddInSeconds{
    NSDate* now = [NSDate date];
    NSDate* lastAdWatched = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdWatchedDate"];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:lastAdWatched];
    
    if (secondsBetween>[minutesBetweenAds integerValue]*60) {
        secondsBetween = 0;
    }
    
    return secondsBetween;
}
-(BOOL) canDisplayAD{
    NSDate* now = [NSDate date];
    NSDate* lastAdWatched = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdWatchedDate"];
    if (!lastAdWatched)
    {
        return  YES;
    }
    //NSComparisonResult result = [now compare:lastAdWatched];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:lastAdWatched];
    if (secondsBetween > [minutesBetweenAds integerValue]*60 /* && result == NSOrderedDescending*/) {
        return YES;
    }
    return NO;
    
}
-(NSString*) getTimeLeftStillNextAddString{
    int rawseconds = ([minutesBetweenAds integerValue]*60)-[self updateTimeLeftStillNextAddInSeconds];
    
    [self scheduleNotificationWithTimeInterval:rawseconds text:localNotificationText];
    
    int hours = rawseconds / 3600;
    int minutes = (rawseconds-(hours*3600)) / 60;
    int seconds = rawseconds - ((hours*3600)+(minutes*60));
    
    return [NSString stringWithFormat:@"%i:%i:%i",hours,minutes,seconds];
}
-(void) updateBonusLabel{
    if(![self canDisplayAD]){
    
        progress_line.opacity = 0;
        Coina.visible = NO;
        [button setDisplayFrame:Btn_notActive];
        [button stopActionByTag:kbuttonBlinkActionTag];
    [TIME_LEFT_LABEL setString:[self getTimeLeftStillNextAddString]];
    }else{
        if ([self canDisplayAD]) {
                [self changeSpecialBonusStateTo:state_canTakeBonus];
            
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateBonusLabel];
    });
}

-(void)GET_BONUS_SS{
    
    float oldscale = progress_line.scaleX;

    progress_line.scaleX = 0;

    if (![Combinations connectedToInternet]) {
      //  NSLog(@"Warning! Could not get bonus - check internet connection");
        return;
    }
    
    __block BOOL gavedBonus = NO;
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self changeSpecialBonusStateTo:state_connecting];
            
         //   NSLog(@"loading geting bonus...");
            // MUST SHOW LOADING HERE
            
        });
        
        gavedBonus = [cfg SS_TAKE_BONUS_FOR:[self MY_ID]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (gavedBonus) {
               // NSLog(@"Successfully gaved the bonus!  Reset all special bonus window settings");
                [self changeSpecialBonusStateTo:state_waitingForbonus];
                
                timeLeft = kFullWaiTime;
                [self specialBonusTimeUpdate:0.1f];
                
                [self unschedule:@selector(specialBonusTimeUpdate:)];
                [self schedule:@selector(specialBonusTimeUpdate:) interval:1.f];
                
                //save push
                
                [self saveLocalPushSettings];
                
                //
                    //GIVE COINS HERE
                //
                
                
            }
            else if (!gavedBonus){
               // NSLog(@"Error getting bonus");
                [self UPDATE_ME];
            }
            
            
        });
        
    });

}

-(void)changeSpecialBonusStateTo:(int)state_{
  
    [button stopActionByTag:kbuttonBlinkActionTag];
    
    TIME_LEFT_LABEL.position = grille.position;
      Coina.visible = YES;
    if (state_ == state_notconnected){
        progress_line.opacity = 50;
        progress_line.scaleX = 0;
        [self unschedule:@selector(specialBonusTimeUpdate:)];
        TIME_LEFT_LABEL.visible = NO;
        NO_CONNECTION_LABEL.visible = YES;
        // must show not connected to internet itp
    }
    
        else if(state_ == state_connected){
            progress_line.opacity = 255;
            NO_CONNECTION_LABEL.visible = NO;
            progress_line.opacity = 50;
            progress_line.scaleX = 0;
            [TIME_LEFT_LABEL setString:@"Connecting..."];
        }
    
    if (state_ == state_waitingForbonus){
        canTouch = NO;
        progress_line.opacity = 255;
        [TIME_LEFT_LABEL setString:@"Not available"];
        //Coin.visible = NO;
        button.opacity = 100;
        TIME_LEFT_LABEL.visible = YES;
        NO_CONNECTION_LABEL.visible = NO;
        
    }
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"scheduledLocalNotif"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        canTouch = YES;
        progress_line.opacity = 255;
        button.opacity = 255;
        progress_line.scaleX = 1;
        TIME_LEFT_LABEL.visible = YES;
        Coina.visible = YES;
        TIME_LEFT_LABEL.position = ccp(grille.position.x + grille.contentSize.width*(IS_IPAD ? 0.1f : 0.2f), grille.position.y);
        [TIME_LEFT_LABEL setString:[NSString stringWithFormat:@"%i",coins]];
        NO_CONNECTION_LABEL.visible = NO;
        [self unschedule:@selector(specialBonusTimeUpdate:)];
        [self getBonusButtonEffect];
    }
    
    
    
}

-(void)saveLocalPushSettings{
    
    NSDate *now =[NSDate date];
    now = [now dateByAddingTimeInterval:kFullWaiTime];
    
    [self setLocalPush:now  withText:kPushText value:@"Yes" forKey:@"id_local"];

}

-(void)setLocalPush:(NSDate*)date withText:(NSString*)text_ value:(NSString*)value_ forKey:(NSString*)key_{
    
    //NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
	// Get the current date
    
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = date;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	// Notification details
    localNotif.alertBody = text_;
	// Set the action button
    localNotif.alertAction = @"View";
	
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
	
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:value_ forKey:key_];
    localNotif.userInfo = infoDict;
	
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
    app.applicationIconBadgeNumber = 0;
    
	NSLog(@"[didReceiveLocalNotification] : Recieved Notification %@",notif);
    
    NSDictionary *info = notif.userInfo;
    NSLog(@"DICT IN PUSH %@",info);
    NSString *key = [[info allKeys] objectAtIndex:0];
    NSLog(@"KEY %@",key);
    
}

-(void)specialBonusTimeUpdate:(ccTime)dt{
    
    timeLeft--;
    
    float progress = (float)((timeLeft*100)/kFullWaiTime)/100;    //(kFullWaiTime - timeLeft)/100;
    progress_line.scaleX = 1-progress;
    
    NSString *stringTime = [NSString stringWithFormat:@"%02li:%02li:%02li",
                            
                            lround(floor(timeLeft / 3600.)) % 100,
                            lround(floor(timeLeft / 60.)) % 60,
                            lround(floor(timeLeft)) % 60];
    
    [TIME_LEFT_LABEL setString:stringTime];
    
    if (timeLeft <= 0) {
        timeLeft = 0;
        [self changeSpecialBonusStateTo:state_canTakeBonus];
        [self unschedule:@selector(specialBonusTimeUpdate:)];
    }
    
}



-(void)getCoins
{
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Lobby"
                                                          action:@"Clicked get free coins (bonus coins)"
                                                           label:nil
                                                           value:nil] build]];
    [self reedemCoinReward];
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 1) {
//       // [self GET_BONUS_SS];
//        [Chartboost showRewardedVideo:CBLocationMainMenu];
//    }
}
- (void)scheduleNotificationWithTimeInterval: (NSTimeInterval)timeInterval text: (NSString*)text
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"scheduledLocalNotif"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"scheduledLocalNotif"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification *notif = [[UILocalNotification alloc] init];
        
        if ( nil == text ) {
            text = @"We've missed you!";
        }
        
        NSDate *now = [NSDate date];
        NSLog(@"now: %@",now);
        NSDate *newDate1 = [now dateByAddingTimeInterval:timeInterval];
        NSLog(@"NewDate:%@",newDate1);
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        //calendar.timeZone = [NSTimeZone localTimeZone];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:newDate1];
        
        
        NSDate *finalDate = [calendar dateFromComponents:components];
        NSLog(@"%@",finalDate);
        
        notif.fireDate = finalDate;
        notif.timeZone = [NSTimeZone defaultTimeZone];
        notif.alertBody = text;
        notif.alertAction = @"Open";
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] scheduleLocalNotification: notif];
    }
   
    
}
-(void) reedemCoinReward{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"AdWatchedDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    TopMenu *t = (TopMenu *)[_parent.parent getChildByTag:kTopMenuTAG];
    
    float coins_ = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
    float finalCoins = coins_ + coins;
    
    [DB_ updateValue:d_Coins table:d_DB_Table :finalCoins];
    
    [(Menu *)_parent.parent coinAnimation:coins];
    
    [t addCoins:coins];
    canTouch = NO;
    //Coin.opacity = 0;
    button.opacity = 100;
    [self updateBonusLabel];
}
-(void)showWheelGame{
    DailyWheelGame *WGame = [[[DailyWheelGame alloc] init_withYourBET:[DailySpinBaseAmount integerValue]] autorelease];
    WGame.anchorPoint = ccp(0.5f, 0.5f);
    WGame.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [(Menu *)_parent.parent addChild:WGame z:1000 tag:kWheelGameTAG];
}
-(void) ReedemCoins:(int)amount{
    TopMenu *t = (TopMenu *)[_parent.parent getChildByTag:kTopMenuTAG];
    
    float coins_ = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
    float finalCoins = coins_ + amount;
    
    [DB_ updateValue:d_Coins table:d_DB_Table :finalCoins];
    
    [(Menu *)_parent.parent coinAnimation:amount];
    
    [t addCoins:amount];
    canTouch = NO;
    //Coin.opacity = 0;
    //[self updateBonusLabel];
}

-(void)getBonusButtonEffect{
    
    id scale1 = [CCScaleTo actionWithDuration:0.2f scale:1.1f];
    id scaleDef = [CCScaleTo actionWithDuration:0.1f scale:1.f];
    id delay = [CCDelayTime actionWithDuration:1.f];
    id seq = [CCSequence actions:scale1,scaleDef,nil];
    id repeat = [CCSequence actions:[CCRepeat actionWithAction:seq times:2],delay, nil];
    id r = [CCRepeatForever actionWithAction:repeat];
    
    [button runAction:r].tag = kbuttonBlinkActionTag;
    
}

-(void)addTimeLeftLabel{
    
    TIME_LEFT_LABEL          = [CCLabelBMFont labelWithString:@"00:00:00" fntFile:kFONT_SPEC];
    TIME_LEFT_LABEL.position = ccp(button.position.x, SBonusLabel.position.y);//ccpAdd(button.position, ccp(0, TIME_LEFT_LABEL.boundingBox.size.height/2));
    TIME_LEFT_LABEL.color    = ccWHITE; //ccc3(69, 42, 4);
    TIME_LEFT_LABEL.scale    = (IS_IPAD) ? 0.55f : 0.65f;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        TIME_LEFT_LABEL.scale = 1.4;
    }
    [self addChild:TIME_LEFT_LABEL z:5];
    
    
    TIME_LEFT_LABEL.position = grille.position;
    
}

//

-(void) addProgress
{
    grille              = [CCSprite spriteWithSpriteFrameName:@"bonus_separator.png"];
    grille.anchorPoint  = ccp(0.5f, 0.5f);
    grille.position     = ccp(specBackground.position.x - specBackground.boundingBox.size.width*0.008f, specBackground.position.y + specBackground.boundingBox.size.height*0.34f);
    [SPEC_BONUS addChild:grille z:4];
    grille.visible = NO;
    
    progress_line              = [CCSprite spriteWithSpriteFrameName:@"bonus_progress.png"];
    progress_line.anchorPoint  = ccp(0.f, 0.5f);
    progress_line.position     = ccp(grille.position.x, grille.position.y);
    progress_line.position = ccpAdd(progress_line.position,
                                    ccp(-progress_line.boundingBox.size.width/2, 0));
    [SPEC_BONUS addChild:progress_line z:3];
    
    NO_CONNECTION_LABEL          = [CCLabelBMFont labelWithString:@"NO INTERNET CONNECTION" fntFile:kFONT_SPEC];
    if (NO_CONNECTION_LABEL) {
        SBonusLabel.scale *= 2;
    }
    NO_CONNECTION_LABEL.position = grille.position;
    NO_CONNECTION_LABEL.color    = ccWHITE; //ccc3(69, 42, 4);
    NO_CONNECTION_LABEL.scale    = 0.35f;
    [self addChild:NO_CONNECTION_LABEL z:5];
    NO_CONNECTION_LABEL.visible = NO;
    
    [self noConnectionAction];
    
}

-(void)noConnectionAction{
    
    id blinkWhite = [CCFadeTo actionWithDuration:0.2f opacity:255.f];
    id blinkDef   = [CCFadeTo actionWithDuration:0.3f opacity:150.f];
    id seq = [CCSequence actionOne:blinkWhite two:blinkDef];
    [NO_CONNECTION_LABEL runAction:[CCRepeatForever actionWithAction:seq]];
    
}

-(void) addButton
{
    button              = [CCSprite spriteWithSpriteFrameName:@"btn_get.png"];
    button.anchorPoint  = ccp(0.5f, 0.5f);
    button.position     = ccp(progress_line.position.x + progress_line.boundingBox.size.width*0.92f, progress_line.position.y);
    button.position = ccpAdd(button.position,
                                    ccp(progress_line.boundingBox.size.width/2, 0));
    [SPEC_BONUS addChild:button z:4];
}

-(void) addTxtLabel
{
    SBonusLabel          = [CCLabelBMFont labelWithString:@"GET FREE COINS" fntFile:kFONT_SPEC];
    SBonusLabel.position = ccp(specBackground.position.x, specBackground.position.y + specBackground.boundingBox.size.height*0.72f);
    SBonusLabel.position = ccpAdd(SBonusLabel.position, ccp(SBonusLabel.boundingBox.size.width*0.15f, 0));
    SBonusLabel.color    = ccBLACK; //ccc3(69, 42, 4);
    SBonusLabel.scale    = 0.8f;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        SBonusLabel.scale = 1.8;
    }

    [self addChild:SBonusLabel z:5];
}
////////////////////// TOUCHES //////////////////////////////////
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
    
    if (!canTouch) {
        return NO;
    }
    
    if (CGRectContainsPoint(button.boundingBox, touchPos))
    {
        b1 = true;
        [AUDIO playEffect:s_click1];
        [button setDisplayFrame:Btn_Active];
    }
    
    
    return YES;
}


-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (b1)
    {
        [button setDisplayFrame:Btn_notActive];
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
    
    
    if (CGRectContainsPoint(button.boundingBox, touchPos))
    {
        b1 = false;
        [button setDisplayFrame:Btn_notActive];
         //take bonus
        
        [self getCoins];
        
        
        
    }
    
    if (b1)
    {
        [button setDisplayFrame:Btn_notActive];
    }
    
   
    
}



-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_Buttons swallowsTouches:NO];
    [super onEnter];
}
-(void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}





@end
