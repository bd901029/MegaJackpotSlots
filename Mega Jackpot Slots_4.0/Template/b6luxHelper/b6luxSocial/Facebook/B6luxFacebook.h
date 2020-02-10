//
//  B6luxFacebook.h
//  Zombie Joe
//
//  Created by Slavian on 2013-07-12.
//
//

/*

 WARINIG !
 
 Facebook :
 
    a) BuildSettings->Build active architecture only -> YES
    b) FW->Social(Optional);
 
 
 
*/


#import <UIKit/UIKit.h>
#import "ScreenShot.h"
#import "cocos2d.h"

@interface B6luxFacebook : CCLayer<UIAlertViewDelegate>
{
    NSString *imageName;
    UIViewController *viewController;
    ScreenShot *_screenShot;
}
@property (nonatomic, retain) UIViewController *viewController;
@property (nonatomic, retain) ScreenShot *_screenShot;

-(void)takeScreenShot;
-(void)share_withScreenShot:(BOOL)bool_ text:(NSString *)text url:(NSString*)url_;
@end