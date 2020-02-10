#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <UIKit/UIKit.h>
#import "CCScrollLayer.h"
#import "LevelHelperLoader.h"

#import "PopupManager.h"
#import "SpecialBonus.h"
#import "coinsFA.h"
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface Menu : CCSprite <CCScrollLayerDelegate, CCTouchOneByOneDelegate,FBSDKAppInviteDialogDelegate>
{
    CCSpriteBatchNode *MENU_;
    
    CGRect goLeft_rect;
    CGRect goRight_rect;
    
    coinsFA *CFA;
    
    int mTYPE;
    int startPage;
    int machineTag;
    int iPageNum;
    
    float iconH1;
    float iconH2;
    
    float iconW1;
    float iconW2;
    float iconW3;
    
    int iconsScale;
    
    int numOfPages;
    int numberOfButtonsInPage;
    
    BOOL openMachine;
    BOOL goBlack;
    
    BOOL canTouch;
    
    CCSprite *goRightButton;
    CCSprite *goLeftButton;
    
    CCSprite *slotIcon;
    
    int menuTnr;

    BOOL blockArrow;
    
    CCSpriteFrame *mLocked;
    CCLabelBMFont *levelLabel;
    
    int LEVEL;
    
    BOOL iPhone3;
    SpecialBonus *SPECIAL_BONUS;

}

-(void)closeTopMenu;
-(void)closeBottomMenu;

-(void) checkFacebookButton;

-(void)coinAnimation:(int)coins;
-(void)delay;


-(id)initWithRect:(CGRect)rect type:(int)type_ level:(int)level_;

//custom

-(SpecialBonus*)GET_SPECIAL_BONUS;


@end
