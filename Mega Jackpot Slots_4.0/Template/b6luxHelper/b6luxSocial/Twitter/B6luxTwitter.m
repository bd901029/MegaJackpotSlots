//
//  B6luxTwitter.m
//  Zombie Joe
//
//  Created by Slavian on 2013-07-11.
//
//

#import "B6luxTwitter.h"
#import "ScreenShot.h"
#import <Twitter/Twitter.h>

#import "cfg.h"

@implementation B6luxTwitter
@synthesize _screenShot,viewController;
-(void)takeScreenShot
{
    [_screenShot take];
    [_screenShot saveToDisk];
    imageName = [_screenShot pathOnDevice];
}
-(void)checkView: (ccTime *)dt
{
    if (viewController.isViewLoaded) {
//        if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//            [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//        }
        [self unschedule:@selector(checkView:)];
    }
}



-(void)tweet_withScreenShot:(BOOL)bool_ text:(NSString *)txt_
{
    if (bool_)
    {
        //[self takeScreenShot];
    }
    
//    if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG])
//    {
//        [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//    }
    [self unschedule:@selector(checkView:)];
    
    
    if ([TWTweetComposeViewController canSendTweet]) // Check if twitter is setup and reachable
    {
        TWTweetComposeViewController *tweetViewController = [[[TWTweetComposeViewController alloc] init] autorelease];
        
        // set initial text
        [tweetViewController setInitialText:txt_];
        //[tweetViewController addURL:[NSURL URLWithString:iTunesLink]];
        
        if (bool_) {
            // set initial image
           
          //  UIImage *tweeterImage = [cfg screenshotUIImage_2];
            
            //[db getScreenShot];   //[[[UIImage alloc] initWithContentsOfFile:imageName] autorelease];
            
           // [tweetViewController addImage:tweeterImage];
        }
        
        // setup completion handler
        tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        
            [viewController dismissViewControllerAnimated:YES completion:nil];
            if(result == TWTweetComposeViewControllerResultDone) {
                // the user finished composing a tweet
//                if ([parent_ isKindOfClass:[B6luxPopUpManager class]]) {
//                    int level = [parent_ performSelector:@selector(returnLevelNr)];//[parent_ returnLevelNr];
//                    [db SS_sharegame_player:[gc_ getLocalPlayerAlias] level:level type:@"twitter"];
//                    [parent_ performSelector:@selector(submitShare) withObject:nil];
//                }
                [self removeFromParentAndCleanup:YES];
            } else if(result == TWTweetComposeViewControllerResultCancelled) {
                [self removeFromParentAndCleanup:YES];
            }
        };
        
        // present view controller
       // viewController.view.tag = twiiterViewTAG;
        [[[CCDirector sharedDirector] openGLView] addSubview:viewController.view];
  
        [viewController presentViewController:tweetViewController animated:YES completion:nil];
        
    }
    else
            {
                UIAlertView *alertView = [[[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil]autorelease];
                [alertView show];
            }


}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
//        if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//            [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//        }
    }
}

- (void) onEnter
{
    [[CCDirector sharedDirector] openGLView].userInteractionEnabled = NO;
    [super onEnter];
    
}

-(void) onExit
{
    
    [self removeAllChildrenWithCleanup:YES];
    //[[[[CCDirector sharedDirector] openGLView]viewWithTag:twiiterViewTAG]removeFromSuperview];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    
    //[[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [super onExit];
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        [self schedule:@selector(checkView:)];
        viewController = [[UIViewController alloc] init];
        _screenShot = [[ScreenShot alloc]init];
	}
	return self;
}

- (void) dealloc
{
    [viewController release];
    [_screenShot release];
    viewController = nil;
    _screenShot = nil;
    [[CCDirector sharedDirector] openGLView].userInteractionEnabled = YES;
    [super dealloc];
}

@end
