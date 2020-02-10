

#import "UnlockMachineWindow.h"
#import "cfg.h"
#import "PopupManager.h"
#import "SlotMachine.h"


@implementation UnlockMachineWindow


-(id)init_with_MN:(int)mn
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
            [AUDIO playEffect:s_unlockedMachine];
        }], nil]];
        
        
        POPUP_IMG = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_popup.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_popup.plist"]];
        [self addChild:POPUP_IMG z:12];
        lvlBackground             = [CCSprite spriteWithSpriteFrameName:@"popup_bg.png"];
        lvlBackground.anchorPoint = ccp(0.5f, 0.5f);
        lvlBackground.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [POPUP_IMG addChild:lvlBackground z:1];
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncO actionWithTarget:self selector:@selector(addMachineImage:) object:[NSNumber numberWithInt:mn]], nil]];
        
        CCSprite *s             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_unlocked.png"];
        s.anchorPoint = ccp(0.5f, 0.5f);
        s.scale = 0.1f;
        s.position    = ccp(kWidthScreen/2, kHeightScreen*0.45);
        [POPUP_IMG addChild:s z:2];
        
        [s runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3f],easeScale1,easeScale2,easeScale3, nil]];
        
        
        Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_btn_ok_active.png"]];
        Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"popup_bg_btn_ok.png"]];
        
        
        CCLabelBMFont *levelLabel             = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"NEW MACHINE!"] fntFile:kFONT_BUY_TXT];
        levelLabel.position    = ccp(lvlBackground.position.x, lvlBackground.position.y + lvlBackground.boundingBox.size.height*0.36f);
        levelLabel.color       = ccBLACK;
        [self addChild:levelLabel z:13];

        [self addButton];
        [self addLEDS];
        
        return self;
    }
}

-(void)addMachineImage:(NSNumber *)mn
{
    CCSprite *s             = [CCSprite spriteWithFile:[NSString stringWithFormat:@"icon%i.png",mn.intValue]];
    s.anchorPoint = ccp(0.5f, 0.5f);
    s.scale       = 0.1f;
    s.opacity     = 0;
    s.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:s z:13];
    
    id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.f];
    id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
    
    id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.87f];
    id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
    
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:0.9f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    [s runAction:[CCSpawn actions:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil],[CCFadeTo actionWithDuration:0.1f opacity:255], nil]];

}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
    if ((CGRectContainsPoint(OKbutton.boundingBox, touchPos)) && animEnd)
    {
        [OKbutton setDisplayFrame:Btn_Active];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self selector:@selector(closeWindow)], nil]];
    }
    
    return YES;
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{

    [OKbutton setDisplayFrame:Btn_notActive];

}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!animEnd) {
        return;
    }
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
    if (CGRectContainsPoint(OKbutton.boundingBox, touchPos))
    {
        [OKbutton setDisplayFrame:Btn_notActive];
        
    }
}

-(void)closeWindow
{
    if ([_parent isKindOfClass:[SlotMachine class]]) {
        [(SlotMachine *)_parent removeBlackBG];
        //[(SlotMachine *)_parent coinAnimation:500];
        [(SlotMachine *)_parent showWin:500 type:2];
    }
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:0.5f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    if ([_parent isKindOfClass:[PopupManager class]]) {
        [(PopupManager *)_parent removeBlackBG];
    }
    
    [self runAction:[CCSequence actions:easeScale3,[CCCallBlock actionWithBlock:^{
        [self removeFromParentAndCleanup:YES];
    }], nil]];

}

-(void) addLEDS
{
    leds             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_lights.png"];
    leds.anchorPoint = ccp(0.5f, 0.5f);
    leds.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    [POPUP_IMG addChild:leds z:3];
    [leds runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.2f opacity:0],[CCFadeTo actionWithDuration:0.2f opacity:255], nil]]];
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

-(void) addButton
{
    OKbutton             = [CCSprite spriteWithSpriteFrameName:@"popup_bg_btn_ok.png"];
    OKbutton.anchorPoint = ccp(0.5f, 0.5f);
    OKbutton.position    = ccp(lvlBackground.position.x, lvlBackground.position.y - lvlBackground.boundingBox.size.height*0.36f);
    [POPUP_IMG addChild:OKbutton z:13];
}

@end
