//
//  BigWin.m
//  Template
//
//  Created by Slavian on 2013-10-28.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "BigWin.h"
#import "Reels.h"
#import "SlotMachine.h"
#import "cfg.h"

#define kBlackBackgroundTAG_ 100

@implementation BigWin

-(id)init
{
    if((self = [super init]))
    {
        counter = 0;
    }
    
    return self;
}
-(void)setUpWithAward:(float)award
{
    //[self addBlackBackground];
    
    award_ = award;
    
    [AUDIO playEffect:s_bigWin];
    
    CCSprite *bigwin_bg = [CCSprite spriteWithSpriteFrameName:@"bigwin_bg.png"];
    bigwin_bg.anchorPoint = ccp(0.5f, 0.5f);
    bigwin_bg.scale = 0.3f;
    bigwin_bg.position = ccp(0, 0);
    
    
    CCSprite *bigwin_lights = [CCSprite spriteWithSpriteFrameName:@"bigwin_lights.png"];
    bigwin_lights.anchorPoint = ccp(0.5f, 0.5f);
    bigwin_lights.position = ccp(bigwin_bg.contentSize.width/2, bigwin_bg.contentSize.height/2);
    [self addChild:bigwin_bg z:90 tag:1010];
    [bigwin_bg addChild:bigwin_lights z:2];
    
    
    CCSprite *bigwin_text = [CCSprite spriteWithSpriteFrameName:@"bigwin_text.png"];
    bigwin_text.anchorPoint = ccp(0.5f, 0.2f);
    bigwin_text.scale = 0.3f;
    bigwin_text.position = ccp(bigwin_bg.contentSize.width/2, bigwin_bg.contentSize.height/2.2f);
    [bigwin_bg addChild:bigwin_text z:6];
    
    
    [bigwin_lights runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.1f opacity:0],[CCFadeTo actionWithDuration:0.1f opacity:255], nil]]];
    
    //// SCALE EFFECT
    id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.3f];
    id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
    
    id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
    id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
    
    id scale3       = [CCScaleTo actionWithDuration:0.12f scale:1.0f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    id tint1 = [CCTintTo actionWithDuration:0.15 red:80  green:222 blue:154];
    id tint2 = [CCTintTo actionWithDuration:0.15 red:111 green:232 blue:166];
    id tint3 = [CCTintTo actionWithDuration:0.15 red:237 green:10  blue:55];
    id tint4 = [CCTintTo actionWithDuration:0.15 red:255 green:255 blue:255];
    
    //CCLabelTTF *txt = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%f",award] fontName:@"Arial" fontSize:IS_IPAD ? 50 : 19 dimensions:CGSizeMake(0, 0) hAlignment:kCCTextAlignmentCenter];
    
    CCLabelBMFont *txt = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_BIGWIN width:0 alignment:kCCTextAlignmentCenter];
    
    if (award_ > 1000000) {
        txt.scale = 0.75f;
    }
    
    txt.anchorPoint = ccp(0.5f, 0.5f);
    txt.opacity = 100;
    txt.color = ccYELLOW;
    txt.position = ccp(bigwin_bg.contentSize.width/2, bigwin_bg.contentSize.height/3.5f);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        txt.scale = 2.4;
    }
    [bigwin_bg addChild:txt z:10 tag:10];
    
    [self schedule:@selector(txtAnimation:) interval:0.05f];
    
    [txt runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCEaseInOut actionWithAction:[CCFadeTo actionWithDuration:0.5f opacity:255] rate:1.5f],[CCEaseInOut actionWithAction:[CCFadeTo actionWithDuration:0.5f opacity:100] rate:1.5f], nil]]];
    
    
    [bigwin_bg runAction:[CCSequence actions:[easeScale1 copy],[easeScale2 copy],[easeScale3 copy], nil]];
    
    float delay;
    
    for (int i = 0; i<6; i++) {
        CCSprite *s;
        switch (i) {
            case 0:
                s = [CCSprite spriteWithSpriteFrameName:@"bigwin_star0.png"];
                s.anchorPoint = ccp(0.9f, 0.1f);
                s.position = ccp(bigwin_bg.contentSize.width*0.27f, bigwin_bg.contentSize.height/1.85f);
                delay = 0.1f;
                break;
            case 1:
                s = [CCSprite spriteWithSpriteFrameName:@"bigwin_star1.png"];
                s.anchorPoint = ccp(0.9f, 0.8f);
                s.position = ccp(bigwin_bg.contentSize.width*0.27f, bigwin_bg.contentSize.height/1.85f);
                delay = 0.25f;
                break;
            case 2:
                s = [CCSprite spriteWithSpriteFrameName:@"bigwin_star2.png"];
                s.anchorPoint = ccp(0.9f, 0.9f);
                s.position = ccp(bigwin_bg.contentSize.width*0.27f, bigwin_bg.contentSize.height/2.f);
                delay = 0.15f;
                break;
            case 3:
                s = [CCSprite spriteWithSpriteFrameName:@"bigwin_star0.png"];
                s.anchorPoint = ccp(0.1f, 0.1f);
                s.flipX = YES; s.position = ccp(bigwin_bg.contentSize.width*0.73f, bigwin_bg.contentSize.height/1.85f);
                delay = 0.15f;
                break;
            case 4:
                s = [CCSprite spriteWithSpriteFrameName:@"bigwin_star1.png"];
                s.anchorPoint = ccp(0.1f, 0.8f);
                s.flipX = YES; s.position = ccp(bigwin_bg.contentSize.width*0.73f, bigwin_bg.contentSize.height/1.85f);
                delay = 0.1f;
                break;
            case 5:
                s = [CCSprite spriteWithSpriteFrameName:@"bigwin_star2.png"];
                s.anchorPoint = ccp(0.1f, 0.9f);
                s.flipX = YES; s.position = ccp(bigwin_bg.contentSize.width*0.73f, bigwin_bg.contentSize.height/1.85f);
                delay = 0.2f;
                break;
            default:
                break;
        }
        
        s.scale = 0.2f;
        
        [s runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:delay+0.09f],
          [CCSequence actions:
           [easeScale1 copy],
           [easeScale2 copy],
           [easeScale3 copy],
           [CCCallBlock actionWithBlock:^{
              [s runAction:[CCRepeatForever actionWithAction:
                            [CCSpawn actions:
                             [CCSequence actions:
                              [tint1 copy],
                              [tint2 copy],
                              [tint3 copy],
                              [tint4 copy], nil],
                             [CCSequence actions:
                              [CCEaseInOut actionWithAction:
                               [CCScaleTo actionWithDuration:0.5f scale:0.92f] rate:1.5f],
                              [CCEaseInOut actionWithAction:
                               [CCScaleTo actionWithDuration:0.5f scale:1.08f] rate:1.5f], nil], nil ]]].tag = 1111;
          }],
           [CCDelayTime actionWithDuration:3.f],
           [CCCallBlock actionWithBlock:^{
              [s stopActionByTag:1111];
          }],
           [CCSequence actions:
            [CCSpawn actions:[CCEaseInOut actionWithAction:
                              [CCScaleTo actionWithDuration:0.3f scale:1.5f] rate:2.f],[CCCallBlock actionWithBlock:^{
               [bigwin_bg runAction:[CCEaseInOut actionWithAction:
                                     [CCScaleTo actionWithDuration:0.3f scale:1.2f] rate:2.f]];
               [bigwin_text stopActionByTag:1100];
               [bigwin_text runAction:[CCEaseInOut actionWithAction:
                                       [CCScaleTo actionWithDuration:0.3f scale:1.35f] rate:2.f]];
           }], nil]
            ,
            [CCDelayTime actionWithDuration:0.1f],
            [CCSpawn actions:[CCEaseInOut actionWithAction:
                              [CCScaleTo actionWithDuration:0.2f scale:0.3f] rate:2.f],[CCCallBlock actionWithBlock:^{
               [bigwin_bg runAction:[CCEaseInOut actionWithAction:
                                     [CCScaleTo actionWithDuration:0.2f scale:0.3f] rate:2.f]];
               
               [bigwin_text stopActionByTag:1100];
               [bigwin_text runAction:[CCEaseInOut actionWithAction:
                                       [CCScaleTo actionWithDuration:0.2f scale:0.3f] rate:2.f]];
           }], nil],
            [CCDelayTime actionWithDuration:0.05f],
            [CCCallFunc actionWithTarget:self  selector:@selector(removeBigWin)], nil], nil], nil]];
        
        [bigwin_bg addChild:s z:5 tag:i];
        
    }
    
    [bigwin_text runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:0.09f],
      [CCSequence actions:
       [easeScale1 copy],
       [easeScale2 copy],
       [easeScale3 copy], nil],
      [CCCallBlock actionWithBlock:^{
         [bigwin_text runAction:
          [CCRepeatForever actionWithAction:
           [CCSequence actions:
            [CCEaseInOut actionWithAction:
             [CCScaleTo actionWithDuration:0.5f scale:0.97f] rate:1.5f],
            [CCEaseInOut actionWithAction:
             [CCScaleTo actionWithDuration:0.5f scale:1.03f] rate:1.5f], nil]]];
     }], nil]].tag = 1100;
    
}

-(void)txtAnimation:(ccTime)dt
{
    counter+=award_/25;
    
    NSString *numberString;
    CCLabelBMFont *l = (CCLabelBMFont *)[[self getChildByTag:1010] getChildByTag:10];
    
    if (counter < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", counter];
        [l setString:numberString];
    }
    else
    {
        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
        NSString *stringFormated = [cfg formatTo3digitsValue:counter];
        [l setString:stringFormated];
    }
    
    l.scale = 1.1;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        l.scale = 1.6;
    }
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
        l.scale = 1.0f;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            l.scale = 1.6;
        }
    }], nil]];
    
    if (counter >= award_) {
        
        if (award_ < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", award_];
            [l setString:numberString];
        }
        else
        {
            // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
            NSString *stringFormated = [cfg formatTo3digitsValue:award_];
            [l setString:stringFormated];
        }
        
        [self unschedule:@selector(txtAnimation:)];
    }

}

-(void) addBlackBackground
{
    CCSprite *spr   = [CCSprite node];
    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
    spr.opacity     = 150;
    spr.anchorPoint = ccp(0.5f, 0.5f);
    spr.color       = ccc3(255,255,255);
    [self addChild:spr z:0 tag:kBlackBackgroundTAG_];
}

-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    [super onEnter];
}

-(void)removeBlackBG
{
    [[self getChildByTag:kBlackBackgroundTAG_] runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.2f opacity:0],[CCCallBlock actionWithBlock:^{
        [[self getChildByTag:kBlackBackgroundTAG_] removeFromParentAndCleanup:YES];
    }], nil]];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

-(void)removeBigWin
{
    if (![self getChildByTag:1010]) {
        return;
    }
    [(SlotMachine *)_parent bigWinClose];
    //[self removeBlackBG];
    [(Reels *)[_parent getChildByTag:5] minigameIsClosed];//Enable spin
    [self removeFromParentAndCleanup:NO];
    
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   // CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
    return YES;
}
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
}
-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
}

@end
