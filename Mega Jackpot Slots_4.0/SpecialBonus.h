#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum states_{
    
    state_connected         = 1,
    state_notconnected      = 2,
    state_canTakeBonus      = 3,
    state_waitingForbonus   = 4,
    state_connectionError   = 5,
    state_connecting        = 6,
    
};

@interface SpecialBonus : CCSprite <CCTouchOneByOneDelegate, UIAlertViewDelegate>
{
 
    CCSpriteBatchNode   *SPEC_BONUS;
    
    int coins;
    
    CCSprite *Coina;
    
    CCSprite            *specBackground;
    CCSprite            *grille;
    CCSprite            *progress_line;
    CCSprite            *button;
    
    CCLabelBMFont       *SBonusLabel;
    
    CCSpriteFrame *Btn_Active;
    CCSpriteFrame *Btn_notActive;
    
    BOOL b1;
}

-(id)initWithRect:(CGRect)rect kProgress:(int)progress_ bonusValue:(int)bonus_;

-(void) reedemCoinReward;
-(void) ReedemCoins:(int)amount;
//custom
-(void)showWheelGame;
-(void)UPDATE_ME;
-(void) updateBonusLabel;

@end
