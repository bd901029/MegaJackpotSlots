#import <UIKit/UIKit.h>
#import "cocos2d.h"

#define k_APPORIENTATION_PORTRAIT NO

#define ScreenSize [CCDirector sharedDirector].winSize

#define IS_IPHONE   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 (IS_IPHONE && IS_HEIGHT_GTE_568)

#define WIDTH_P_IPAD 768
#define HEIGHT_P_IPAD 1024
#define HEIGHT_L_IPAD 768
#define WIDTH_L_IPAD 1024

#define HEIGHT_P_IPHONE_5   568
#define WIDTH_P_IPHONE_5    320
#define WIDTH_L_IPHONE_5    568
#define HEIGHT_L_IPHONE_5   320

#define WIDTH_P_IPHONE  320
#define HEIGHT_P_IPHONE 480
#define HEIGHT_L_IPHONE 320
#define WIDTH_L_IPHONE  480

#define BRAIN_BONUS_TAG 8001
#define ALIGATOR_MONSTER 2000


