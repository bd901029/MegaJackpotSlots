#import "WinsWindow.h"
#import "PopupManager.h"
#import "SlotMachine.h"
#import "WheelGame.h"
#import "CardGame.h"
#import "TopMenu.h"
#import "DailyWheelGame.h"

@implementation WinsWindow



-(id)init_with_WIN:(int)win_ type:(int)type_
{
    if((self = [super init]))
    {
        _type = type_;
        animEnd = false;
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        if(type_ != 4){// if not level up and unlock machine
            
            int Allwin = [DB_ getValueBy:d_WinAllTime table:d_DB_Table];
            Allwin = Allwin + win_;
            [DB_ updateValue:d_WinAllTime table:d_DB_Table :Allwin];
        }
        
        _win = win_;
        //// SCALE EFFECT
        self.scale = 0.3f;
        id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
        id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
        
        id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
        id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
        
        id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
        id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
        
        [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3,[CCCallBlock actionWithBlock:^{
            animEnd = true;
        }], nil]];
        
        POPUP_IMG = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_popup.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_popup.plist"]];
        [self addChild:POPUP_IMG z:12];
        
        
        winBackground             = [CCSprite spriteWithSpriteFrameName:@"popup_bg.png"];
        winBackground.anchorPoint = ccp(0.5f, 0.5f);
        winBackground.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [POPUP_IMG addChild:winBackground z:1];
        
        coinsImg             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_coins.png"];
        coinsImg.anchorPoint = ccp(0.5f, 0.5f);
        coinsImg.position    = ccp(winBackground.position.x, winBackground.position.y - winBackground.boundingBox.size.height*0.18f);
        [POPUP_IMG addChild:coinsImg z:2];
        
        Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_btn_ok_active.png"]];
        Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_btn_ok.png"]];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }

        [self addButton];
        [self addWinLabel:win_];
        [self addLEDS];
       
    }
    
    return self;
}



-(void) addLEDS
{
    CCSprite * leds             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_lights.png"];
    leds.anchorPoint = ccp(0.5f, 0.5f);
    leds.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [POPUP_IMG addChild:leds z:3];
    [leds runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.2f opacity:0],[CCFadeTo actionWithDuration:0.2f opacity:255], nil]]];
}

-(void) addButton
{
    OKbutton             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_btn_ok.png"];
    OKbutton.anchorPoint = ccp(0.5f, 0.5f);
    OKbutton.position    = ccp(winBackground.position.x, winBackground.position.y - winBackground.boundingBox.size.height*0.36f);
    [self addChild:OKbutton z:13];
}

-(void) addWinLabel:(int) winValue_
{
    CCLabelBMFont * labelTxt;
    if (_type == 1 || _type == 4) {
        
        if (winValue_ > 0)  { labelTxt = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"YOU WON!"] fntFile:kFONT_BUY_TXT]; }
        else                { labelTxt = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"BETTER LUCK NEXT TIME"] fntFile:kFONT_BUY_TXT];
            labelTxt.scale = 0.9f;}
    }
    else if (_type == 2)
    {
        labelTxt = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"REWARD FOR UNLOCKED MACHINE!"] fntFile:kFONT_BUY_TXT];
        labelTxt.scale = 0.6f;
    }
    else if (_type == 3)
    {
        labelTxt = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"REWARD FOR LEVEL UP!"] fntFile:kFONT_BUY_TXT];
        
    }
    
    labelTxt.position           = ccp(winBackground.position.x, winBackground.position.y + winBackground.boundingBox.size.height*0.36f);
    labelTxt.color              = ccBLACK;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        labelTxt.scale = 1.6;
    }
    [self addChild:labelTxt z:13];
    
    

        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
    NSString *stringFormated = [cfg formatTo3digitsValue:winValue_];
    
    
    winLabel                    = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", stringFormated] fntFile:kFONT_WIN];
    winLabel.position           = ccp(kWidthScreen/2, kHeightScreen*0.55f);
    winLabel.scale              = 0.8f;
    winLabel.color              = ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        winLabel.scale = 1.6;
    }
    [self addChild:winLabel z:13];
}

////////////////////////// TOUCHES /////////////////////////////////
////////////////////////////////////////////////////////////////////
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    if ((CGRectContainsPoint(OKbutton.boundingBox, touchPos)) && animEnd)
    {
        b1 = false;
        [OKbutton setDisplayFrame:Btn_Active];
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self selector:@selector(okfunc)], nil]];
        
    }
    
    return YES;
}
-(void)okfunc
{
   // if ([_parent isKindOfClass:[WheelGame class]] || [_parent isKindOfClass:[CardGame class]]) {
        if (_win> 0) {
            float c = [DB_ getValueBy:d_Coins table:d_DB_Table];
            float finalc = c+_win;
            [DB_ updateValue:d_Coins table:d_DB_Table :finalc];

            if ([_parent isKindOfClass:[WheelGame class]] || [_parent isKindOfClass:[CardGame class]]) {
                
                TopMenu *t = (TopMenu *)[_parent.parent getChildByTag:kTopMenuTAG];
                [t addCoins:_win];
                [(SlotMachine *)_parent.parent coinAnimation:_win];
            }
            if ([_parent isKindOfClass:[DailyWheelGame class]] || [_parent isKindOfClass:[CardGame class]]) {
                
                TopMenu *t = (TopMenu *)[_parent.parent getChildByTag:kTopMenuTAG];
                [t addCoins:_win];
                [(SlotMachine *)_parent.parent coinAnimation:_win];
            }
            else if ([_parent isKindOfClass:[SlotMachine class]])
            {
                TopMenu *t = (TopMenu *)[_parent getChildByTag:kTopMenuTAG];
                [t addCoins:_win];
                [(SlotMachine *)_parent coinAnimation:_win];
            }
            [(TopMenu*)[_parent.parent getChildByTag:kTopMenuTAG] addCoins:_win];
            [(TopMenu*)[_parent.parent getChildByTag:kTopMenuTAG] addLastWin:_win];
        }
   // }
    
    [self closeWindow];

}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{

    if (b1)
    {
        [OKbutton setDisplayFrame:Btn_notActive];
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!animEnd) {
        return;
    }
    if (b1)
    {
        [OKbutton setDisplayFrame:Btn_notActive];
    }
}

////////////////////////////////////////////////////////////////////

-(void) closeWindow
{
    
    if ([_parent isKindOfClass:[WheelGame class]]) {
        [(WheelGame *)_parent exitGame];
    }
    if ([_parent isKindOfClass:[DailyWheelGame class]]) {
        [(DailyWheelGame *)_parent exitGame];
    }
    
    if ([_parent isKindOfClass:[CardGame class]]) {
        [(CardGame *)_parent exitGame];
    }
    
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:0.5f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    if ([_parent isKindOfClass:[PopupManager class]] || [_parent isKindOfClass:[SlotMachine class]]) {
        [_parent removeBlackBG];
    }
    
    [self runAction:[CCSequence actions:easeScale3,[CCCallBlock actionWithBlock:^{
        [self removeFromParentAndCleanup:YES];
    }], nil]];
}

////////////////////////////////////////////////////////////////////
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


@end
