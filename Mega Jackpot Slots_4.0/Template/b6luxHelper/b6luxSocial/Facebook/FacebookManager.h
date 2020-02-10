//
//  FacebookManager.h
//  Slotomania
//
//  Created by user on 12-6-27.
//  Copyright (c) 2012年 ChenYue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "cocos2d.h"

@interface FacebookManager : NSObject <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate> {
    Facebook *facebook;
    enum
    {
        CMD_SELF,
        CMD_FRIENDS,
        CMD_APP_FRIENDS,
    }   cmd;
    
    struct Info
    {
        NSString*   ID;
        NSString*   name;
        NSString*   picture;
        BOOL        inApp;
    };
    
    struct Info            myself;
    NSMutableArray* friends;
    
    CCNode *parent;
    
}

@property (nonatomic, retain) Facebook *facebook;

+ (FacebookManager*)sharedMgr;

-(void)Init;
-(void)GetSelf;
-(void)GetFriends;
-(void)GetAppFriends;
-(void)Feed:(CCNode *)sender;

@end
