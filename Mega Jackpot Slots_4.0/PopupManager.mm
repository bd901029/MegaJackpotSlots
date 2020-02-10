#import "PopupManager.h"
#import "cfg.h"
#import "Constants.h"

#import "SettingsWindows.h"
#import "PayTableWindow.h"
#import "BuyCoinsWindow.h"
#import "BottomMenu.h"
#import "TopMenu.h"
#import "BuyBoostsWindow.h"
#import "WinsWindow.h"
#import "NewLevelWindow.h"
#import "SlotMachine.h"
#import "Menu.h"
#import "AppDelegate.h"
#import "FreeCoinsWindow.h"
#import "IDSTOREPLACE.h"

@implementation PopupManager




-(id)initWithRect:(CGRect)rect
{
    if((self = [super init]))
    {
        self.position       = rect.origin;
        self.contentSize    = rect.size;
    }
    
    return self;
}

-(void)setUp:(int) PopWindowNR someValue:(int)value_
{
            
            switch (PopWindowNR)
            {
                case kWindowSettings:       [self openSettingsWindow];
                    break;
                    
                case kWindowPayTable:       [self openPayTableWindow];
                    break;
                    
                case kWindowBuyCoins:       [self openBuyWindow_from:1];
                    break;
                    
                case kWindowBigWin:  
                    break;
                    
                case kWindowNewMachine:  
                    break;
                    
                case kWindowSpecialBonus:   [self openSBonusWindow];
                    break;
                    
                case kWindowNotEnoughCoins: 
                    break;
                    
                case kWindowBuyBoosts:      [self openBuyWindow_from:2];
                    break;
                    
                case kWindowWin:            [self openWinWindow_withWin:value_];
                    break;
                    
                case kWindowNewLevel:       [self openNewLvlWindow_withLVL:value_];
                    break;
                    
                default:
                    break;
            }
                   
        
    
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

//////////////////////////////////////// OPEN WINDOWS ///////////////////////////////////////////
-(void) openSettingsWindow
{
    
    if (btnPressed == false)
    {
         [AUDIO playEffect:s_click1];
        [self addBlackBackground];
        btnPressed = true;
        SettingsWindows *SWindow = [[[SettingsWindows alloc] init] autorelease];
        SWindow.anchorPoint = ccp(0.5f, 0.5f);
        SWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:SWindow z:14 tag:kSetWindowTAG];
        if ([_parent.parent isKindOfClass:[Menu class]]) {
            [SWindow setUp:2];
        }
        else if ([_parent.parent isKindOfClass:[SlotMachine class]])
        {
            [SWindow setUp:1];
        }
        
    }
    else { }
}

-(void) openPayTableWindow
{
    if (btnPressed == false)
    {
        // [AUDIO playEffect:s_click1];
        [self addBlackBackground];
        btnPressed = true;
        //NSLog(@"%@",_parent.parent);
        int machineNum = [(SlotMachine *)_parent.parent resumeMachineNum];
        PayTableWindow *PWindow = [[[PayTableWindow alloc] init_withMachineNR:machineNum] autorelease];
        PWindow.anchorPoint = ccp(0.5f, 0.5f);
        PWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:PWindow z:14 tag:kPayWindowTAG];
    }
    else { }
}
-(void) openFreeCoinsWindow
{
    if (btnPressed == false)
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Lobby"
                                                              action:@"Clicked free coins Facebook button"
                                                               label:nil
                                                               value:nil] build]];
        [self addBlackBackground];
        btnPressed = true;
        //NSLog(@"%@",_parent.parent);
        FreeCoinsWindow *PWindow = [[[FreeCoinsWindow alloc] init] autorelease];
        PWindow.anchorPoint = ccp(0.5f, 0.5f);
        PWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:PWindow z:14 tag:kFreeCoinsWindowTag];
    }
    else { }
}

-(void) openBuyWindow_from:(int)nr_
{
    if (btnPressed == false)
    {
         //[AUDIO playEffect:s_click1];
        [self addBlackBackground];
        btnPressed = true;
         BuyCoinsWindow *BWindow = [[[BuyCoinsWindow alloc] init_WithNumber:nr_] autorelease];
        BWindow.anchorPoint = ccp(0.5f, 0.5f);
        BWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        if (nr_ == 1) { [self addChild:BWindow z:16 tag:kBuyWindowTAG]; }
        if (nr_ == 2) { [self addChild:BWindow z:16 tag:kBooWindowTAG]; }
    }
    else { }
}


-(void) openWinWindow_withWin:(int)win_
{
    if (btnPressed == false)
    {
         //[AUDIO playEffect:s_click1];
        btnPressed = true;
        WinsWindow *WWindow = [[[WinsWindow alloc] init_with_WIN:win_ type:1] autorelease];
        WWindow.anchorPoint = ccp(0.5f, 0.5f);
        WWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:WWindow z:14 tag:kWinWindowTAG];
    }
    else { }
}

-(void) openNewLvlWindow_withLVL:(int)level_
{
    if (btnPressed == false)
    {
         //[AUDIO playEffect:s_click1];
        btnPressed = true;
        NewLevelWindow *NWindow = [[[NewLevelWindow alloc] init_with_LVL:level_] autorelease];
        NWindow.anchorPoint = ccp(0.5f, 0.5f);
        NWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:NWindow z:14 tag:kNewWindowTAG];
    }
    else { }
}


/////////////////////////// SPECIAL BONUS ////////////////////////
-(void) openSBonusWindow
{
    if (btnPressed == false)
    {
        btnPressed = true;
        
        BonusMenu               = [[[SpecialBonus alloc] initWithRect:CGRectMake(0, kHeightScreen * 0.2f, kWidthScreen, kHeightScreen * 0.2f) kProgress:kProgress1 bonusValue:500] autorelease];
        BonusMenu.anchorPoint   = ccp(0,0);
        BonusMenu.position      = ccp(BonusMenu.position.x, kHeightScreen - kHeightScreen*1.3f);
        [self addChild:BonusMenu z:14 tag:kSpeWindowTAG];
        
        [(AppController *)[[UIApplication sharedApplication] delegate]setSPECIALBONUS:BonusMenu];
        
         
        //[BonusMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.3f position:ccp(BonusMenu.position.x, 0)] rate:1]];
        
        [BonusMenu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.15f],[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.1f position:ccp(BonusMenu.position.x, IS_IPAD ? 30    :   15)] rate:1.5f],[CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:0.07f position:ccp(0, IS_IPAD ? -44    :   -22)] rate:1.0f],[CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:0.1f position:ccp(0, IS_IPAD ? 14    :   7)] rate:1.5f], nil]];
        
        
    }
    else { }
}


-(SpecialBonus*)GET_SPECIALBONUS{
    
    if (BonusMenu!=nil)
    {
        return BonusMenu;
    }
    NSLog(@"Warinign ! No bonus alloced");
    return nil;
    
}

-(void) hideSBonusWindow
{
    [BonusMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.5f position:ccp(BonusMenu.position.x, kHeightScreen - kHeightScreen*1.3f)] rate:1]];
}

-(void)removeBlackBG
{
    [[self getChildByTag:kBlackBackgroundTAG] runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.2f opacity:0],[CCCallBlock actionWithBlock:^{
        [[self getChildByTag:kBlackBackgroundTAG] removeFromParentAndCleanup:YES];
    }], nil]];
}
///////////////////////////////////////////////////////////////////

//////////////////////////////////////// CLOSe WINDOWS ///////////////////////////////////////////
-(void) closeSettingsWindow
{
    //[self removeBlackBG];
    [self removeChild:(SettingsWindows *)[self getChildByTag:kSetWindowTAG] cleanup:YES];
    [_parent performSelector:@selector(closeWindowSet) withObject:nil];
    btnPressed = false;
}

-(void) closePayTableWindow
{
    [self removeChild:(SettingsWindows *)[self getChildByTag:kBlackBackgroundTAG] cleanup:YES];
    [self removeChild:(PayTableWindow *)[self getChildByTag:kPayWindowTAG] cleanup:YES];
    [_parent performSelector:@selector(closeWindowPay) withObject:nil];
    btnPressed = false;
}
-(void) closeFreeCoinsWindow
{
    [self removeChild:(SettingsWindows *)[self getChildByTag:kBlackBackgroundTAG] cleanup:YES];
    [self removeChild:(PayTableWindow *)[self getChildByTag:kFreeCoinsWindowTag] cleanup:YES];
   // [_parent performSelector:@selector(closeFreeCoinsWindow) withObject:nil];
    btnPressed = false;
}

-(void) closeBuyWindow
{
    //[self removeChild:(SettingsWindows *)[self getChildByTag:kBlackBackgroundTAG] cleanup:YES];
    [self removeChild:(BuyCoinsWindow *)[self getChildByTag:kBuyWindowTAG] cleanup:YES];
    [(TopMenu *) _parent closeWindowBuy]; 

    btnPressed = false;
}

-(void) closeWinWindow
{
    [self removeChild:(PayTableWindow *)[self getChildByTag:kWinWindowTAG] cleanup:YES];
    [(TopMenu *) _parent closeWindowWin];
    btnPressed = false;
}

-(void) closeLvlWindow
{
    [self removeChild:(PayTableWindow *)[self getChildByTag:kNewWindowTAG] cleanup:YES];
    [(TopMenu *) _parent closeWindowLvl];
    btnPressed = false;
}

-(void) closeUseBoostWindow
{
    [_parent performSelector:@selector(closeBUseWindow) withObject:nil];
}








@end
