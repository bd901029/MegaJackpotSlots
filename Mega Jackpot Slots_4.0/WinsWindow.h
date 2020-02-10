#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cfg.h"
#import "Constants.h"

@interface WinsWindow : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *POPUP_IMG;
    
    CCSprite            *winBackground;
    CCSprite            *OKbutton;
    CCSprite            *coinsImg;
    CCSpriteFrame       *Btn_Active;
    CCSpriteFrame       *Btn_notActive;
    
    CCLabelBMFont       *winLabel;
    
    int _win;
    int _type;
    
    BOOL b1;
    BOOL iPhone3;
    bool animEnd;
}

-(id)init_with_WIN:(int)win_ type:(int)type_;






@end
