#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TopMenu.h"
#import <MessageUI/MessageUI.h>

@interface SettingsWindows : CCSprite <CCTouchOneByOneDelegate, MFMailComposeViewControllerDelegate>
{
    CCSpriteBatchNode *SETTINGS_MENU_;
    
    CCLabelBMFont *developedByLabel;
    CCLabelBMFont *b6luxLabel;
    CCLabelBMFont *codeLabel;
    CCLabelBMFont *artLabel;
    CCLabelBMFont *toolsLabel;
    CCLabelBMFont *cocos2dLabel;
    CCLabelBMFont *eLabel;
    CCLabelBMFont *mLabel;
    CCLabelBMFont *sLabel;
    CCLabelBMFont *jLabel;
    
    CCLabelBMFont *musicLabel;
    CCLabelBMFont *soundLabel;
    CCLabelBMFont *onLabel;
    CCLabelBMFont *offLabel;
    CCLabelBMFont *on2Label;
    CCLabelBMFont *off2Label;
    CCLabelBMFont *menuLabel;
    CCLabelBMFont *showLBlabel;
    CCLabelBMFont *showAClabel;
    CCLabelBMFont *aboutButtonLabel;
    CCLabelBMFont *ContactUs;
    
    CCLabelBMFont *autoSpinLabel;
    
    CCSprite *background;
    
    CCSprite *closeBtn;
    
    CCSprite *slideBg1;
    CCSprite *slideBg2;
    
    CCSprite *button1;
    CCSprite *button2;
    CCSprite *button3;
    
    CCSprite *show_LeaderBoardButton;
    CCSprite *show_AchievementsButton;
    CCSprite *show_AboutButton;
    CCSprite *autoSpinButton;
    
    CCSpriteFrame *Btn_Active;
    CCSpriteFrame *Btn_notActive;
    CCSpriteFrame *Btn_Active2;
    CCSpriteFrame *Btn_notActive2;
    CCSpriteFrame *closeBtn_Active;
    CCSpriteFrame *closeBtn_notActive;
    
    BOOL B1on;
    BOOL B2on;
    BOOL B3on;
    BOOL onAbout;
    
    int state__;
    
    BOOL b1;
    BOOL b2;
    BOOL b3;
    BOOL b4;
    BOOL b5;
    BOOL b6;
    BOOL b7;
    BOOL b15;
    
    
    BOOL iPhone3;

}

-(void)setUp:(int)state;
-(void)closeSettingsWindow2;
-(void)saveSoundInfo;


@end
