//
//  B6luxFacebook.m
//  Zombie Joe
//
//  Created by Slavian on 2013-07-12.
//
//

#import "B6luxFacebook.h"
#import "ScreenShot.h"
#import <Social/Social.h>
#import "cfg.h"

@implementation B6luxFacebook
@synthesize viewController,_screenShot;

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

-(void)share_withScreenShot:(BOOL)boolPhoto_ text:(NSString*)text url:(NSString*)url_
{
    if (boolPhoto_) {
        [self takeScreenShot];
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) // Check if twitter is setup and reachable
    {
        //SLComposeViewController *shareViewController = [[SLComposeViewController alloc] init];
        SLComposeViewController *slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        // set initial text
        [slComposeViewController setInitialText:text];
        
        if (boolPhoto_) {
            // set initial image
           // UIImage *facebookImage = [cfg screenshotUIImage_2];//[[[UIImage alloc] initWithContentsOfFile:imageName] autorelease];
            
           // [slComposeViewController addImage:facebookImage];
        }
        [slComposeViewController addURL:[NSURL URLWithString:url_]];
       
        // setup completion handler
        slComposeViewController.completionHandler = ^(SLComposeViewControllerResult result) {
            
            if(result == SLComposeViewControllerResultDone) {
//                if ([parent_ isKindOfClass:[B6luxPopUpManager class]]) {
//                    [parent_ performSelector:@selector(smoothRemove) withObject:nil];
//                    
//                }
                [self removeFromParentAndCleanup:YES];
                //Save Share status
                
            } else if(result == SLComposeViewControllerResultCancelled) {
                
                   [self removeFromParentAndCleanup:YES];
                
            }
            [viewController dismissViewControllerAnimated:YES completion:nil];
        };
        
        // present view controller
      //  viewController.view.tag = facebookViewTAG;
        [[[CCDirector sharedDirector] openGLView] addSubview:viewController.view];
        
        [viewController presentViewController:slComposeViewController animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alertView = [[[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a post right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil]autorelease];
        [alertView show];
    }
    
    
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
//        if ([[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//            [[[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]removeFromSuperview];
//        }
    }
}

- (void) onEnter
{
    [super onEnter];
}

-(void) onExit
{
    [self removeAllChildrenWithCleanup:YES];
    //[[[[CCDirector sharedDirector] openGLView]viewWithTag:facebookViewTAG]removeFromSuperview];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    
    //[[CCTextureCache sharedTextureCache] removeUnusedTextures];
    
    [super onExit];
}


- (void) dealloc
{
    [viewController release];
    [_screenShot release];
    viewController = nil;
    _screenShot = nil;
    
    [super dealloc];
}

@end

