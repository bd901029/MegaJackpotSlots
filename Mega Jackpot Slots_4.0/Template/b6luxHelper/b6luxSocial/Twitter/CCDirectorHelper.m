//
//  CCAnimationHelper.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 06.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CCDirectorHelper.h"

@implementation CCDirector (Helper)

- (UIImage*) screenshotUIImage {

//    CGImageRef UIGetScreenImage(void);
//	//CGImageRef screen = UIGetScreenImage();
//    UIImage *screenImage = [UIImage imageWithCGImage:screen scale:1.0f orientation:[self interfaceOrientation]];
//    CGImageRelease(screen);
    
  //  return screenImage;
    return nil;
}

-(UIInterfaceOrientation *) interfaceOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        return UIInterfaceOrientationPortraitUpsideDown;}
    else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationMaskLandscapeRight){
        return UIInterfaceOrientationLandscapeRight;}

    return UIInterfaceOrientationLandscapeLeft;
}

- (CCTexture2D*) screenshotTexture {
	return [[[CCTexture2D alloc] initWithImage:[self screenshotUIImage]] autorelease];
};

@end
