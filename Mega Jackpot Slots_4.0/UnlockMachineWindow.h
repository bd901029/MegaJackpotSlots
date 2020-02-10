//
//  UnlockMachineWindow.h
//  Template
//
//  Created by Slavian on 2013-10-29.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UnlockMachineWindow : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *POPUP_IMG;
    CCSprite            *lvlBackground;
    CCSprite            *OKbutton;
    CCSprite            *leds;
    CCSpriteFrame       *Btn_Active;
    CCSpriteFrame       *Btn_notActive;
    
    bool animEnd;
    
}
-(id)init_with_MN:(int)mn;
@end
