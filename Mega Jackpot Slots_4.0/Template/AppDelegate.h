//
//  AppDelegate.h
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "SpecialBonus.h"
#import <Chartboost/Chartboost.h>

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate, ChartboostDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
	
	CCDirectorIOS	*director_;							// weak ref
    
    SpecialBonus *SB;
    
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic) BOOL showedLaunchAD;
-(void) showInHouseAdWithID: (int)iD;
-(void)setSPECIALBONUS:(SpecialBonus*)sb_;
-(BOOL)inMenu;

-(SpecialBonus*)getSpecialBonus;

-(void)setLocalPush:(NSDate*)date withText:(NSString*)text_ value:(NSString*)value_ forKey:(NSString*)key_;

@end
