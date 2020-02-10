#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cfg.h"
#import "Constants.h"

@interface PayTableWindow : CCSprite <CCTouchOneByOneDelegate>
{
    
    CCSprite *table1;
    CCSprite *table2;
    
    CCSprite *closeBtn;
    
    CCSprite *nextBtn;
    CCSprite *backBtn;
    
    NSString *tableStr_1;
    NSString *tableStr_2;
    
    BOOL     btnOn;
}

-(void) closeWindow;
-(id)init_withMachineNR:(int)mNumber_;

@end
