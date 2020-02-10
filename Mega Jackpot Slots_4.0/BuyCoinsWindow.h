
#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "cfg.h"
#import "Constants.h"

@interface BuyCoinsWindow : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *BUY_MENU_;
    CCSpriteBatchNode *SETTINGS_MENU_;
    
    CCSprite *background;
    
    CCSprite *closeBtn;
    
    CCSprite *coinsBtn;
    CCSprite *boostBtn;
    
    CCLabelBMFont *coinsLabel;
    CCLabelBMFont *boostsLabel;
    
    CCLabelBMFont *buyLabel1;
    CCLabelBMFont *buyLabel2;
    CCLabelBMFont *buyLabel3;
    CCLabelBMFont *buyLabel4;
    CCLabelBMFont *buyLabel5;
    CCLabelBMFont *buyLabel6;
    
    CCLabelBMFont *lineLabel1;
    CCLabelBMFont *lineLabel2;
    CCLabelBMFont *lineLabel3;
    CCLabelBMFont *lineLabel4;
    CCLabelBMFont *lineLabel5;
    CCLabelBMFont *lineLabel6;
    
    CCLabelBMFont *priceLabel1;
    CCLabelBMFont *priceLabel2;
    CCLabelBMFont *priceLabel3;
    CCLabelBMFont *priceLabel4;
    CCLabelBMFont *priceLabel5;
    CCLabelBMFont *priceLabel6;
    
    CCSprite *field1;
    CCSprite *field2;
    CCSprite *field3;
    CCSprite *field4;
    CCSprite *field5;
    CCSprite *field6;
    /////////////////////////////////
    CCSprite *coinIco1;
    CCSprite *coinIco2;
    CCSprite *coinIco3;
    CCSprite *coinIco4;
    CCSprite *coinIco5;
    CCSprite *coinIco6;
    
    CCSprite *coinIco11;
    CCSprite *coinIco22;
    CCSprite *coinIco33;
    CCSprite *coinIco44;
    CCSprite *coinIco55;
    CCSprite *coinIco66;
    /////////////////////////////////
    CCSprite *buyBtn1;
    CCSprite *buyBtn2;
    CCSprite *buyBtn3;
    CCSprite *buyBtn4;
    CCSprite *buyBtn5;
    CCSprite *buyBtn6;
    
    CCSprite *bonusPercent1;
    CCSprite *bonusPercent2;
    CCSprite *bonusPercent3;
    CCSprite *bonusPercent4;
    CCSprite *bonusPercent5;
    CCSprite *bonusPercent6;
    
    CCLabelBMFont *bonusLabel1;
    CCLabelBMFont *bonusLabel2;
    CCLabelBMFont *bonusLabel3;
    CCLabelBMFont *bonusLabel4;
    CCLabelBMFont *bonusLabel5;
    CCLabelBMFont *bonusLabel6;
    
    CCLabelBMFont *equal1;
    CCLabelBMFont *equal2;
    CCLabelBMFont *equal3;
    CCLabelBMFont *equal4;
    CCLabelBMFont *equal5;
    CCLabelBMFont *equal6;
    
    CCLabelBMFont *finalAmountLabel1;
    CCLabelBMFont *finalAmountLabel2;
    CCLabelBMFont *finalAmountLabel3;
    CCLabelBMFont *finalAmountLabel4;
    CCLabelBMFont *finalAmountLabel5;
    CCLabelBMFont *finalAmountLabel6;
    
    int fSizeBUY;
    int fSizeBUTTONS;
    
    int coinsAmount1;
    int coinsAmount2;
    int coinsAmount3;
    int coinsAmount4;
    int coinsAmount5;
    int coinsAmount6;
    
    int bonusP1;
    int bonusP2;
    int bonusP3;
    int bonusP4;
    int bonusP5;
    int bonusP6;
    
    int fCoinsAmount1;
    int fCoinsAmount2;
    int fCoinsAmount3;
    int fCoinsAmount4;
    int fCoinsAmount5;
    int fCoinsAmount6;

    float dis_;
    
    CCSpriteFrame *framePressed;
    CCSpriteFrame *boostFrame;
    CCSpriteFrame *closeFrame;
    
    BOOL iPhone3;
}

-(void) closeWindow;
-(void) closeBoostsWindow;

-(id)init_WithNumber:(int) nr_;


@end
