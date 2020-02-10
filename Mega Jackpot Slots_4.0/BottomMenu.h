#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SettingsWindows.h"

#import "PopupManager.h"

@interface BottomMenu : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *BOTTOM_MENU_;
    
    int     lines_;
    float   bet_;
    float   maxbet_;
    
    int     maxLines_;
    int     fSize;
    float   lHeight;

float btnAligment;
    
    bool    b_buttonsActive;
    
    BOOL    useBoostsOPENED;

    BOOL    iPhone3;
    
    CCLabelBMFont *MaxLinesLabel;
    CCLabelBMFont *totalB;
    CCLabelBMFont *linesLabel;
    CCLabelBMFont *betLabel;
    CCLabelBMFont *maxbetLabel;
    CCLabelBMFont *linesLab;
    
    CCLabelBMFont *count2xLabel;
    CCLabelBMFont *count3xLabel;
    CCLabelBMFont *count4xLabel;
    CCLabelBMFont *count5xLabel;
    
    CCLabelBMFont *aSpinLabelTxt;
    CCLabelBMFont *aSpinLabelNr;
    
    
    CCSprite *menu_line;
    CCSprite *lines_button;
    CCSprite *bet_button;
    CCSprite *maxbet_button;
    CCSprite *boost_button;
    CCSprite *spin_button;
    
    CCSprite *lines_field;
    CCSprite *bet_field;
    CCSprite *maxbet_field;
    
    CCSprite *boost2xBtn;
    CCSprite *boost3xBtn;
    CCSprite *boost4xBtn;
    CCSprite *boost5xBtn;
    CCSprite *buyMoreBtn;
    
    CCSprite *boost2xCounter;
    CCSprite *boost3xCounter;
    CCSprite *boost4xCounter;
    CCSprite *boost5xCounter;
    CCSprite *buyMoreCounter;
    
    CCSprite *b2xIndicator;
    CCSprite *b3xIndicator;
    CCSprite *b4xIndicator;
    CCSprite *b5xIndicator;


    BOOL gamePlay;
    bool boostButtonTap;
    //bool boostActive;
    
    int numberOfBoost;
    int numberBoostCounter;

    CCSpriteFrame *spinPress_Active;
    CCSpriteFrame *stopPress_Active;
    CCSpriteFrame *linesPress_Active;
    CCSpriteFrame *betPress_Active;
    CCSpriteFrame *maxbetPress_Active;
    CCSpriteFrame *boostsPress_Active;
    CCSpriteFrame *closePress_Active;
    
    CCSpriteFrame *spinPress_notActive;
    CCSpriteFrame *stopPress_notActive;
    CCSpriteFrame *linesPress_notActive;
    CCSpriteFrame *betPress_notActive;
    CCSpriteFrame *maxbetPress_notActive;
    CCSpriteFrame *boostsPress_notActive;
    CCSpriteFrame *closePress_notActive;
    
    
    CCSpriteFrame *x2Btn_Active;
    CCSpriteFrame *x3Btn_Active;
    CCSpriteFrame *x4Btn_Active;
    CCSpriteFrame *x5Btn_Active;
    CCSpriteFrame *buyMoreBtn_Active;
    CCSpriteFrame *closeBtn_Active;
    
    CCSpriteFrame *x2Btn_notActive;
    CCSpriteFrame *x3Btn_notActive;
    CCSpriteFrame *x4Btn_notActive;
    CCSpriteFrame *x5Btn_notActive;
    CCSpriteFrame *buyMoreBtn_notActive;
    CCSpriteFrame *closeBtn_notActive;
    
    int b2xVALUE;
    int b3xVALUE;
    int b4xVALUE;
    int b5xVALUE;

    int indicatorNr;
}

//-(id)initWithRect:(CGRect)rect type:(int)type_
-(id)initWithRect:(CGRect)rect type:(int)TYPE lines:(int)LINES maxLines:(int)MAXLINES Bet:(float)BET;
-(void) changeBoostsCounters_2xValue:(int)value2x_ _3xValue:(int)value3x_ _4xValue:(int)value4x_ _5xValue:(int)value5x_;
-(void)betArrayBetNumber:(int)BETNUMBER;

-(void)setLines:(int)linesValue;
-(void)setBet:(float)betValue;
-(void)setMaxbet:(float)maxbetValue;
-(void)setMaxLines:(int)MaxlinesValue;

-(void) openBoostsWindow;
-(void)buttonActive:(bool)bool_;

-(void)freeSpinActivation;
-(float)getCurrentBet;
-(float)getCurrentMaxBet;
-(int)getCurrentLine;
-(int)getCurrentMaxLine;
-(float)getTotalBet;
-(void)countTotalBet;
-(void) closeBUseWindow;
-(void) closeWindowBuy2;
-(void)checkAllBoostButton;

-(void) updateBoostLabels;
-(void) hideBoostsIndicator;

-(void)runAutospin;
-(void) exitAutospin;
-(void) updateSpinLeft:(int)spinLeft_;

@end
