//
//  Reels.h
//  Template
//
//  Created by Slavian on 2013-08-19.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "cocos2d.h"
#import "GameDevHelper.h"
#import "Result.h"

@interface Reels : CCSprite<CCTouchOneByOneDelegate,GHSkeletonDelegate>
{
    bool    canUpdateIcons;
    int     reelcount;
    int     lineAnimationCount;
    int     scater_bonus_anim;
    int     linesNumber;
    int     maxLines;
    float   swipeY;
    float     winCoins;
    int     i_touchCount;
    int     touchCount;
    bool    b_freespin;
    int     i_freespinC;
    bool    b_canSpin;
    int     winStatus;
    float   coins;
    float   freeSpin_WIN;
    
    bool    boost2x;
    bool    boost3x;
    bool    boost4x;
    bool    boost5x;
    
    bool    b_autoSpin;
    bool    b_bonus;
    float   spin_del;
    
    float   spinSoundStep;
    
    NSArray *elements;
    NSMutableArray *randomeElements;
    enum
    {
        STATE_SPINING,
        STATE_STOPPED,
        STATE_NORMAL
        
    }spin_state;
    
}

-(id)initWithFrame:(CGRect)frame node:(CCNode *)par lineNumber:(int)lineNum maxLines:(int)maxLines_;
-(NSArray *)getIdElement;
-(void)spin;
-(void)lineUP;
-(void)countMaxBet:(float)bet lines:(int)lines_;
-(void)stopAllReels;
-(void)setAutoSpin:(bool)bool_;
-(void)boostEnabled:(int)boostC;
-(void)minigameIsClosed;
-(void)allBoostDeactivate;
-(BOOL)checkAutoSpin;

@end
