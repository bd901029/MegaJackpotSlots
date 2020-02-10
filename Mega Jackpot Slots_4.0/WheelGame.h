//
//  WheelGame.h
//  Template
//
//  Created by Eimio on 10/1/13.
//  Copyright 2013 bsixlux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WheelGame : CCSprite <CCTouchOneByOneDelegate>
{

    CCSpriteBatchNode *WHEEL_IMG;
    CCSpriteBatchNode *SET_IMG;
    
    CCLabelBMFont *winValue;
    CCLabelBMFont *gOverLabel;
    
    CCSpriteFrame *sButtonActive;
    CCSpriteFrame *sButtonNotActive;
    
    CCLabelBMFont *Number1;
    CCLabelBMFont *Number2;
    CCLabelBMFont *Number3;
    CCLabelBMFont *Number4;
    CCLabelBMFont *Number5;
    CCLabelBMFont *Number6;
    CCLabelBMFont *Number7;
    CCLabelBMFont *Number8;
    CCLabelBMFont *Number9;
    CCLabelBMFont *Number10;
    CCLabelBMFont *Number11;
    CCLabelBMFont *Number12;
    
    CCLabelBMFont *spinsLeft;

    CCSprite    *imgWheel;
    CCSprite    *wheelLights;
    CCSprite    *spinButton;
    CCSprite    *spinPointer;
    CCSprite    *pointerActive;
    CCSprite    *background;
    CCSprite    *winText;
    CCSprite    *closeBtn;
    
    CCRepeatForever *repeat;
    CCRepeatForever *repeat2;
    CCRepeatForever *repeat3;
    CCRepeatForever *repeat4;

    int         finalWin;
    int         rndSpeed;
    int         times;
    int         xTimes;
    
    
    float       spinRotation;
    float       v_;
    
    id          startSpinAction;
    
    BOOL        startSpinning;
    BOOL        rndGet;
    BOOL        doubleWin1;
    BOOL        doubleWin2;
    BOOL        doubleWin3;
    BOOL        animGo;
    BOOL        isSpinning;
    BOOL        gameOver;

    BOOL        iPhone3;
    
    BOOL        b1;
    
    float         BET;
    
    int         spins_ ;
    
    float       scaleNR;
    
    float spinSound;
    
}

-(id)init_withYourBET:(float)bet_;
-(void) exitGame;

@end
