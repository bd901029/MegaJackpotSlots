#import "cfg.h"
#import "Constants.h"

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BuyBoostsWindow : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *BUY_MENU_;
    CCSpriteBatchNode *SETTINGS_MENU_;
    
    CCSprite *background;
    
    CCLabelBMFont *coinsLabel;
    CCLabelBMFont *boostsLabel;
    
    CCLabelBMFont *buyLabel1;
    CCLabelBMFont *buyLabel2;
    CCLabelBMFont *buyLabel3;
    CCLabelBMFont *buyLabel4;
    
    CCSprite *closeBtn;
    CCSprite *coinsBtn;
    CCSprite *boostBtn;
    
    int fSizeBUY;
    int fSizeBUTTONS;
    
    CCSpriteFrame *closeFrame;
    CCSpriteFrame *framePressed;
    CCSpriteFrame *frameNotPressed;
    
    CCSpriteFrame *selectedBoost2x;
    CCSpriteFrame *selectedBoost3x;
    CCSpriteFrame *selectedBoost4x;
    CCSpriteFrame *selectedBoost5x;
    
    CCSpriteFrame *NOTselectedBoost2x;
    CCSpriteFrame *NOTselectedBoost3x;
    CCSpriteFrame *NOTselectedBoost4x;
    CCSpriteFrame *NOTselectedBoost5x;
    
    CCSprite *blackBG;
    
    CCSprite *selectedBG;
    
    CCSprite *brownBG1;
    CCSprite *brownBG2;
    CCSprite *brownBG3;
    CCSprite *brownBG4;
    
    CCSprite *buyButton1;
    CCSprite *buyButton2;
    CCSprite *buyButton3;
    CCSprite *buyButton4;
    
    CCSprite *buyButtonP1;
    CCSprite *buyButtonP2;
    CCSprite *buyButtonP3;
    CCSprite *buyButtonP4;
    
    CCSprite *buyBSelect1;
    CCSprite *buyBSelect2;
    CCSprite *buyBSelect3;
    CCSprite *buyBSelect4;
    
    
    CCLabelBMFont *priceLabel1;
    CCLabelBMFont *priceLabel2;
    CCLabelBMFont *priceLabel3;
    CCLabelBMFont *priceLabel4;
    
    CCLabelBMFont *boostNumber;
    CCLabelBMFont *boostNumber2;
    CCLabelBMFont *boostNumber3;
    CCLabelBMFont *boostNumber4;
    
    BOOL    BOOSTx2;
    BOOL    BOOSTx3;
    BOOL    BOOSTx4;
    BOOL    BOOSTx5;
    
    BOOL    iPhone3;
    
}
-(id)initWithBool:(bool)bool_;
-(void)purchase:(int)boostNR;
@end
