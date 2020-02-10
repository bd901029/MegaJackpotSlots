//
//  CCAnimationHelper.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 06.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "ScreenShot.h"
#import "AppDelegate.h"

@implementation ScreenShot

static ScreenShot * instanceOfScreenshot;

+(id)sharedScreenshot
{
    if(instanceOfScreenshot == NULL)
        instanceOfScreenshot = [[[self alloc] init] autorelease];
    return instanceOfScreenshot;
}

@synthesize pathOnDevice, lastScreenshotName, capturedScreen;

-(id)init
{
    if((self = [super init]) != NULL)
    {
        instanceOfScreenshot = self;
        [self clearTempDir];
    }
    
    return self;
}

-(void)take
{
    //self.capturedScreen = [[CCDirector sharedDirector]screenshotUIImage];
    //[self screenshotNamingRegardingTime];
    NSString * relativePath = [NSString stringWithFormat:@"tmp/%@", lastScreenshotName];
    self.pathOnDevice = [NSHomeDirectory() stringByAppendingPathComponent:relativePath];
    CCLOG(@"image path: %@", pathOnDevice);
}

-(void)saveToDisk
{
    [UIImageJPEGRepresentation(capturedScreen,100) writeToFile:pathOnDevice atomically:YES];
    
    CCLOG(@"Screenshot - tmp contents after saving image: %@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"tmp/"] error:nil]);
}

-(void)clearTempDir
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * finalPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/"];
    NSArray *directoryContent = [fileManager contentsOfDirectoryAtPath:finalPath error:nil];
        
    for(NSString * filename in directoryContent)
    {
        NSError * error;
        NSString * pathToFile = [finalPath stringByAppendingPathComponent:filename];
        BOOL success = [fileManager removeItemAtPath:pathToFile error:&error];
        if(!success)
            CCLOG(@"Screenshot - Failed to delete file from temp...reason: %@", error);
    }
    CCLOG(@"Screenshot - tmp dir: %@ content: %@", finalPath, [fileManager contentsOfDirectoryAtPath:finalPath error:nil]);
}

-(void)screenshotNamingRegardingTime
{
    NSString * constantNaming = @"image";
    self.lastScreenshotName = [[NSString alloc] initWithFormat:@"%@%f.jpg", constantNaming, [[NSDate date] timeIntervalSince1970]];
    CCLOG(@"screenshot naming: %@", lastScreenshotName);
}

-(void)dealloc
{
    instanceOfScreenshot = nil;
    if(lastScreenshotName)
        self.lastScreenshotName = nil;
    if(pathOnDevice)
        self.pathOnDevice = nil;
    if(capturedScreen)
        self.capturedScreen = nil;
    [super dealloc];
}

@end
