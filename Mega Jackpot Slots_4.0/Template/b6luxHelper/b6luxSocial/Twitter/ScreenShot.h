//
//  CCAnimationHelper.h
//  SpriteBatches
//
//  Created by Steffen Itterheim on 06.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CCDirectorHelper.h"

@interface ScreenShot:CCNode{
    
    NSString * pathOnDevice;
    UIImage * capturedScreen;
    NSString * lastScreenshotName;
}

@property(retain) NSString * pathOnDevice;
@property(retain) UIImage * capturedScreen;
@property(retain) NSString * lastScreenshotName;

+(id)sharedScreenshot;
-(void)take;
-(void)saveToDisk;
-(void)clearTempDir;
-(void)screenshotNamingRegardingTime;

@end
