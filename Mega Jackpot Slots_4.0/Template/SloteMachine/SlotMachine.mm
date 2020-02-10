#import "cfg.h"

#import "Reels.h"

#import "SCombinations.h"

#import "SlotMachine.h"

#import "ClippingNode.h"

#import "Awards.h"

#import "Lines.h"

#import "TopMenu.h"
#import "BottomMenu.h"
#import "Bet.h"

#import "WheelGame.h"
#import "CardGame.h"
#import "WinsWindow.h"
#import "NewLevelWindow.h"
#import "BigWin.h"
#import "UnlockMachineWindow.h"
#import "IDSTOREPLACE.h"
//#import "b6luxLoadingView.h"
#import <Chartboost/Chartboost.h>
#import <AppLovinSDK/AppLovinSDK.h>

#define PTM_RATIO_LH [LevelHelperLoader pointsToMeterRatio]

#define kReelTag 5
#define kSpriteSheet 555
#define kSpriteSheet_2 556
#define kSpriteSheetLines 700
#define kSpriteSheetIcons 800

#define kCoinAnimatin   675

#define kTAG_COINS_SP 850

#define kFREESPIN_LABEL 445

#define kIphoneClippingN CGRectMake (74.5,55.5,kWidthScreen-74.5,kHeightScreen-62.5)
#define kIphone5ClippingN CGRectMake (118.5,55.5,kWidthScreen-118.5,kHeightScreen-62.5)
#define kIpadClippingN CGRectMake (159,119,kWidthScreen-159,kHeightScreen-219)

@implementation SlotMachine

+(CCScene *) sceneWithMachineNr:(int)machineNumber
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SlotMachine *layer = [[[SlotMachine alloc]initWithMachineNr:machineNumber]autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) initWithMachineNr:(int)number
{
	if( (self=[super init])) {
        
      //  [DB_ updateValue:d_Exp table:d_DB_Table :14000000 *1.4f];// HACK EXPERIENCE
      //  [DB_ updateValue:d_Coins table:d_DB_Table :20000000000]; // HACK COINS
    
        machineNumber = number;
        betCount = 0;
        
        [self createBatchNode];
        [self createBG];
        // xxx -> make main game scene 
        
        CGRect rect;
        if (IS_IPAD) {rect = kIpadClippingN;}else if(IS_IPHONE_5){rect = kIphone5ClippingN;}else if(IS_IPHONE){rect = kIphoneClippingN;}
        
        lineNum = [Lines returnMaxLinesByMachine:machineNumber];
        
        Reels *reels = [[[Reels alloc]initWithFrame:rect node:self lineNumber:lineNum maxLines:lineNum]autorelease];
        
        [self addChild:reels z:5 tag:kReelTag];
        
        NSArray *bet = [Bet getBetbyLevel:kLEVEL];
        
        int betMax = [bet count];
        
        NSNumber *n = [bet objectAtIndex:betMax-1];
        
        [self topMenuType:1];
        [self bottomMenu:lineNum maxLines:lineNum bet:n.floatValue];
        [self prepareCoinsFlyAct];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2f],[CCCallFunc actionWithTarget:self selector:@selector(loadingOff)], nil]];
        
    }
	return self;
}



//-(void)openBuyCoinsWindow
//{



//}

-(void)loadingOff
{
    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
        if ([a viewWithTag:kLOADINGTAG]) {
            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
        }
    }
    
    [AUDIO playBackgroundMusic:s_music(machineNumber) loop:YES];
    AUDIO.backgroundMusicVolume = 0.35f;
    
    [self checkSound];
    
}

-(void)checkSound{
    
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
        AUDIO.backgroundMusicVolume = 0.35f;
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
        AUDIO.backgroundMusicVolume = 0.f;
    }
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
        AUDIO.effectsVolume = 1.f;
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
        AUDIO.effectsVolume = 0.f;
    }
    
}

-(void)coinAnimation:(int)coins
{
    if (coins >= 1) {
        CFA.coinsNumber = coins;
        [CFA startFlyAct];
    }
}

-(void)prepareCoinsFlyAct{
    
    CFA = [[[coinsFA alloc]init]autorelease];
    [self addChild:CFA z:999 tag:kCoinAnimatin];
    CFA.startPosition = ccp(kWidthScreen*0.5f,kHeightScreen*0.f);//kHeightScreen*0.05f);
    
    [CFA setup_];
}

-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_SloteMachine swallowsTouches:YES];
    [super onEnter];
}

-(void)digitsAnimationInLabel:(CCNode *)label from:(int)from to:(int)to
{
    for (int i = from; i <= to; i++) {
        //CCLabelTTF
    }

}

-(int)resumeMachineNum
{
    return machineNumber;
}

-(void) onExit
{
    
    
    //[self stopAllActions];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:[NSString stringWithFormat:@"bg0_%i.plist",machineNumber]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:[NSString stringWithFormat:@"bg1_%i.plist",machineNumber]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:[NSString stringWithFormat:@"icons_m_%i.plist",machineNumber]];
   
    
    //[self removeFromParentAndCleanup:NO];
    
   // [[CCTextureCache sharedTextureCache] removeAllTextures];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    //[[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    
    [super onExit];
}


- (int)MyRandomIntegerBetween:(int)min :(int)max {
    
    return ( (arc4random() % (max-min+1)) + min );
}

- (float)MyRandomFloatBetween:(int)min :(int)max {
    
    return (float)( (arc4random() % (max-min+1)) + min )/10;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  
//    Reels *r = (Reels *)[self getChildByTag:kReelTag];
//    [r spin];
    
    
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
-(void)createBatchNode
{
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGB565];
    CCSpriteBatchNode *bg0 = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"bg0_%i.pvr.ccz",machineNumber]];
    [self addChild:bg0 z:0 tag:kSpriteSheet];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"bg0_%i.plist",machineNumber]];
    
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    CCSpriteBatchNode *bg1 = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"bg1_%i.pvr.ccz",machineNumber]];
    [self addChild:bg1 z:7 tag:kSpriteSheet_2];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"bg1_%i.plist",machineNumber]];
    
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    CCSpriteBatchNode *coins = [CCSpriteBatchNode batchNodeWithFile:@"coins.pvr.ccz"];
    [self addChild:coins z:9 tag:kTAG_COINS_SP];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"coins.plist"];
    
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    //CCSpriteBatchNode *icons = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"icons_m_%i.pvr.ccz",machineNumber]];
   // [self addChild:icons z:20 tag:kSpriteSheetIcons];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"icons_m_%i.plist",machineNumber]];
    
     [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BigWin.plist"];

    
}
-(void)bigWinClose
{
    [self reorderChild:[self getChildByTag:kCoinAnimatin] z:999];
    CFA.startPosition = ccp(kWidthScreen/2, 0);
}


-(void)bigWinCoins:(float)award
{
    
    [AUDIO playEffect:s_bigwinflyin];
    
    CFA.startPosition = ccp(kWidthScreen/2, kHeightScreen*0.13f);
    
    BigWin *bigWin = [[[BigWin alloc]init]autorelease];
    bigWin.anchorPoint = ccp(0, 0);
    bigWin.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:bigWin z:11 tag:88];
    [bigWin setUpWithAward:award];
    
    [self reorderChild:CFA z:bigWin.zOrder-1];
    
    [self winCoinAnimation];
    
}


-(void)createBG
{
    CCSprite *s = [CCSprite spriteWithSpriteFrameName:@"bg_0.png"];
    s.position = ccp(kWidthScreen/2, kHeightScreen*(IS_IPAD ? 0.435f : 0.52f));
    s.anchorPoint = ccp(0.5f, 0.5f);
    [[self getChildByTag:kSpriteSheet] addChild:s z:0 tag:kSpriteSheet];
    
    //[self addChild:[SCombinations boxWithColor:ccc4(100, 100, 100, 230) pos:ccp(s.position.x - s.contentSize.width/2, s.position.y - s.contentSize.height/2) size:s.contentSize] z:1];
    
    CCSprite *s1 = [CCSprite spriteWithSpriteFrameName:@"bg_1.png"];
    s1.position = ccp(kWidthScreen/2, kHeightScreen/2);
    s1.anchorPoint = ccp(0.5f, 0.5f);
    //s1.opacity = 0;
    [[self getChildByTag:kSpriteSheet_2] addChild:s1 z:5 tag:kSpriteSheet_2];
    
}
-(void)lineUP
{
    Reels *r = (Reels *)[self getChildByTag:kReelTag];
    [r lineUP];

}

-(void)setMaxBet
{
    NSArray *bet = [Bet getBetbyLevel:kLEVEL];
    int betMax = [bet count];
    NSNumber *a = [bet objectAtIndex:betMax-1];
    betCount = 0;
    Reels *r = (Reels *)[self getChildByTag:kReelTag];
    [r countMaxBet:a.floatValue lines:lineNum];
}

-(void)betUp
{
    betCount++;
    
    NSArray *bet = [Bet getBetbyLevel:kLEVEL];
    
    int betMax = [bet count];
    
    if (betCount == betMax+1) {
        betCount = 1;
    }
    
    NSNumber *a = [bet objectAtIndex:betCount-1];
    
    [(BottomMenu *)[self getChildByTag:kBottomMenuTAG]setBet:a.floatValue];    
    
}

-(void)removeBlackBG
{
    [self reorderChild:CFA z:999];
    
    [[self getChildByTag:kBlackBackgroundTAG] runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.2f opacity:0],[CCCallBlock actionWithBlock:^{
        [[self getChildByTag:kBlackBackgroundTAG] removeFromParentAndCleanup:YES];
    }], nil]];
}

-(void) addBlackBackground
{
    CCSprite *spr   = [CCSprite node];
    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
    spr.opacity     = 0;
    spr.anchorPoint = ccp(0, 0);
    spr.color       = ccc3(255,255,255);
    [self addChild:spr z:13 tag:kBlackBackgroundTAG];
    
    [spr runAction:[CCFadeTo actionWithDuration:0.2 opacity:100]];
}
-(void)levelupClose
{
    [self removeBlackBG];

    if (unlockM) {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self selector:@selector(unlockMachine)], nil]];
        unlockM = false;
    }
    else
    {
        //[self coinAnimation:300];
        [self showWin:300 type:3];
    }
}

-(void)levelUp:(int)lvl levelup:(bool)bool_
{
    unlockM = bool_;
    
    [self addBlackBackground];
    NewLevelWindow *NWindow = [[[NewLevelWindow alloc] init_with_LVL:lvl] autorelease];
    NWindow.anchorPoint = ccp(0.5f, 0.5f);
    NWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:NWindow z:14 tag:kNewWindowTAG];

}

-(void)unlockMachine
{
    
    UnlockMachineWindow *u = [[[UnlockMachineWindow alloc]init_with_MN:[Exp checkMachineN:kLEVEL]]autorelease];
    [self addBlackBackground];
    u.anchorPoint = ccp(0.5f, 0.5f);
    u.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:u z:14 tag:kNewWindowTAG];

}

-(void)stopSpinning
{
     //[Chartboost showInterstitial:CBLocationGameOver];
    
    Reels *r = (Reels *)[self getChildByTag:kReelTag];
    if ([r checkAutoSpin]) {
        [r setAutoSpin:NO];
    }
    [r stopAllReels];
   
}

-(void)spin
{
    if  ([ApplovinAddAtGameOverandMenu isEqual:@YES]){
        [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToAdApplovin"]+1 forKey:@"spinsToAdApplovin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //NSLog(@"Act Spins: %i. Spins needed to show ad:%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"spinToAdd"],spinsToAd.integerValue);
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToAdApplovin"] >= spinsToAdApplovin.integerValue) {
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"spinsToAdApplovin"];
            if([ALInterstitialAd isReadyForDisplay]){
                [ALInterstitialAd show];
                NSLog(@"AD SHOW (APPLOVIN)");
            }
            else{
                NSLog(@"AD NOT READY, SO CAN'T SHOW");
                // No interstitial ad is currently available.  Perform failover logic...
            }
        
        }
    }
    if  ([ChartboostAddAtGameOverandMenu isEqual:@YES]){
        [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToAdChartboost"]+1 forKey:@"spinsToAdChartboost"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //NSLog(@"Act Spins: %i. Spins needed to show ad:%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"spinToAdd"],spinsToAd.integerValue);
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToAdChartboost"] >= spinsToAdChartboost.integerValue) {
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"spinsToAdChartboost"];
            [Chartboost showInterstitial:CBLocationGameOver];
            [Chartboost cacheInterstitial:CBLocationGameOver];
        }
    }
    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToInHouse"]+1 forKey:@"spinsToInHouse"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToInHouse"] > ((NSNumber*)[spinsToShowAD lastObject]).integerValue) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"spinsToInHouse"];
    }
    //NSLog(@"Act Spins: %i. Spins needed to show ad:%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"spinToAdd"],spinsToAd.integerValue);
    NSLog(@"********* Actual Spins: %li....", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToInHouse"]);
    if ([spinsToShowAD containsObject:[NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"spinsToInHouse"]]]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"showedAdsInCycle"]+1 forKey:@"showedAdsInCycle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"showedAdsInCycle"] >= spinsToShowAD.count) {
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"spinsToInHouse"];
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"showedAdsInCycle"];
        }
        [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:2];
        
        
    }

    Reels *r = (Reels *)[self getChildByTag:kReelTag];
    
    [r spin];
    
    //[self openMiniGame:kCardGame_];
    
   // [self bigWinCoins:7];
    //[self unlockMachine];
    
    if ([[self getChildByTag:kTAG_COINS_SP]getChildByTag:1].position.y > 0 ) {
        
    }
}

///////////////////////////////////////////////////////////
-(void)topMenuType:(int) menuType
{
    float coins_  = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
    int exp_    = [DB_ getValueBy:d_Exp table:d_DB_Table];
    
    //NSLog(@"COINS:   %i",coins_);
    
    TopMenu *TMenu = [[[TopMenu alloc] initWithRect:CGRectMake(0, kHeightScreen * 0.8f, kWidthScreen, kHeightScreen * 0.2f) type:menuType experience:exp_ coins:coins_] autorelease];
    
    TMenu.anchorPoint   = ccp(0,0);
    TMenu.position      = ccp(0, 0);
    [self addChild:TMenu z:9 tag:kTopMenuTAG];
    
    //[TMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.8f position:ccp(0, 0)] rate:3]];
    
}

-(void)winCoinAnimation
{
    if ([[[self getChildByTag:kTAG_COINS_SP]getChildByTag:1] getActionByTag:111]) {
        return;
    }
    
    
    
    CCSprite *s = [CCSprite spriteWithSpriteFrameName:@"pot_.png"];
    s.anchorPoint = ccp(0.5f, 0.5f);
    s.position = ccp(kWidthScreen/2, -s.contentSize.height);
    
    if (![[self getChildByTag:kTAG_COINS_SP]getChildByTag:1]) {
        
        [[self getChildByTag:kTAG_COINS_SP]addChild:s z:1 tag:1];//add pot

        for(int i = 0;i<3;i++)
        {
            CCSprite *ss = [CCSprite spriteWithSpriteFrameName:@"coins_.png"];
            ss.anchorPoint = ccp(0.5f, 0.5f);
            switch (i) {
                case 0: ss.position = ccp(s.contentSize.width*0.3, s.contentSize.height*0.85f);break;
                case 1: ss.position = ccp(s.contentSize.width*0.5f, s.contentSize.height*0.8f);break;
                case 2: ss.position = ccp(s.contentSize.width*0.7f, s.contentSize.height*0.85f);break;
                default:break;
            }
            [[[self getChildByTag:kTAG_COINS_SP] getChildByTag:1] addChild:ss z:i tag:i];//add coins
            
        }
        for (int i = 0; i<7; i++) {
            CCSprite *ss = [CCSprite spriteWithSpriteFrameName:@"coin_.png"];
            ss.anchorPoint = ccp(0.5f, 0.5f);
            switch (i) {
                case 0:ss.rotation = 80;ss.position = ccp(s.contentSize.width*0.25, s.contentSize.height*0.8f);break;
                case 1:ss.rotation = 60; ss.position = ccp(s.contentSize.width*0.32, s.contentSize.height*0.83f);break;
                case 2:ss.rotation = 70; ss.position = ccp(s.contentSize.width*0.5, s.contentSize.height*0.85f);break;
                case 3:ss.rotation = 50; ss.position = ccp(s.contentSize.width*0.65, s.contentSize.height*0.78f);break;
                case 4:ss.rotation = 90; ss.position = ccp(s.contentSize.width*0.8, s.contentSize.height*0.82f);break;
                case 5:ss.rotation = 80; ss.position = ccp(s.contentSize.width*0.2, s.contentSize.height*0.85f);break;
                case 6:ss.rotation = 90; ss.position = ccp(s.contentSize.width*0.9, s.contentSize.height*0.81f);break;
                default:break;
            }
            [[[self getChildByTag:kTAG_COINS_SP] getChildByTag:1] addChild:ss z:10+i tag:10+ i];//add little coins
        }
    }
    
    id moveFULL = [CCMoveTo actionWithDuration:0.3f position:ccp(kWidthScreen/2, (s.contentSize.height*0.2f))];
    
    id moveDOWN = [CCMoveTo actionWithDuration:0.3f position:ccp(kWidthScreen/2, -s.contentSize.height)];
    id easeMoveFULL = [CCEaseIn actionWithAction:moveFULL rate:2.5f];
    
    //id moveHALF = [CCMoveBy actionWithDuration:0.1f position:ccp(0, -s.contentSize.height*0.15f)];
    //id easeMoveHALF = [CCEaseInOut actionWithAction:moveHALF rate:1.0f];
    
    id delay = [CCDelayTime actionWithDuration:2.f];
    
    id sequance = [CCSequence actions:easeMoveFULL,delay,moveDOWN, nil];
    
    
    
    [[[self getChildByTag:kTAG_COINS_SP] getChildByTag:1] runAction:sequance].tag = 111;//pot action
    
    //////////BIG COINS JUMP
    for (int i = 0; i<3; i++) {
        float dl = 0;
        switch (i) {
            case 0:dl = 0.26f;break;
            case 1:dl = 0.31f; break;
            case 2:dl = 0.29f;break;
            default:break;
        }
        CCSprite *ss = (CCSprite *)[[[self getChildByTag:kTAG_COINS_SP] getChildByTag:1] getChildByTag:i];
        
        id coinsMove = [CCMoveBy actionWithDuration:0.1f position:ccp(0, ss.contentSize.height*0.25f)];
        
        [ss runAction:[CCSequence actions:[CCDelayTime actionWithDuration:dl],coinsMove,[coinsMove reverse], nil]];
    }
    
    /////////COINS HALF JUMP////////
    for (int i = 0; i<7; i++) {
        float dl = 0;
      
        CCSprite *ss = (CCSprite *)[[[self getChildByTag:kTAG_COINS_SP] getChildByTag:1] getChildByTag:10+i];
        
        switch (i) {
            case 0:dl = 0.29f;break;
            case 1:dl = 0.28f;break;
            case 2:dl = 0.31f;break;
            case 3:dl = 0.33f;break;
            case 4:dl = 0.31f;break;
            case 5:dl = 0.33f;break;
            case 6:dl = 0.29f;break;
            default:break;
        }
        
        id coinsMove = [CCMoveBy actionWithDuration:0.12f position:ccp(0, ss.contentSize.height*0.3f)];
        id easeMove  = [CCEaseInOut actionWithAction:coinsMove rate:0.4f];
        
        [ss runAction:[CCSequence actions:[CCDelayTime actionWithDuration:dl],easeMove,[easeMove reverse], nil]];

    }
    
    ///////DROP COINS///////
    for (int i = 4; i<7; i++) {
        
        float dl = 0;
        CGPoint p;
        float height = 0;
        float rt = 0;
        
        CCSprite *ss = (CCSprite *)[[[self getChildByTag:kTAG_COINS_SP] getChildByTag:1] getChildByTag:10+i];
        
        switch (i) {
            case 4: dl = 0.31f; rt = 110; p = ccp(ss.position.x+ss.contentSize.width*3.8f, -ss.contentSize.height*1.2f);height = IS_IPAD ? 110 : 50;break;
            case 5: dl = 0.30f; rt = -80; p = ccp(ss.position.x-ss.contentSize.width*3.5f, -ss.contentSize.height*1.2f);height = IS_IPAD ? 100 : 45;break;
            case 6: dl = 0.32f; rt = 80; p = ccp(ss.position.x+ss.contentSize.width*4.0f, -ss.contentSize.height*1.2f);height = IS_IPAD ? 110 : 50;break;
            default:break;
        }
        
        id rotate = [CCRotateBy actionWithDuration:0.5f angle:rt];
        id jump = [CCJumpTo actionWithDuration:0.5f position:p height:height jumps:1];
        id easeJump = [CCEaseIn actionWithAction:jump rate:2.f];
        id spawn = [CCSpawn actions:easeJump,rotate, nil];
        
        [ss runAction:[CCSequence actions:[CCDelayTime actionWithDuration:dl],spawn,[CCDelayTime actionWithDuration:1.7f],[CCCallBlock actionWithBlock:^{
            switch (i) {
                case 4:ss.rotation = 90;ss.position = ccp(s.contentSize.width*0.8, s.contentSize.height*0.82f);break;
                case 5:ss.rotation = 80;ss.position = ccp(s.contentSize.width*0.2, s.contentSize.height*0.85f);break;
                case 6:ss.rotation = 90;ss.position = ccp(s.contentSize.width*0.9, s.contentSize.height*0.81f);break;
            }
        }], nil]];
    }
}

-(void)boostEnabled:(int)boost
{
    Reels *r = (Reels *)[self getChildByTag:kReelTag];
    [r boostEnabled:boost];
}


-(void)setLabelOfFreeSpins:(NSString *)str_
{
    CCLabelBMFont *label = [CCLabelBMFont labelWithString:str_ fntFile:IS_IPAD ? kFONT_FREESPIN__ : kFREESPIN_FNT];
    label.anchorPoint  = ccp(0.5f, 0.5f);
    label.rotation = 30;
    label.opacity  = 0;
    //label.scale = ([Combinations isRetina]) ? 1.0f : 0.5f;
    label.position = ccp(kWidthScreen/2, kHeightScreen/2);
    if (IS_IPAD) {
        label.position = ccp(kWidthScreen/2, kHeightScreen*0.43f);
    }
    label.color    = ccc3(233, 192, 0);
    [label runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.8f opacity:255],[CCDelayTime actionWithDuration:0.4f],[CCFadeTo actionWithDuration:0.8f opacity:0], nil]];
    if (IS_STANDARD_IPHONE_6_PLUS) {
        label.scale = 1.6;
    }
    [self addChild:label z:10 tag:kFREESPIN_LABEL];
    
}
-(void)setAutoSpin:(bool)bool_
{
    Reels *r = (Reels *)[self getChildByTag:kReelTag];
    [r setAutoSpin:bool_];
}

-(void)openMiniGame:(NSString *)miniGame
{
    if (![miniGame isEqualToString:kCardGame_] && ![miniGame isEqualToString:kWheelGame_]) {
        return;
    }
    
    if ([miniGame isEqualToString:kCardGame_]) {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Minigames"
                                                              action:@"User spinned Card Game"
                                                               label:nil
                                                               value:nil] build]];
        CardGame *WGame = [[[CardGame alloc] init_withYourBET:[(BottomMenu *)[self getChildByTag:kBottomMenuTAG] getTotalBet]] autorelease];
        WGame.anchorPoint = ccp(0.5f, 0.5f);
        WGame.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:WGame z:1000 tag:kCardGameTAG];
    }
    else if ([miniGame isEqualToString:kWheelGame_]){
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Minigames"
                                                              action:@"User spinned Wheel Game"
                                                               label:nil
                                                               value:nil] build]];
        WheelGame *WGame = [[[WheelGame alloc] init_withYourBET:[(BottomMenu *)[self getChildByTag:kBottomMenuTAG] getTotalBet]] autorelease];
        WGame.anchorPoint = ccp(0.5f, 0.5f);
        WGame.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:WGame z:1000 tag:kWheelGameTAG];
    }
    
}

-(void) closeWheelGame
{
    if ([self getChildByTag:kWheelGameTAG]) {
        Reels *r = (Reels *)[self getChildByTag:kReelTag];
        [r minigameIsClosed];
        [[self getChildByTag:kWheelGameTAG] removeFromParentAndCleanup:YES];
    }
}

-(void)coinDropAnimation
{
    for (int i = 0; i <20; i++) {
        CCSprite *s     = [CCSprite spriteWithSpriteFrameName:@"coin_.png"];
        s.anchorPoint   = ccp(0.5f, 0.5f);
        s.opacity       = 0;
        s.position      = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:s z:99];
        
        float d = [self MyRandomFloatBetween:1 :5];
        
        id delay = [CCDelayTime actionWithDuration:d];
        id jump  = [CCJumpTo actionWithDuration:0.4f position:ccp(kWidthScreen*0.3f, kHeightScreen) height:([self MyRandomIntegerBetween:-50 :50] + [self MyRandomIntegerBetween:-50 :50]) jumps:1];
        id easeJump = [CCEaseInOut actionWithAction:jump rate:1.5f];
        id fadeOut  = [CCFadeTo actionWithDuration:0.1 opacity:255];
        id fadeIn   = [CCFadeTo actionWithDuration:0.1f opacity:0];
        id sp        = [CCSpawn actions:easeJump,fadeOut, nil];
        id sequence1 = [CCSequence actions:delay,sp,fadeIn, nil];
        id scaleOut  = [CCScaleTo actionWithDuration:0.2f scale:1.5f];
        id scaleIn   = [CCScaleTo actionWithDuration:0.2f scale:1.0f];
        id sequence2 = [CCSequence actions:delay,scaleOut,scaleIn, nil];
        id spawn = [CCSpawn actions:sequence1,sequence2, nil];
        
        [s runAction:spawn];
    }
}

-(void) closeCardGame
{
    if ([self getChildByTag:kCardGameTAG]) {
        Reels *r = (Reels *)[self getChildByTag:kReelTag];
        [r minigameIsClosed];
        [[self getChildByTag:kCardGameTAG] removeFromParentAndCleanup:YES];
    }
}


-(void)showWin:(int)win type:(int)type_
{
    //board with win
    
    [AUDIO playEffect:s_winicon2];
    
    [self addBlackBackground];
    
    [self reorderChild:CFA z:14];
    
    WinsWindow *WWindow = [[[WinsWindow alloc] init_with_WIN:win type:type_] autorelease];
    WWindow.anchorPoint = ccp(0.5f, 0.5f);
    WWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:WWindow z:15 tag:kWinWindowTAG];

}
-(void)bottomMenu:(int)lines maxLines:(int)maxLines bet:(float)bet
{
    if (![self getChildByTag:kBottomMenuTAG]) {
        
        BottomMenu *BMenu = [[[BottomMenu alloc]initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen * 0.2f) type:1 lines:lines maxLines:maxLines Bet:bet] autorelease];
        
        BMenu.anchorPoint = ccp(0.5f, 0);
        BMenu.position = ccp(kWidthScreen/2, 0);
        [self addChild:BMenu z:8 tag:kBottomMenuTAG];
        
        //[BMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:1.0f position:ccp(kWidthScreen/2, 0)] rate:3]];
        
        [BMenu setLines:lineNum];
        [BMenu setMaxLines:lineNum];
    }
}

///////////////////////////////////////////////////////////

-(void) dealloc
{
    //[res release];
	[super dealloc];
}

@end
