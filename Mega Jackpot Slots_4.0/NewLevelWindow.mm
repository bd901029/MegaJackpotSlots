#import "NewLevelWindow.h"
#import "PopupManager.h"
#import "SlotMachine.h"
#import "IDsToReplace.h"

@implementation NewLevelWindow

-(id)init_with_LVL:(int)level_
{
    if((self = [super init]))
    {
        animEnd = false;
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
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
        
        
        lvlBackground             = [CCSprite spriteWithSpriteFrameName:@"popup_bg.png"];
        lvlBackground.anchorPoint = ccp(0.5f, 0.5f);
        lvlBackground.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [POPUP_IMG addChild:lvlBackground z:1];
        
        stars             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_stars.png"];
        stars.anchorPoint = ccp(0.5f, 0.5f);
        stars.scale       = 0.1f;
        stars.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [POPUP_IMG addChild:stars z:2];
        
        [stars runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.15f],[easeScale1 copy],[easeScale2 copy],[easeScale3 copy], nil]];
        
        
        Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_btn_ok_active.png"]];
        Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_btn_ok.png"]];
        
        centerIMG1                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_stars.png"]];
        centerIMG2                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_unlocked.png"]];
        
        LEVEL = level_;
        
        
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"goldWonFromLastLVL"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self addButton];
        [self addNewLevel:LEVEL];
        [self addLEDS];
        //[self loadMicons];
        
    }
    
    return self;
}

-(void) loadMicons
{
    icon2             = [CCSprite spriteWithFile:@"icon2.png"];
    icon2.anchorPoint = ccp(0.5f, 0.5f);
    icon2.scale       = 0.1f;
    icon2.opacity     = 0;
    icon2.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:icon2 z:13];
    
    icon3             = [CCSprite spriteWithFile:@"icon3.png"];
    icon3.anchorPoint = ccp(0.5f, 0.5f);
    icon3.scale       = 0.1f;
    icon3.opacity     = 0;
    icon3.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:icon3 z:13];
    
    icon4             = [CCSprite spriteWithFile:@"icon4.png"];
    icon4.anchorPoint = ccp(0.5f, 0.5f);
    icon4.scale       = 0.1f;
    icon4.opacity     = 0;
    icon4.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:icon4 z:13];
    
    icon5             = [CCSprite spriteWithFile:@"icon5.png"];
    icon5.anchorPoint = ccp(0.5f, 0.5f);
    icon5.scale       = 0.1f;
    icon5.opacity     = 0;
    icon5.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:icon5 z:13];
    
    icon6             = [CCSprite spriteWithFile:@"icon6.png"];
    icon6.anchorPoint = ccp(0.5f, 0.5f);
    icon6.scale       = 0.1f;
    icon6.opacity     = 0;
    icon6.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:icon6 z:13];
}

-(void) addLEDS
{
    leds             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_lights.png"];
    leds.anchorPoint = ccp(0.5f, 0.5f);
    leds.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [POPUP_IMG addChild:leds z:3];
    
    [leds runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.1f opacity:0],[CCFadeTo actionWithDuration:0.1f opacity:255], nil]]].tag = 4321;
}

-(void) addButton
{
    OKbutton             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_btn_ok.png"];
    OKbutton.anchorPoint = ccp(0.5f, 0.5f);
    OKbutton.position    = ccp(lvlBackground.position.x, lvlBackground.position.y - lvlBackground.boundingBox.size.height*0.36f);
    [POPUP_IMG addChild:OKbutton z:13];
}

-(void) addNewLevel:(int) lvlValue_
{
    levelLabel             = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"NEW LEVEL!"] fntFile:kFONT_BUY_TXT];
    levelLabel.position    = ccp(lvlBackground.position.x, lvlBackground.position.y + lvlBackground.boundingBox.size.height*0.36f);
    levelLabel.color       = ccBLACK;
    levelLabel.opacity     = 200;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        levelLabel.scale = 1.6;
    }
    [self addChild:levelLabel z:13];
    
    levelNrLabel           = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%d", lvlValue_] fntFile:kFONT_NLEVEL];
    levelNrLabel.position  = ccp(lvlBackground.position.x, lvlBackground.position.y);
    levelNrLabel.color     = ccBLACK;
    levelNrLabel.opacity   = 0;
    levelNrLabel.scale     = 0.8f;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        levelNrLabel.scale = 2.4;
    }
    [self addChild:levelNrLabel z:13];
    [levelNrLabel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2f],[CCFadeTo actionWithDuration:0.2f opacity:180], nil]];
}

////////////////////////// TOUCHES /////////////////////////////////
////////////////////////////////////////////////////////////////////
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
    if ((CGRectContainsPoint(OKbutton.boundingBox, touchPos)) && animEnd)
    {
        b1 = true;
        [OKbutton setDisplayFrame:Btn_Active];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self selector:@selector(closeWindow)], nil]];
    }
    
    return YES;
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
   // if (isGameOver)
   // {
    [self stopActionByTag:4321];
    [self stopAllActions];
    
    if ([_parent isKindOfClass:[SlotMachine class]]) {
        [(SlotMachine *)_parent levelupClose];
    }
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:0.5f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
        
    if ([_parent isKindOfClass:[PopupManager class]]) {
        [(PopupManager *)_parent removeBlackBG];
    }
        
    [self runAction:[CCSequence actions:easeScale3,[CCCallBlock actionWithBlock:^{
        [self removeFromParentAndCleanup:YES];
    }], nil]];
   // }

}

-(void) mAnimation_iconNR:(int)iNR_
{
    id rot     = [CCRotateBy actionWithDuration:0.4f angle: 360];
    id zoomIN  = [CCScaleTo actionWithDuration:0.4f scale:1.1f];
    id zoomOUT = [CCScaleTo actionWithDuration:0.1f scale:0.9f];
    id seq     = [CCSequence actions:zoomIN, zoomOUT, nil];
    
    switch (iNR_)
    {
        case 2: [icon2 runAction:seq]; [icon2 runAction:rot]; break;
        case 3: [icon3 runAction:seq]; [icon3 runAction:rot]; break;
        case 4: [icon4 runAction:seq]; [icon4 runAction:rot]; break;
        case 5: [icon5 runAction:seq]; [icon5 runAction:rot]; break;
        case 6: [icon6 runAction:seq]; [icon6 runAction:rot]; break;
            
        default:
            break;
    }
    
    
}

////////////////////////////////////////////////////////////////////
-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    if ([ShowAdAtLevels containsObject:[NSNumber numberWithInteger:LEVEL]]) {
        
        [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:9];
        
        
    }
    [super onEnter];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}


@end
