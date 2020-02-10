//
//  B6luxTwitter.h
//  Zombie Joe
//
//  Created by Slavian on 2013-07-11.
//
//
#import <UIKit/UIKit.h>
#import "ScreenShot.h"
#import "cocos2d.h"

/*
 
 WARINIG !
 
 Twitter :
 
 a) Add Twitter framework;
 
 
 
 */

@interface B6luxTwitter : CCLayer<UIAlertViewDelegate>
{
    NSString *imageName;
    UIViewController *viewController;
    ScreenShot *_screenShot;
    NSTimer *timer;
}
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) ScreenShot *_screenShot;

-(void)takeScreenShot;
-(void)tweet_withScreenShot:(BOOL)bool_ text:(NSString *)txt_;
@end
