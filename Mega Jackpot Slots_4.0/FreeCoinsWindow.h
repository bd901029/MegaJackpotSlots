//
//  FreeCoinsWindow.h
//  Fun Vegas Slots
//
//  Created by Orban Balazs on 24/02/16.
//  Copyright © 2016 bsixlux. All rights reserved.
//

#import "CCSprite.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cfg.h"
#import "Constants.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <MessageUI/MessageUI.h>


@interface FreeCoinsWindow : CCSprite <CCTouchOneByOneDelegate,FBSDKAppInviteDialogDelegate,FBSDKSharingDelegate, MFMailComposeViewControllerDelegate>{


    CCSprite *bg;
    
    CCSprite *FBInvite;
    CCSprite *FBShare;
    CCSprite *TwitterShare;
    CCSprite *WatchVid;
    CCSprite *emailFriend;
    
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


