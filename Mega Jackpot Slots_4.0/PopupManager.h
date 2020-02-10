#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SpecialBonus.h"


@interface PopupManager : CCSprite <CCTouchOneByOneDelegate>
{

    BOOL B1Position;
    BOOL B2Position;
    
    BOOL btnPressed;
    
    SpecialBonus *BonusMenu;
    
    int buyNumber;
}

-(id)initWithRect:(CGRect)rect;
-(void)setUp:(int) PopWindowNR someValue:(int)value_;

-(void) openSettingsWindow;
-(void) closePayTableWindow;
-(void) closeBuyWindow;
-(void) closeUseBoostWindow;
-(void) closeWinWindow;
-(void) closeLvlWindow;
-(void) openPayTableWindow;

-(void) openSBonusWindow;
-(void) hideSBonusWindow;
-(void) openFreeCoinsWindow;
-(void)musicPopWindow;

-(void)B1Pos;
-(void)B2Pos;
-(void)B1Pos2;
-(void)B2Pos2;

-(void)removeBlackBG;

//custom

-(SpecialBonus*)GET_SPECIALBONUS;

@end
