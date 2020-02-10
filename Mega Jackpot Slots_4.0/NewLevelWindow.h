#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "cfg.h"
#import "Constants.h"

@interface NewLevelWindow : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *POPUP_IMG;
    
    CCSprite            *lvlBackground;
    CCSprite            *OKbutton;
    CCSprite            *stars;
    CCSprite            *leds;
    
    CCSpriteFrame       *Btn_Active;
    CCSpriteFrame       *Btn_notActive;
    
    CCSpriteFrame       *centerIMG1;
    CCSpriteFrame       *centerIMG2;
    
    CCLabelBMFont       *levelLabel;
    CCLabelBMFont       *levelNrLabel;
    
    CCSprite            *icon2;
    CCSprite            *icon3;
    CCSprite            *icon4;
    CCSprite            *icon5;
    CCSprite            *icon6;
    
    BOOL b1;
    BOOL isGameOver;
    bool animEnd;
    
    int LEVEL;
}

-(id)init_with_LVL:(int)level_;


@end
